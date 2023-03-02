#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "syscall.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

//JTM - Define global constants for the number of priority levels & the default priority level.
//Lower number = Higher priority (meaning 1 is the highest priority, NUM_PRIORITY_LEVELS is the lowest priority.
const int NUM_PRIORITY_LEVELS = 10;
const int DEFAULT_PRIORITY = NUM_PRIORITY_LEVELS / 2;

//JTM - Define these functions with the attribute noreturn
void defaultScheduler(void)  __attribute__((noreturn));
void priorityScheduler(void)  __attribute__((noreturn));

// AI - Define this function with the attribute noreturn 
void fifoScheduler(void) __attribute__((noreturn));

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// KVC: Added Uptime function here so that I can access it when we print out the pTable
int
processUptime(void)
{
	uint xticks;
	acquire(&tickslock);
	xticks = ticks;
	release(&tickslock);
	return xticks;
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
  p->pStartTime = 0; // Initialize the process's start uptime to 0
  p->pEndTime = 0;   // Initialize the process's end uptime to 0
  p->pUptime = 0;    // Initialize the process's total uptime to 0
		    

  //JTM - Set default process priority
#ifdef PRIORITY
  p->priority = DEFAULT_PRIORITY;
#endif

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

  //JTM - Also establish first process's priority
  p->priority = 1;

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

// JTM - Begin Priority Scheduler implementation

void
priorityScheduler(void){

	cprintf("Using the PRIORITY scheduler...\n");

	// Define necessary structures
	struct proc *p;
	struct cpu *c = mycpu();
 	c->proc = 0;
  
  	for(;;){
    		// Enable interrupts on this processor
    		sti();

		// Define local variables holding the highest priority & pid
		int highestPriority = NUM_PRIORITY_LEVELS;
		struct proc *highestPriorityProcess;

    		// Acquire process table lock
    		acquire(&ptable.lock);

		// Initialize the highest priority process as the first process in the list
		highestPriorityProcess = ptable.proc;

		// Loop over process table looking for the highest priority process
    		for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
			// If process is runnable and its priority is lower than the highest priority...
      			if(p->state == RUNNABLE && p->priority < highestPriority){
				// Grab the first process in that priority class (this results in FIFO scheduling for processes with the same priority)
				highestPriorityProcess = p;

				// Update the highest priority
				highestPriority = p->priority;
			}

      		}

		// In case we didnt find a runnable process in the search, release the lock and search again
		if (highestPriorityProcess->state != RUNNABLE){
			release(&ptable.lock);
			continue;
		}

		// Switch to highest priority process
      		c->proc = highestPriorityProcess;
      		switchuvm(highestPriorityProcess);
      		highestPriorityProcess->state = RUNNING;

            // KC: Checking the running uptime for a process
            // check if the process has already run for a period of time so we add to get the total run time
            if(highestPriorityProcess->pEndTime != 0){
              highestPriorityProcess->pUptime += highestPriorityProcess->pEndTime - highestPriorityProcess->pStartTime;
            } 
            // reset the process start time and end time
            highestPriorityProcess->pStartTime = processUptime();
            highestPriorityProcess->pEndTime = 0;

     		swtch(&(c->scheduler), highestPriorityProcess->context);
     		switchkvm();

      		// When process is done, set the cpu's process to null
      		c->proc = 0;

		// Release process table lock
    		release(&ptable.lock);

  	}
}

void
set_sched_priority(int priority){
	// Ensure priority does not exceed the number of levels
	if(priority < 1 || priority > NUM_PRIORITY_LEVELS){
		panic("\nset_sched_priority: given priority level exceeds the bounds");
	}

	// Obtain the currently running process
	struct proc *p = myproc();

	// Acquire process table lock
	acquire(&ptable.lock);

	// Set the process priority to the new one
	p->priority = priority;

	// Release process table lock
	release(&ptable.lock);

}

int
get_sched_priority(int pid){

	// Define local variable to hold priority & proc structure
	struct proc *p;
	int priority = -1;
	
	// Acquire process table lock
	acquire(&ptable.lock);

	// Loop through the process table to find the matching pid
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
		if(p->pid == pid){
			// Assign priority variable to match the process's priority
			priority = p->priority;
			break;
		}

	}

	// Release process table lock
	release(&ptable.lock);

	// Return the priority
	return priority;
}

// JTM - End Priority Scheduler implementation


// JTM - Separate default scheduler code into its own function
void
defaultScheduler(void){
 
  cprintf("Using the DEFAULT scheduler...\n");

  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
     
     // KC: Checking the running uptime for a process
     // check if the process has already run for a period of time so we add to get the total run time
      if(p->pEndTime != 0){
	      p->pUptime += p->pEndTime - p->pStartTime;
      } 
      // reset the process start time and end time
      p->pStartTime = processUptime();
      p->pEndTime = 0;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }

    release(&ptable.lock);

  }

}
// AI - End default scheduler implementation 


// AI - Start of FIFO Scheduler implementation 


void
fifoScheduler(void){

  cprintf("Using the FIFO scheduler...\n");

  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;

  for(;;){
    sti();
    acquire(&ptable.lock);

    // Pointer for the first task
    struct proc* firstProcess = 0;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE)
                continue;

        // ignore the first command about init
        if (p->pid > 1)
                firstProcess = p;

        // make sure that the process is runnable and then set p to the first process. This way p will always be the first task no matter what
        if(firstProcess != 0 && firstProcess->state == RUNNABLE)
                p = firstProcess;

        if(p != 0)
          {

            // Switch to chosen process.  It is the process's job
            // to release ptable.lock and then reacquire it
            // before jumping back to us.
            c->proc = p;
            switchuvm(p);
            p->state = RUNNING;
            // KC: Checking the running uptime for a process
            // check if the process has already run for a period of time so we add to get the total run time
            if(p->pEndTime != 0){
              p->pUptime += p->pEndTime - p->pStartTime;
            } 
            // reset the process start time and end time
            p->pStartTime = processUptime();
            p->pEndTime = 0;
            swtch(&(c->scheduler), p->context);
            switchkvm();

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            c->proc = 0;
          }
        }

        release(&ptable.lock);



  }

}









int
fifo_position(int pid)
{

	struct proc *p;
	acquire(&ptable.lock);

	int counter = 0;
	int flag = 0;

	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
		if(p->pid == pid && p->state == RUNNABLE){
			cprintf("Name: %s, PID: %d, Position: %d\n", p->name,p->pid, counter);
			flag = 1;
			break;
		}
		if(p->state == RUNNABLE)
			counter++;
	}

	if(!flag) {
		cprintf("PID not found or not in Queue\n");
    release(&ptable.lock);

    return -1;
  }

	release(&ptable.lock);
	return counter;
}
// AI - End of FIFO Scheduler implementation 




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
//JTM - Run the default scheduler code if the macro is set to DEFAULT

#ifdef DEFAULT
  defaultScheduler(); 

//JTM - Run the FIFO scheduler if the macro is set to FIFO
#else
#ifdef FIFO

  fifoScheduler();

//JTM - Run the priority scheduler if the macro is set to PRIORITY
#else
#ifdef PRIORITY

  priorityScheduler();

//JTM - Panic otherwise
#else

  panic("Scheduler uninitialized. Macro name not valid.\n");

#endif
#endif
#endif
  
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
  p->pEndTime = processUptime();
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  //JTM - We only do this whenever we are using the default scheduler to enforce the default time quantum
#ifdef DEFAULT
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
#endif

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

int
printProcessTime(int processId)
{
  // Boolean flag for whether or not we found our process in the ptable
  int foundProcessFlag = 0; 
  // Process PCB
	struct proc *p;
  // Store final variable to return after releasing ptable lock
  int ptime = -1;
  // enable interrupts
	sti();

  // Lock the ptable to avoid changes occurring while looking at it
	acquire(&ptable.lock);

  // Loop through ptable to find running processes
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
      // Search for a matching process Id
      if(p->pid == processId) {
        // Set foundProcessFlag to true so that we know our process id exists
        foundProcessFlag = 1;

        // Check process id state to determine what to do next
        switch(p->state) {
			                  case RUNNING:
                                ptime = p->pUptime;
                                break;
                        case ZOMBIE:
                        case RUNNABLE:
                        case EMBRYO:
                        case UNUSED:
                        case SLEEPING:
                                ptime = 0; // returns 0 if process exists but is not currently running
                                break;
      } // end switch()
	} // end if(p->pid == processId)

    // If the pid was not found in the ptable, return -1
    if(foundProcessFlag == 0){
      ptime = -1;
    }
  }// end for loop on ptable

    // Release our firm grip on the ptable
	release(&ptable.lock);

  return ptime;
} // end printProcessTime()

void
printProcessTable(int processId)
{
    // Boolean flag for whether or not we found our process in the ptable
  int foundProcessFlag = 0; 
  // Process PCB
	struct proc *p;
  // enable interrupts
	sti();
  // Lock the ptable to avoid changes occurring while looking at it
	acquire(&ptable.lock);
  cprintf("\nPID\tSTATE\n");
  cprintf("--------------------------------------\n");

  // Loop through ptable 
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
    if(p->pid == processId) {
              foundProcessFlag = 1;
        switch(p->state) {
			                  case RUNNING:
                                cprintf("%d\tRUNNING\n", p->pid);
                                break;
                        case ZOMBIE:
                                cprintf("%d\tZOMBIE\n", p->pid);
                                break;
                        case RUNNABLE:
                                cprintf("%d\tRUNNABLE\n", p->pid);
                                break;
                        case EMBRYO:
                                cprintf("%d\tEMBRYO\n", p->pid);
                                break;
                        case UNUSED:
                                cprintf("%d\tUNUSED\n", p->pid);
                                break;
                        case SLEEPING:
                                cprintf("%d\tSLEEPING\n", p->pid);
                                break;
      } // end switch()
    }
  }

      // If the pid was not found in the ptable, process does not exist
    if(foundProcessFlag == 0){
      cprintf("\nProcess id, %d, does not exist or no longer exists.\n", processId);
    }

  // Release our firm grip on the ptable
	release(&ptable.lock);
} // end printProcessTable()
