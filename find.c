#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "stddef.h"

struct findCommandStruct {
	char* fileName;
	char* folderName;
	char* type;
	int  addedSize;
	int  subtractedSize;
	int  size;
};

char* formatFileName(char *namePath)
{
	static char newBuf[DIRSIZ+1];
	char *newPath;

	for(newPath=namePath+strlen(namePath); newPath >= namePath && *newPath != '/'; newPath--)
		;
	newPath++;

	if(strlen(newPath) >= DIRSIZ)
		return newPath;
	
	memmove(newBuf, newPath, strlen(newPath));
        memset(newBuf+strlen(newPath), ' ', DIRSIZ-strlen(newPath));
	return newBuf;
}

char* fmtname(char *path)
{
	  static char buf[DIRSIZ+1];
	  char *p;

	      for(p=path+strlen(path); p >= path && *p != '/'; p--)
		          ;
	        p++;

		  if(strlen(p) >= DIRSIZ)
			      return p;
	   memmove(buf, p, strlen(p));
		      memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
		        return buf;
}

void find(struct findCommandStruct findCommand)
{
	struct stat statObj;

	// A file descriptor is an unsigned int used by a process to identify an open file. 
	int fileDescriptor;
	static char buf[512], *p;
	struct dirent de;
		
		if((fileDescriptor = open(findCommand.folderName, 0)) < 0){ 
			printf(2, "find: cannot open %s\n", findCommand.folderName);
			return;
		}

	        if(fstat(fileDescriptor, &statObj) < 0){
			printf(2, "find: cannot stat %s\n", findCommand.folderName);
			close(fileDescriptor);
			return;
		}

		if(statObj.type == T_DIR){
			if(strlen(findCommand.folderName) + 1 + DIRSIZ + 1 > sizeof buf){
      				printf(1, "find: path too long\n");				
				close(fileDescriptor);
				return;
    			}
    			strcpy(buf, findCommand.folderName);
    			p = buf+strlen(buf);
    			*p++ = '/';
			
			char* formattedFileName = formatFileName(findCommand.fileName);

    			while(read(fileDescriptor, &de, sizeof(de)) == sizeof(de)){
	      			if(de.inum == 0)
		          		continue;

	        		memmove(p, de.name, DIRSIZ);
	          		p[DIRSIZ] = 0;

	        		if(stat(buf, &statObj) < 0){
	              			printf(1, "find: cannot stat %s\n", buf);
              				continue;
      				}
				
				if(statObj.type == T_DIR) {
					struct findCommandStruct newFindObj;
					newFindObj.fileName = findCommand.fileName;
					newFindObj.folderName = fmtname(buf);
					find(newFindObj);	
				} 
				
				if(strcmp(formattedFileName, fmtname(buf)) == 0) {
					printf(1,"\n%s", buf); 
				}

    			}			
		}
	close(fileDescriptor);  
} // end find() 

// start displayFormattingErrorMsg()
void displayFormattingErrorMsg() {
	printf(1, "\nfind failed: Invalid number of arguments. Please format your arguments to one of the following: \n");
	printf(1, "\n\t\tfind <name>");
	printf(1, "\n\t\tfind <folder> -name <name>");
	printf(1, "\n\t\tfind <folder> -name <name> -type f");
	printf(1, "\n\t\tfind <folder> -name <name> -type d");
	printf(1, "\n\t\tfind <folder> -name <name> -size +<number of bytes>");
	printf(1, "\n\t\tfind <folder> -name <name> -size =<number of bytes>\n");
	exit();
} // end displayFormattingErrorMsg() 

// start main()
int main(int argc, char *argv[]){
	// Check for an invalid number of arguments
	if(argc < 4 || argc == 5 || argc == 7 || argc > 8) {
		displayFormattingErrorMsg();
	} 

	struct findCommandStruct findCommand;

	// Build the findCommand struct and check for potential errors along the way.
	switch(argc) {
		// Expected command format: find <folder> -name <name> 
		case 4: {
			// Check for correct argument format..
			if(strcmp(argv[2], "-name") != 0) {
				displayFormattingErrorMsg();
			}
			
			findCommand.folderName = argv[1];
			findCommand.fileName = argv[3];
		} break;

		// Potential expected command format: find <folder> -name <name> -type <'f' or 'd'>
		// Potential expected command format: find <folder> -name <name> -size <number of bytes OR +number of bytes OR -number of bytes>
		case 6: {
			// Check for correct argument format.
			if(strcmp(argv[2],"-name") != 0 || (strcmp(argv[4],"-type") != 0 && strcmp(argv[4],"-size") != 0)) {
				displayFormattingErrorMsg();
			}

			if(strcmp(argv[4], "-size") == 0){
				// FIXME: Check for + or - and figure out what to do there.
				printf(1, "\nsize flag found.\n");
				exit();
			}	

			if(strcmp(argv[4],"-type") == 0) {
				if(strcmp(argv[5],"f") != 0 && strcmp(argv[5],"d") != 0) {
					displayFormattingErrorMsg();
				}
				
				findCommand.type = argv[5];
			}
			
			findCommand.folderName = argv[1];
			findCommand.fileName = argv[3];

		} break;
		case 8: { // If the user passes in 8 arguments, we must assume they are passing in both the -size and -type flags in any order.
			// If the user specified "type -d" and "-size", throw an error
			if(strcmp(argv[5], "-type") == 0) {
				if(strcmp(argv[6], "d") == 0) {
					displayFormattingErrorMsg();
				}
				
				findCommand.folderName = argv[1];
				findCommand.fileName = argv[3];
				findCommand.type = argv[6]; 
			} else if(strcmp(argv[5], "-size") == 0) {
				// if the 5th argument is size, then the 6th arg is size specified, and the 7th arg MUST be "-type"
				if(strcmp(argv[7], "-type") == 0) {
					if(strcmp(argv[8], "d") == 0) {
						displayFormattingErrorMsg();
					}
				} else {
					displayFormattingErrorMsg();
				}	
				
				findCommand.folderName = argv[1];
				findCommand.fileName = argv[3];
				findCommand.type = argv[8]; 
				
			} else { // if the 5th argument passed in isn't "-size" or "-type", throw an error
				displayFormattingErrorMsg();
			}	
		}
	} // end switch(argc)

        find(findCommand);

	exit();
} // end main()
