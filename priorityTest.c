/* Priority Test for new system calls with respect to priority scheduler
 * Author - John Maurer
 */

//Include libraries
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
	//First, change the parent priority to highest priority
	set_sched_priority(1);

	//Then, get the priority
	printf(1, "My pid: %d\nMy priority: %d\n", getpid(), get_sched_priority(getpid()));

	exit();	
}

