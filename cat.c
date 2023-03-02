#include "types.h"
#include "stat.h"
#include "user.h"

char buf[512];

void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");

      		    // KC: Added time_sched checks for Project 2
    printf(1, "\nRunning user program: cat. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\nCat ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());

      exit();
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");

          		    // KC: Added time_sched checks for Project 2
    printf(1, "\nRunning user program: cat. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\nCat ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
    exit();
  }
}

int
main(int argc, char *argv[])
{
  // KC printing out uptime for performance analysis proj 2.
  printf(1, "\nCat starting uptime for PID: %d, uptime(): %d\n", getpid(), uptime());

  int fd, i;

  if(argc <= 1){
    cat(0);

          		    // KC: Added time_sched checks for Project 2
    printf(1, "\nRunning user program: cat. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\nCat ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);

            		    // KC: Added time_sched checks for Project 2
    printf(1, "\nRunning user program: cat. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
  // KC printing out uptime for performance analysis proj 2.
  printf(1, " \nCat ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());    
      exit();
    }
    cat(fd);
    close(fd);
  }

  // KC: Added time_sched checks for Project 2
  printf(1, "\nRunning user program: cat. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
  
  // KC printing out uptime for performance analysis proj 2.
  printf(1, "\nCat ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());

  exit();
}
