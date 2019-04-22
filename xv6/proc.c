#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

struct spinlock procbuffer_lock[NPROC];

int scheduler_logger = 0;

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
  for(int i=0;i<NPROC;i++){
    initlock(&procbuffer_lock[i],"procbuffer");
  }
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//

void ignoreHandler(void){
	cprintf("this is ignore Handler\n");
}

void killHandler(void){
  struct proc *curproc = myproc();
  release(&ptable.lock);
	kill(curproc->pid);
	acquire(&ptable.lock);
}

void dflHandler(void){
  cprintf("This is default handler\n");
}

void receiverHandler(void){
  char* p;
  char temp_junk;
  p = &temp_junk;
  int recvCode = -1;
  recvCode = receive_msg(myproc()->pid,(void *)p);
  // recvCode = myproc()->pid;
  cprintf("%d\n",recvCode);
  if(recvCode<0){
    cprintf("Error is receiving message\n");
  }else{
    cprintf("Message : %s\n",p);
  }
  cprintf("this is the default handler for receiving messages\n");
  return;
}

// void
// change_space(sighandler_t sighandler)
// {

//   struct proc *curproc = myproc();
//   char* vir_addr = uva2ka(curproc->pgdir, (char*)curproc->tf->esp);
//   // if ((curproc->tf->esp & 0xFFF) == 0){
//   //   panic("esp_offset == 0");
//   // }
    

//   *(int*)(vir_addr + ((curproc->tf->esp - 4) & 0xFFF)) = curproc->tf->eip;
  
//   curproc->tf->esp -= 4;

//   curproc->tf->eip = (uint)sighandler;
// }

//
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  for(int i=0;i<NSIG;i++){
    p->pendingSignals[i] = 0;
    p->signalHandlers[i] = (sighandler_t) SIGIGN;
  }
  p->signalHandlers[SIGMSGSENT] = (sighandler_t) SIGMSGSENT;
  MessageBuffer temp;
  for(int i=0;i<MessageSize;i++){
    temp[i] = 0;
    *(p->msg_from_multicast+i) = *(temp+i);
  }
  // p->msg_from_multicast = temp;
  p->container_id = 0;//zero for all access
  // p->v_state = V_EMBRYO;  

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
   
  sighandler_t tempHandler;
  // int itemp = 0;


  for(;;){
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    int cid = get_container_to_run();
    int* container_processes = get_container_processes_to_run(cid);
    int last_process = get_container_last_process(cid);
    // cprintf("container_to_run : %d\n",cid);
    acquire(&ptable.lock);
    int count = 0;
    last_process = (last_process+1)%NPROC;
    while(count<NPROC){
      p = &ptable.proc[last_process];
      if(p->state != RUNNABLE){
        count++;
        last_process = (last_process+1)%NPROC;
        continue;
      }

      if(container_processes[p->pid]==0 && p->container_id!=0){
        count++;
        last_process = (last_process+1)%NPROC;
        continue;
      }
      //if process runnable and has container id 0 then run it no matter what
      //else if process is runnable and is not in current container then go for next
      

      if(scheduler_logger==1 ){//p->container_id!=0 && 
        cprintf("Container + %d : Scheduling process + %d\n",cid,p->pid);
      }

      set_last_process_of_container(last_process,cid);
      c->proc = p;
      int *a2;
      char* virtual_address;
      for(int i=0;i<NSIG;i++){
        if(p->pendingSignals[i]>0){
          // cprintf("i is %d and handler is %d\n", i,(int)p->signalHandlers[i] );
          switch ((int)p->signalHandlers[i])
          {
            case SIGIGN:
              tempHandler = ignoreHandler;
              (*tempHandler)();
              p->pendingSignals[i] = 0;
              break;
            case SIGDFL:
              tempHandler = dflHandler;
              (*tempHandler)();
              p->pendingSignals[i] = 0;
              break;
            case SIGMSGSENT:
              tempHandler = receiverHandler;
              (*tempHandler)();
              p->pendingSignals[i] = 0;
              break;
            default:

              virtual_address = uva2ka(p->pgdir, (char*)p->tf->esp);
              // if ((curproc->tf->esp & 0xFFF) == 0){
              //   panic("esp_offset == 0");
              // }
                
              
              a2 = (int *) (virtual_address + ((p->tf->esp -4) &0xFFF) );
              *a2 = p->tf->eip;
              
              p->tf->esp -= 4;

              p->tf->eip = (uint)p->signalHandlers[i];
              // change_space(p->signalHandlers[i]);
              // p->signalHandlers[i] = (sighandler_t) SIGDFL;
              p->pendingSignals[i] = 0;
              break;
          }
        }
      }
      switchuvm(p);
      p->state = RUNNING;
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
      break;
    }
    // for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    //   if(p->state != RUNNABLE)
    //     continue;

    //   // Switch to chosen process.  It is the process's job
    //   // to release ptable.lock and then reacquire it
    //   // before jumping back to us.
    //   c->proc = p;
    //   /*
    //   signal handling now in between these lines
    //   */      
    //  int *a2;
    //  char* virtual_address;
    //   for(int i=0;i<NSIG;i++){
    //     if(p->pendingSignals[i]>0){
    //       // cprintf("i is %d and handler is %d\n", i,(int)p->signalHandlers[i] );
    //       switch ((int)p->signalHandlers[i])
    //       {
    //         case SIGIGN:
    //           tempHandler = ignoreHandler;
    //           (*tempHandler)();
    //           p->pendingSignals[i] = 0;
    //           break;
    //         case SIGDFL:
    //           tempHandler = dflHandler;
    //           (*tempHandler)();
    //           p->pendingSignals[i] = 0;
    //           break;
    //         case SIGMSGSENT:
    //           tempHandler = receiverHandler;
    //           (*tempHandler)();
    //           p->pendingSignals[i] = 0;
    //           break;
    //         default:

    //           virtual_address = uva2ka(p->pgdir, (char*)p->tf->esp);
    //           // if ((curproc->tf->esp & 0xFFF) == 0){
    //           //   panic("esp_offset == 0");
    //           // }
                
              
    //           a2 = (int *) (virtual_address + ((p->tf->esp -4) &0xFFF) );
    //           *a2 = p->tf->eip;
              
    //           p->tf->esp -= 4;

    //           p->tf->eip = (uint)p->signalHandlers[i];
    //           // change_space(p->signalHandlers[i]);
    //           // p->signalHandlers[i] = (sighandler_t) SIGDFL;
    //           p->pendingSignals[i] = 0;
    //           break;
    //       }
    //     }
    //   }
    //   switchuvm(p);
    //   p->state = RUNNING;
    //   swtch(&(c->scheduler), p->context);
    //   switchkvm();

    //   // Process is done running for now.
    //   // It should have changed its p->state before coming back.
    //   c->proc = 0;
    // }
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

//CUSTOM -------------------------------------------------------------------------------------------------------------------------------------------

void 
print_ps(int cid)
{
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state != UNUSED && p->container_id == cid)
      cprintf("pid:%d name:%s\n",p->pid,p->name);
  release(&ptable.lock);
}

int
sleep_receiver(void)
{
  // cprintf("calling sleep %d \n",myproc()->pid);
  acquire(&ptable.lock);
  sleep((void *)myproc()->pid,&ptable.lock);
  release(&ptable.lock);
  return 0;
}

int
signal(int signal_number, sighandler_t handler){
  if(signal_number>=0 && signal_number<NSIG){
    // struct cpu *c = mycpu();
    // cprintf("inside signal call \n");
    // cprintf("signal : %d  , handler : %d  and pid : %d \n",signal_number,(int)handler,myproc()->pid);
    myproc()->signalHandlers[signal_number] = handler;
    // c->proc->signalHandlers[signal_number] = handler;
  }else{
    return -1;
  }
  return 0;
}

int
sigraise(int pid, int signal_number){
  // struct cpu *c = mycpu();
  struct proc *p;
	int flag = 0; //flaging if we broke the loop, if we didn't, pid does not exist
	acquire(&ptable.lock);
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
		if (p->pid == pid){
			flag = 1;
			break;
		}
	}
	
	if (flag == 0){
		release(&ptable.lock);
		return -1;
	}
  // cprintf("inside sigraise\n");
  // cprintf("signal : %d and pid : %d should be %d \n", signal_number , p->pid,pid);
	p->pendingSignals[signal_number] = 1;
	
	release(&ptable.lock);
  return 0;
}

int
sent_to_proc_buffer(int s_pid,int r_pid,void *msg)
{
    acquire(&procbuffer_lock[r_pid]);
    struct proc *p;
    acquire(&ptable.lock);

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
      if(p->pid == r_pid)
        break;

    int *temp_msg;
    temp_msg = (int *)msg;
    // acquire(&message_buffer_lock[msg_no]);
    
    for(int i=1;i<MessageSize;i++){
        // cprintf("%d: %d\n",i,*(temp_msg+i));
        *(p->msg_from_multicast+i) = *(temp_msg+i-1);
    }
    release(&ptable.lock);
    release(&procbuffer_lock[r_pid]);
    return 0;
}

int
receive_from_procbuffer(int myid,void* msg)
{
  acquire(&procbuffer_lock[myid]);
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
      if(p->pid == myid)
        break;
    
    int *temp_msg;
    temp_msg = (int *)msg;
    
    for(int i=1;i<MessageSize;i++){
        // cprintf("receiving %d: %d\n",i,*(p->msg_from_multicast+i));
         *(temp_msg+i-1) = *(p->msg_from_multicast+i);
    }

  release(&ptable.lock);
  release(&procbuffer_lock[myid]);    
    return 0;
}

int 
destroy_container_processes(int pid,int a,int pcid)
{
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if( p->container_id == a && p->pid != pid){
      kill(p->pid);
    }
  }
  release(&ptable.lock);
  if(pcid == a ){
    kill(pid);
  }
  return 0;
}

void
set_scheduler_logger(int a)
{
  scheduler_logger = a;
}