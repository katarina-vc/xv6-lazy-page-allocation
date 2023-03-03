/* Priority Test for new system calls with respect to priority scheduler
 * Author - Katarina Capalbo
 */

#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

// Create child processes for each user program to run a performance analysis against.
// Each user program, cat, stressfs, uniq, and find all have time_scheduled(getpid()) calls inside them to print out.
int main(void)
{
    // holds process id
    int childPid1;
    int childPid2;

    int pid1;
    int pid2;
    int parentPid = getpid();

    set_sched_priority(7);
    printf(1, "\nParent created with pid %d and priority %d.", parentPid, get_sched_priority(parentPid));

    // test "cat README"        
    // If we are in the child process, execute one of the user programs
    pid1 = fork();
    if (pid1 == 0) {
        set_sched_priority(3);
        childPid1 = getpid();
        printf(1, "\nChild 1 created with pid %d and priority %d.", childPid1, get_sched_priority(childPid1));
        char *args[] = {"uniq", "README", NULL}; // list of arguments for cat, the last arg must always be NULL
        exec(args[0], args);
        exit();
    } else {
        // we are in the parent
        // creater a new child
        pid2 = fork();

        if (pid2 == 0) {
            // we are in the child
            set_sched_priority(1);
            childPid2 = getpid();
            printf(1, "\nChild 2 created with pid %d and priority %d.", childPid2, get_sched_priority(childPid2));
            char *args[] = {"ls", NULL}; // list of arguments for cat, the last arg must always be NULL
            exec(args[0], args);
            exit();
        }

        wait();
    }

    wait();

    exit();
}
