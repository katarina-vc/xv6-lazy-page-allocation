#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

// KC
// Test for the time_scheduled system call to call any process id pass in from the args.
// Expected behavior: Should print out the time_scheduled(pid) for the process id
int main(int argc, char *argv[])
{
     // Check for a valid number of arguments.
	if(argc < 1) {
        printf(1, "Error: The time_scheduled_test user program takes in a single integer argument that should be the process id you want to test with. No args recieved...\n");
        exit();
	} 

    int pid = atoi(argv[1]);

    printf(1, "Running the system call time_scheduled(%d)...\n", pid);
    printf(1, "Output:\t %d\n", time_scheduled(pid));

    exit();
}