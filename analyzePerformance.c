#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

// Create child processes for each user program to run a performance analysis against.
// Each user program, cat, stressfs, uniq, and find all have time_scheduled(getpid()) calls inside them to print out.
int main(void)
{
	// holds process id
    int pid;

		// test "cat README"		
		// If we are in the child process, execute one of the user programs
		pid = fork();
		if (pid == 0) {
			// run cat user program
			char *args[] = {"cat", "README", "|", "uniq", NULL}; // list of arguments for cat, the last arg must always be NULL
			exec(args[0], args);
			exit();
		} else {
			wait();
		}

		pid = fork();
		if (pid == 0) {
			// run stressfs user program
			char *args[] = {"stressfs", "3", NULL}; // list of arguments for stressfs, the last arg must always be NULL
			exec(args[0], args);
			exit();
		} else {
			wait();
		}

		pid = fork();
		if (pid == 0) {
			// run uniq user program
			char *args[] = {"uniq", "README", NULL}; // list of arguments for stressfs, the last arg must always be NULL
			exec(args[0], args);
			exit();
		} else {
			wait();
		}
	
		pid = fork();
		if (pid == 0) {
			// run find user program
			char *args[] = {"find", ".","-name", "ls", NULL}; // list of arguments for stressfs, the last arg must always be NULL
			exec(args[0], args);
			exit();
		} else {
			wait();
		}

    exit();
}