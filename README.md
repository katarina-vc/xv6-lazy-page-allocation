# COP6611.001S23 - Operating Systems - Project 2

## Group Members (Same Team from Project 1)
* Katarina Capalbo 
* John Maurer
* Azim Ibragimov

## System Environments
- Windows (WSL/Ubuntu)
    > No special steps other than running `make clean` and then `make qemu-nox` to prevent x-forwarding.

## Implementation Notes

### Makefile Changes
The Makefile has been modified to support a new flag `SCHEDULER`. When the program is compiled with `make qemu-nox`, the `SCHEDULER` flag is set to `DEFAULT` to enter into the scheduler that came with xv6. You can switch to the FIFO and priority scheduler by compiling with `make qemu-nox SCHEDULER=FIFO` and `make qemu-nox SCHEDULER=PRIORITY` respectively.

### `time_scheduled()` System Call
To implement time_scheduled(), we first added three fields to the PCB (process struct). pUptime, for the total uptime (aka the total amount of ticks the time is in a RUNNING state), pStartUptime (to stamp the starting time for the process), and pEndUptime (to stamp the ending tmie for the process). Then in proc.c, for each scheduler, when a process is set to a RUNNING state we first check if it's run before. If it has, then we calculate the total uptime and reset the start and end uptime fields. We then restart the start uptime. When a process moves from a running state to any other state (assuming it isn't just done), or if it's still running, we grab the total uptime which is the endUptime minus the startUptime.

### Basic Scheduler - FIFO
For this project, we decided to implement a FIFO Scheduler. This scheduler works by searching through the process table for the first runnable process. Once the first runnable process was found, the context switch will be performed to this process. Consequently, this process will be getting resources since it will be the first one in the process table. Once the process is done executing, it will be removed from the process table or its status will be changed from RUNNING, and the next RUNNING process will recieve CPU resources. 

The system call `get_fifo_position()` was also implemented that shows position of a process in the queue. 

### Interesting Scheduler - Priority with FIFO Queues
The priority scheduler looks through the process table in search of the highest priority process to put on the CPU. A lower priority number indicates more importance (such that the highest priority is 1 and the lowest priority is established by the global variable `NUM_PRIORITY_LEVELS`). The search scans the process table from the top down, looking for the first highest priority process it sees (this produces a FIFO queue for each priority level since it will skip over processes of the same priority that entered the process table later). This process runs until completion, to which the scheduler performs the search again.

The system calls `set_sched_priority(int priority)` and `get_sched_priority(pid)` have also been implemented. The user program `priorityTest` can be run to see them in action.
