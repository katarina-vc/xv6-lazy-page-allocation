#include "types.h"
#include "stat.h"
#include "user.h"



int
main(int argc, char *argv[])
{

  if(argc < 2){
  	printf(1, "No arguments provided.");
	exit();
  }	  

  int time = atoi(argv[1]);
  sleep(time);


  exit();
}

