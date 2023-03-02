This folder contains screenshots to demonstrate the usage of the time_scheduled system call.

I created a user program called "any_pid" and when it runs, it demonstrates calling time scheduling, while also periodically printing out a parent and child process state so that the viewer can track the usage of time_scheduled. 

IMPORTANT NOTE FOR GRADERS: We often ran into issues with too many user programs in our Makefile, as xv6 did not have enough memory for them all. The time_scheduled tests .c files can still be found in our folder to see what we used for testing, additionally paired with our screenshot. 

Please see the following file in the main directory for our time_scheduled_test:
any_pid.c 
