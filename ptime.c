#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

// Create child processes for each user program to run a performance analysis against.
// Each user program, cat, stressfs, uniq, and find all have time_scheduled(getpid()) calls inside them to print out.
int main(void)
{
	// holds process id
    int pid1, pid2, pid3, pid4;
	int parentPid = getpid();

		// test "cat README"		
		// If we are in the child process, execute one of the user programs
		if(getpid() == parentPid) {
			printf(1, "\ncat uniq arrival time: %d\n", uptime());
			pid1 = fork();
			if (pid1 == 0) {
				// run cat user program
				char *args[] = {"cat", "README", "|", "uniq", NULL}; // list of arguments for cat, the last arg must always be NULL
				exec(args[0], args);
				exit();
			} 
		}

		if(getpid() == parentPid) {
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
			printf(1, "\nfind arrival time: %d\n", uptime());
			pid4 = fork();

			if (pid4 == 0) {
				// run find user program
				char *args[] = {"find", ".","-name", "ls", NULL}; // list of arguments for stressfs, the last arg must always be NULL
				exec(args[0], args);
				exit();
			}
		}

	pid1 = wait();
	pid2 = wait();
	pid3 = wait();
	pid4 = wait();

    exit();
}