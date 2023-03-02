#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

// KC
// Test for the time_scheduled system call to test calling any pid
// Expected behavior: should return the time_scheduled for any pid
int main(void)
{
    // Explanation of what this test demonstrates
    printf(1, "\n---------------------------------------------------------------------------------------------------------------------------------------------\n");
    printf(1, "\ntime_scheduled_test: any_pid demonstrates that the time_scheduled system call works with any process id.\n");
    printf(1, "We will test this simply by creating children, grabbing their process id, and calling time_scheduled() on the children and parent pids.\n");

    printf(1, "\n Expected Behavior: The parent and child processes will both run and print out each others status and time_scheduled.\nWhen the child finally terminates, we will see time_schedueld() attempt to check a process id of -1, to which it will return -1\nas the child process no longer exists.\n");
    printf(1, "\n---------------------------------------------------------------------------------------------------------------------------------------------\n");

    int parentPid = getpid();
    int pid;
    int childPid = -1;

    pid = fork();

    if (pid == 0) {
        childPid = getpid();
        printf(1, "\nChild process %d is alive and performs some actions...\n", childPid);
        sleep(50);
    } else {
        printf(1, "\nParent process %d is waiting for the child to finish...\n", parentPid);
        wait();
    }

    printf(1, "\nPrinting Parent PID and STATE... NOTE: Parent PID = %d. Child PID = %d\n", parentPid, childPid);
    printProcessTable(parentPid);
    printf(1, "\nParent pid %d. time_scheduled(%d) = %d\n", parentPid, parentPid, time_scheduled(parentPid));
    printf(1, "--------------------------------------\n");

    printf(1, "\nPrinting Child PID and STATE... NOTE: Parent PID = %d. Child PID = %d\n", parentPid, childPid);
    printProcessTable(childPid);
    printf(1, "\nchildPid pid %d. time_scheduled(%d) = %d\n", childPid, childPid, time_scheduled(childPid));
    printf(1, "--------------------------------------\n");

    wait();

    exit();
}