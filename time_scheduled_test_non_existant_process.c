#include "types.h"
#include "stat.h"
#include "user.h"
#include "stddef.h"

// KC
// Test for the time_scheduled system call to call a non-existant process
// Expected behavior: should return -1 if the pid of the process passed in does not exist
int main(void)
{
    printf(1, "\ntime_scheduled_test_non_existant_process is a command that tests the system call time_scheduled() with non-existant process ids.\n");
    printf(1, "Expected Behavior: Should return -1\n");
    printf(1, "Running time_scheduled(-1)...\n");

    // Testing with pid -1 since there will never be a pid -1 unless something went wrong
    printf(1, "Output:\t %d\n", time_scheduled(-1));

    exit();
}