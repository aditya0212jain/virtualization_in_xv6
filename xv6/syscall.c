#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "syscall.h"
#include<stdio.h>


/////Defined on 8th Feb for systrace
int syscall_trace[45]={0};
char numToCall[45][30] = {
      "random",
      "sys_fork",
      "sys_exit",
      "sys_wait",
      "sys_pipe",
      "sys_read",
      "sys_kill",
      "sys_exec",
      "sys_fstat",
      "sys_chdir",
      "sys_dup",
      "sys_getpid",
      "sys_sbrk",
      "sys_sleep",
      "sys_uptime",
      "sys_open",
      "sys_write",
      "sys_mknod",
      "sys_unlink",
      "sys_link",
      "sys_mkdir",
      "sys_close",
      "sys_toggle",
      "sys_add",
      "sys_ps",
      "sys_send",
      "sys_recv",
      "sys_print_count",
      "sys_send_multi",
      "sys_signal",
      "sys_sigraise",
      "sys_halt",
      "sys_recv_multi",
      "sys_change_state",
      "sys_create_container",
      "sys_destroy_container",
      "sys_join_container",
      "sys_leave_container",
      "sys_scheduler_log_on",
      "sys_scheduler_log_off",
      "sys_container_malloc",
      "sys_memory_log_on",
      "sys_memory_log_off",
      "sys_get_file_container_id",
      "sys_get_container_id"
};
int sys_trace=0;//change this before submission
//////////////////////////////


// User code makes a system call with INT T_SYSCALL.
// System call number in %eax.
// Arguments on the stack, from the user call to the C
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
  *ip = *(int*)(addr);
  return 0;
}

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}

// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}

extern int sys_chdir(void);
extern int sys_close(void);
extern int sys_dup(void);
extern int sys_exec(void);
extern int sys_exit(void);
extern int sys_fork(void);
extern int sys_fstat(void);
extern int sys_getpid(void);
extern int sys_kill(void);
extern int sys_link(void);
extern int sys_mkdir(void);
extern int sys_mknod(void);
extern int sys_open(void);
extern int sys_pipe(void);
extern int sys_read(void);
extern int sys_sbrk(void);
extern int sys_sleep(void);
extern int sys_unlink(void);
extern int sys_wait(void);
extern int sys_write(void);
extern int sys_uptime(void);
extern int sys_toggle(void);// sys_toggle added
extern int sys_add(void);//sys_add for two integers added
extern int sys_ps(void);//sys_ps for printing process
extern int sys_send(void);//sys_send
extern int sys_recv(void);//receiver
extern int sys_print_count(void);//for printing syscalls count
extern int sys_send_multi(void);
extern int sys_signal(void);
extern int sys_sigraise(void);
extern int sys_halt(void);
extern int sys_recv_multi(void);
extern int sys_change_state(void);
extern int sys_create_container(void);
extern int sys_destroy_container(void);
extern int sys_join_container(void);
extern int sys_leave_container(void);
extern int sys_scheduler_log_on(void);
extern int sys_scheduler_log_off(void);
extern int sys_container_malloc(void);
extern int sys_memory_log_on(void);
extern int sys_memory_log_off(void);
extern int sys_get_file_container_id(void);
extern int sys_get_container_id(void);

static int (*syscalls[])(void) = {
[SYS_fork]    sys_fork,
[SYS_exit]    sys_exit,
[SYS_wait]    sys_wait,
[SYS_pipe]    sys_pipe,
[SYS_read]    sys_read,
[SYS_kill]    sys_kill,
[SYS_exec]    sys_exec,
[SYS_fstat]   sys_fstat,
[SYS_chdir]   sys_chdir,
[SYS_dup]     sys_dup,
[SYS_getpid]  sys_getpid,
[SYS_sbrk]    sys_sbrk,
[SYS_sleep]   sys_sleep,
[SYS_uptime]  sys_uptime,
[SYS_open]    sys_open,
[SYS_write]   sys_write,
[SYS_mknod]   sys_mknod,
[SYS_unlink]  sys_unlink,
[SYS_link]    sys_link,
[SYS_mkdir]   sys_mkdir,
[SYS_close]   sys_close,
[SYS_toggle]  sys_toggle,
[SYS_add]     sys_add,
[SYS_ps]      sys_ps,
[SYS_send]    sys_send,
[SYS_recv]    sys_recv,
[SYS_print_count] sys_print_count,
[SYS_send_multi]  sys_send_multi,
[SYS_signal]  sys_signal,
[SYS_sigraise] sys_sigraise,
[SYS_halt]    sys_halt,
[SYS_recv_multi] sys_recv_multi,
[SYS_change_state] sys_change_state,
[SYS_create_container] sys_create_container,
[SYS_destroy_container] sys_destroy_container,
[SYS_join_container] sys_join_container,
[SYS_leave_container] sys_leave_container,
[SYS_scheduler_log_on] sys_scheduler_log_on,
[SYS_scheduler_log_off] sys_scheduler_log_off,
[SYS_container_malloc] sys_container_malloc,
[SYS_memory_log_on] sys_memory_log_on,
[SYS_memory_log_off] sys_memory_log_off,
[SYS_get_file_container_id] sys_get_file_container_id,
[SYS_get_container_id] sys_get_container_id,
};



void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
  

  //tf is the trapframe for the syscall
  //eax is a register value
  num = curproc->tf->eax;
  if(sys_trace==1){
    syscall_trace[num]+=1;
  }
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
