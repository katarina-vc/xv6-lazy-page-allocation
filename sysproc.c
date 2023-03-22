#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

//JTM - Implement system calls for priority scheduler
int
sys_set_sched_priority(void){
  int priority;
  
  if(argint(0, &priority) < 0){
    return -1;
  }
  
  set_sched_priority(priority);
  return 0;
}


// AI - Implement system calls for FIFO scheduler 
int
sys_fifo_position(void)
{
	int pid;
	if(argint(0, &pid) < 0)
		return -1;

	return fifo_position(pid);
}



int
sys_get_sched_priority(void){
  int pid;

  if(argint(0, &pid) < 0){
    return -1;
  }

  return get_sched_priority(pid);
}

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
  //JTM - Old implementation of sbrk
  /*
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
  */

  //JTM - New implementation of sbrk for lazy page allocation
  
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;

  addr = myproc()->sz;
  
  myproc()->sz = myproc()->sz + n;

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

int
sys_time_scheduled(void)
{
  int processId;
  // Check for a valid arg passed in, if not just return -1 because something went wrong
  if (argint(0, &processId) < 0) {
    return -1;
  }
  // call proc.c func printProcessTime to actually do the thing
	return printProcessTime(processId);
}

void 
sys_printProcessTable(void)
{
  int processId;
  // Check for a valid arg passed in, if not just return -1 because something went wrong
  if (argint(0, &processId) < 0) {
    exit();
  }
  // call proc.c func printProcessTable to actually do the thing
	printProcessTable(processId);
}

