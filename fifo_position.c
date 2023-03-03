//File: fifo_position.c

#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
	
int
main(int argc, char *argv[])
{
	int parentid = getpid();
	
	int childid1 = -1;
	int childid2 = -1; 

	childid1 = fork(); 



	if (childid1 == 0){
            sleep(100);
            exit();
        }


        childid2 = fork();

        if (childid2 == 0){
            sleep(100);
            exit();
        }



	printf(1, "\nParent created with pid %d and FIFO Position is %d.",  parentid, fifo_position(parentid));
	printf(1, "\nChild 1 created with pid %d and FIFO Position is %d.", childid1, fifo_position(childid1));
	printf(1, "\nChild 2 created with pid %d and FIFO Position is %d.", childid2, fifo_position(childid2));
	wait();
        wait();	
	exit();		

	

	
	/*
	int pid;
	pid = atoi(argv[1]);
	fifo_position(pid);
	
	exit();*/

}

/*


//Include libraries
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
	//Variables to hold children PIDs
	int childid1 = -1;
	int childid2 = -1;
	int childid3 = -1;

	//Create some children processes with different priorities, starting with child 1
	childid1 = fork();

	if(childid1 == 0){
		//Child 1 gets priority 3
		set_sched_priority(3);

		//Print Child 1's priority
		printf(1, "\nChild 1 created with pid %d and priority %d.", getpid(), get_sched_priority(getpid()));

		//Sleep for a bit
		sleep(100);

	}else{
		//Create child 2
		childid2 = fork();


		if(childid2 == 0){
			//Child 2 gets priority 1
			set_sched_priority(1);

			//Print Child 1's priority
			printf(1, "\nChild 2 created with pid %d and priority %d.", getpid(), get_sched_priority(getpid()));

			//Sleep for a bit
			sleep(100);
		}else{
			//Create child 3
			childid3 = fork();

			if(childid3 == 0){
				//Child 3 gets priority 2
				set_sched_priority(2);

				//Print Child 1's priority
				printf(1, "\nChild 3 created with pid %d and priority %d.\n", getpid(), get_sched_priority(getpid()));

				//Sleep for a bit
				sleep(100);
			}else{
				//Parent gets priority 7
				set_sched_priority(7);

				//Get parent priority
				printf(1, "\nParent created with pid %d and priority %d.", getpid(), get_sched_priority(getpid()));


				//Sleep for a bit
				sleep(100);
			}
		}
	}

	//Print out to show when each process exits
	if(childid1 == 0){
		printf(1, "\nChild 1 exiting...");

	}else if (childid2 == 0){
		printf(1, "\nChild 2 exiting...");

	}else if (childid3 == 0){
		printf(1, "\nChild 3 exiting...");

	}else{
		printf(1, "\nParent exiting...");
	}

	//Make sure everyone calls exit eventually
	exit();
}
*/

