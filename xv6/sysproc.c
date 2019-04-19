#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int memory_log = 0;

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


///Implementing sys_toggle to enable or disable the 
//printing of sys_trace on sys_calls
//done on 11 February 2019
void 
sys_toggle(void)
{
  if(sys_trace==0){
    for(int i =0;i<34;i++){
      syscall_trace[i] = 0;
    }
    sys_trace = 1;
  }else{
    sys_trace = 0;
  }
}

void
sys_print_count(void)
{
    for(int i=1;i<34;i++){
      if(syscall_trace[i]!=0){
        cprintf("%s %d\n",numToCall[i],syscall_trace[i]);
      }
    }
}

int
sys_add(void)
{
  int a,b;
  argint(0, &a);
  argint(1,&b);
  int t;
  t = a+b;
  return t;
}

int 
sys_ps(void)
{
  print_ps(myproc()->container_id);
  return 0;
}

int 
sys_halt(void)
{
  outb(0xf4, 0x00);
  return 0;
}

int
sys_send(void)
{
  int sender_pid,rec_pid;
  char* p;
  argint(0,&sender_pid);
  argint(1,&rec_pid);
  argptr(2,&p,8);
  int sendCode = send_message(sender_pid,rec_pid,(void *)p);
  // cprintf("Waking up %d \n",rec_pid);
  wakeup((void *)rec_pid);//waking up the receiver
  return sendCode;
}

int sys_recv(void)
{
  char* p;
  argptr(0,&p,8);
  int recvCode = -1;
  if(isReceiverQueueEmpty(myproc()->pid)==1){
    // cprintf("Sleeping %d\n",myproc()->pid);
    sleep_receiver();//put reciever in sleeping position
    recvCode = receive_msg(myproc()->pid,(void *)p);
    // cprintf("receiving code is %d for pid %d\n ",recvCode,myproc()->pid);
  }else{
    recvCode = receive_msg(myproc()->pid,(void *)p);
  }
  return recvCode;
}

int
sys_change_state(void)
{
  int a;
  argint(0,&a);
  if(a==0){
    //block
    sleep_receiver();
  }else{
    //unblock
    wakeup((void *)myproc()->pid);
  }
  return 0;
}

int
sys_send_multi(void)
{
  int sender_pid;
  int *rec_pid;
  char *msg_temp,*rec_temp;
  int len;
  argint(0,&sender_pid);
  argint(3,&len);
  argptr(1,&rec_temp,len);
  argptr(2,&msg_temp,MessageSize);
  rec_pid = (int *)rec_temp;
  int sendCode[len];
  int interruptCode[len];
  int flag = 0;
  // cprintf("Inside multi len : %d \n",len);
  for(int i=0;i<len;i++){
    // cprintf("rec[%d] : %d",i,rec_pid[i]);
    sendCode[i] = sent_to_proc_buffer(sender_pid,rec_pid[i],(void *)msg_temp);
    // sendCode[i] = send_message(sender_pid,rec_pid[i],(void *)msg_temp);
    interruptCode[i] = sigraise(rec_pid[i],SIGMSGSENT);
    if( sendCode[i]<0 || interruptCode[i]<0 ){
      flag = -1;
    }
  }
  return flag;
}

int sys_recv_multi(void)
{
  char* p;
  argptr(0,&p,8);
  int recvCode = -1;
  // if(isReceiverQueueEmpty(myproc()->pid)==1){
  //   // cprintf("Sleeping %d\n",myproc()->pid);
  //   sleep_receiver();//put reciever in sleeping position
  //   recvCode = receive_msg(myproc()->pid,(void *)p);
  //   // cprintf("receiving code is %d for pid %d\n ",recvCode,myproc()->pid);
  // }else{
  //   recvCode = receive_msg(myproc()->pid,(void *)p);
  // }
  recvCode = receive_from_procbuffer(myproc()->pid,(void *)p);
  return recvCode;
}


//assigning handler to process  with pid
int
sys_signal(void)
{
  int signummer;
	int handler;
	if (argint(0, &signummer) < 0)
		return -1;
	if (argint(1, &handler) <0)
		return -1;
	// cprintf("sign is : %d and handler is : %d \n",signummer , handler);
	int ans = signal(signummer, (sighandler_t) handler);
  return ans;
}

int sys_sigraise(void)
{
  int to,signummer;
  argint(0,&to);
  argint(1,&signummer);
  int ans = sigraise(to,signummer);
  return ans;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// For Assignment 3
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int 
sys_create_container(void)
{
  int a = get_container();
  return a;
}

int 
sys_destroy_container(void)
{
  int container_id;
  argint(0,&container_id);
  destroy_container_kernel(container_id);
  destroy_container_processes(myproc()->pid,container_id,myproc()->container_id);
  return 0;
}

int 
sys_join_container(void)
{
  int container_id;
  argint(0,&container_id);
  myproc()->container_id = container_id;
  int stat  = set_process_to_container(myproc()->pid,container_id);
  return stat;
}

int 
sys_leave_container(void)
{
  if(myproc()->container_id==0){
    return -1;
  }
  int stat = remove_process_from_container(myproc()->pid,myproc()->container_id);
  myproc()->container_id = 0;/// <-------- Check this line for specs
  return stat;
}

int 
sys_scheduler_log_on(void)
{
  set_scheduler_logger(1);
  return 0;
}

int
sys_scheduler_log_off(void)
{
  set_scheduler_logger(0);
  return 0;
}

char*
sys_container_malloc(void)
{
  int units;
  argint(0,&units);
  int t;
  if(units<4096){
    char* addr = get_space_in_container(myproc()->container_id,units,&t);
    if(memory_log==1){
      cprintf("Container %d : GVA %d -> HVA %p\n",myproc()->container_id,t,addr);
    }
    return addr;
  }else{
    return (char*)-1;
  }
  // void* t = &a;
  
}

int 
sys_memory_log_on(void)
{
  memory_log = 1;
  return 0;
}

int 
sys_memory_log_off(void)
{
  memory_log = 0;
  return 0;
}