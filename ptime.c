#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

void  prioritySchedulerPTime() {
	// holds process id
    int pid2, pid3, pid4;
	int parentPid = getpid();
	set_sched_priority(1);

		if(getpid() == parentPid) {
			sleep(10);
			printf(1, "\nstressfs arrival time: %d\n", uptime());
			pid2 = fork();
			if (pid2 == 0) {
				set_sched_priority(3);
				// run stressfs user program
				char *args[] = {"stressfs", "1", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

		if(getpid() == parentPid) {
			sleep(10);
			printf(1, "\nuniq arrival time: %d\n", uptime());
			pid3 = fork();

			if (pid3 == 0) {
				set_sched_priority(2);
				// run uniq user program
				char *args[] = {"uniq", "README", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

		if(getpid() == parentPid) {
			sleep(10);
			printf(1, "\nfind arrival time: %d\n", uptime());
			pid4 = fork();

			if (pid4 == 0) {
				set_sched_priority(7);
				// run find user program
				char *args[] = {"find", ".","-name", "ls", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

	pid2 = wait();
	pid3 = wait();
	pid4 = wait();
} // end prioritySchedulerPTime

void  defaultSchedulerPTime() {
	// holds process id
    int pid2, pid3, pid4;
	int parentPid = getpid();

		if(getpid() == parentPid) {
			sleep(10);
			printf(1, "\nstressfs arrival time: %d\n", uptime());
			pid2 = fork();
			if (pid2 == 0) {
				// run stressfs user program
				char *args[] = {"stressfs", "1", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

		if(getpid() == parentPid) {
			sleep(10);
			printf(1, "\nuniq arrival time: %d\n", uptime());
			pid3 = fork();

			if (pid3 == 0) {
				// run uniq user program
				char *args[] = {"uniq", "README", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

		if(getpid() == parentPid) {
			sleep(10);
			printf(1, "\nfind arrival time: %d\n", uptime());
			pid4 = fork();

			if (pid4 == 0) {
				// run find user program
				char *args[] = {"find", ".","-name", "ls", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

	pid2 = wait();
	pid3 = wait();
	pid4 = wait();
} // end defaultScheduler

// Create child processes for each user program to run a performance analysis against.
// Each user program, cat, stressfs, uniq, and find all have time_scheduled(getpid()) calls inside them to print out.
int main(int argc, char *argv[])
{
	if(argc < 1) {
		printf(1, "\nPtime Error. Please add out a scheduler argument and run ptime in the following format:\n\t\tptime default\n\t\tptime fifo\n\t\tptime priority\n");
	}

	if(strcmp(argv[1], "default") == 0) {
		defaultSchedulerPTime();
	} else if(strcmp(argv[1], "fifo") == 0) {
		defaultSchedulerPTime();
	} else if(strcmp(argv[1], "priority") == 0) {
		prioritySchedulerPTime(); // need to call a different function so that we can set priority
	} else {
		printf(1, "\nPtime Error. Please add out a scheduler argument and run ptime in the following format:\n\t\tptime default\n\t\tptime fifo\n\t\tptime priority\n");
	}
    exit();
}
