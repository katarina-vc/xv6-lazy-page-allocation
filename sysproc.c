#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

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

int
sys_time_scheduled(void)
{
	struct proc *p;
	sti();
	acquire(&ptable.lock);
	cprintf("PID\tSTATE\n");
	for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
		if(p->state != UNUSED){
			cprintf("%d\t", p->pid);
			switch(p->state) {
				case UNUSED:
					cprintf("UNUSED\n");
					break;
				case EMBRYO:
					cprintf("EMBRYO\n");
					break;
				case SLEEPING:
					cprintf("SLEEPING\n");
					break;
				case RUNNING:
					cprintf("RUNNING\n");
				case RUNNABLE:
					cprintf("RUNNABLE\n");
					break;
				case ZOMBIE:
					cprintf("ZOMBIE\n");
					break;
			}
		}
	}
	release(&ptable.lock);
	return myproc()->pUptime;
}

