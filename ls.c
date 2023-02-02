#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

char*
fmtname(char *path, int type)
{
  static char buf[DIRSIZ+1];
  char *p; 

  // Find first character after last slash.

  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p += 1;

  if(type==T_DIR){	
  char *q; 
  for(q=path; *(q) != '\0'; q++);
  *q = '/';
  }


  if(strlen(p) >= DIRSIZ)
    return p;
  

  memmove(buf, p, strlen(p)+1);

  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p)-1);
  return buf;
}

void
ls(char *path, int hide)
{
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  case T_FILE:
    if(de.name[0] != '.' && hide != 0)	  
    	printf(1, "%s %d %d %d\n", fmtname(path, st.type), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;

      if(de.name[0] == '.' && hide == 0){
      	continue;
      }

      memmove(p, de.name, DIRSIZ+1);

      p[DIRSIZ] = 0;
  	

      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }

      char *result = fmtname(buf, st.type);
      printf(1, "%s %d %d %d\n", result, st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}

int
main(int argc, char *argv[])
{
  int i;

  // execute the following if no arguments

  if(argc < 2){
    ls(".", 0);
    exit();
  }

  // itterate through files
  int flag = 0;
  for(i=1; i<argc; i++){
     if(strcmp(argv[i], "-a") == 0)
     	flag = 1;   
  }
 
  ls(".", flag);
  
 

  exit();
}


