// Implement the find command - OS Project 1 - COP6611.001S23
// Due date: 2/2/2023
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "stddef.h"

// Define constants 
#define FALSE       0
#define TRUE        1
#define FOLDER      "f" // flag indicator for file types
#define DIRECTORY   "d" // flag indicator for directory/folder types
#define NULLTYPE    "n" // Default null value for type flag
#define NULLSIZE    -1  // Default value for size flag
#define MAXSIZE     512 // Max buffer size
#define NULLTERMINATOR '\0'
#define PARENTDIR ".."
#define CURRENTDIR "."

// Struct to hold the basics needed to breakdown the "find" command
struct findCommandStruct {
    char* fileName;
	char* type;          // will hold either FOLDER or DIRECTORY. Default is NULLTYPE.
    int equalSize;       // For when the size flag does not indicate "+" or "-"
    int greaterThanSize; // For -size flag +SomeIntHere
    int lessThanSize;    // For -size flag -SomeIntHere
    int noFlags;         // True (1) when no flags have been passed to the find command. Default is FALSE.
    int oneFlag;         // True (1) when only one flag has been passed to the find command (either "-size" or "-type"). Default is FALSE.
    int bothFlags;       // True (1) when both the "-size" and "-type" flags have been passed to the find command. Default is FALSE.
};

// Function declarations
void findBothFlags(struct findCommandStruct, struct stat, char*, int, char*);
void findOneFlag(struct findCommandStruct,  struct stat, char*, int, char*);
void findNoFlags(struct findCommandStruct, struct stat, char*, int, char*);
void displayFormattingErrorMsg();
char* fmtname(char*);
int isCurrentOrParentDir(char*);
void nestedDirectoryFound(struct findCommandStruct, char*);

// Displays an error message to the user indicating they formatted their arguments incorrectly to find. Quits program.
void displayFormattingErrorMsg() {
	printf(1, "\nfind failed: Invalid number of arguments. Please format your arguments to one of the following: \n");
	printf(1, "\n\t\tfind <name>");
	printf(1, "\n\t\tfind <folder> -name <name>");
	printf(1, "\n\t\tfind <folder> -name <name> -type f");
	printf(1, "\n\t\tfind <folder> -name <name> -type d");
	printf(1, "\n\t\tfind <folder> -name <name> -size +<number of bytes>");
	printf(1, "\n\t\tfind <folder> -name <name> -size -<number of bytes>\n");
    printf(1, "\n\t\tfind <folder> -name <name> -size -<number of bytes> -type <f or d>\n");

    // KC: Added time_sched checks for Project 2
    printf(1, "Running user program: find. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\n find ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
	exit();
}

// Formats name - from ls.c
char* fmtname(char* folderPath) {
  static char buf[DIRSIZ+1];
  char *p;

  for(p=folderPath+strlen(folderPath); p >= folderPath && *p != '/'; p--)
    ;
  p++;

  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));

  // Added NULLTERMINATOR for string comparison when searching for matches later on.
  memset(buf+strlen(p), NULLTERMINATOR, DIRSIZ-strlen(p));
  return buf;
}

// Checks if a directory is "." (the current directory) or ".." (the parent directory)
// Needed to ensure we don't try to traverse parent directories or recursively search the current/parent directory
int isCurrentOrParentDir(char* folderPath) {
    if(strcmp(fmtname(folderPath), PARENTDIR) == 0 || strcmp(fmtname(folderPath), CURRENTDIR) == 0) {
        return TRUE;
    } else {
        return FALSE;
    }
}

// If a nested directory is found in the current directory we are searching, we then need to traverse that nested directory.
// Opens the nested directory and gets its status information, if no failures then search that directory for matches.
void nestedDirectoryFound(struct findCommandStruct findCmd, char* newFolderPath){
        int newFileDescriptor;
        struct stat newStatObj;

        // Open new directory
        if((newFileDescriptor = open(newFolderPath, 0)) < 0) {
            printf(2, "find failed: Cannot open folder: %s, or folder does not exist.\n", newFolderPath);

            return;
        }

        // Get the status information for the new directory.
        if(fstat(newFileDescriptor, &newStatObj) < 0) {
                printf(2, "find failed: Cannot get status information about: %s\n", newFolderPath);
                close(newFileDescriptor);

                return;
        }

        // Traverse new directory to search for matches.
        if (findCmd.noFlags == TRUE) {
            findNoFlags(findCmd, newStatObj, newFolderPath, newFileDescriptor, newFolderPath);
        } else if (findCmd.oneFlag == TRUE) {
            findOneFlag(findCmd, newStatObj, newFolderPath, newFileDescriptor, newFolderPath);
        } else if (findCmd.bothFlags == TRUE) {
            findBothFlags(findCmd, newStatObj, newFolderPath, newFileDescriptor, newFolderPath);
        }
        
        close(newFileDescriptor);
} 

// Find command func for when the user passes in both a "-size" and "-name" flag. Order of flags does not matter. 
// Ensure we only find matches that match BOTH the size and name criteria.
void findBothFlags(struct findCommandStruct findCmd, struct stat statObj, char *folderPath, int fileDescriptor, char *buf) { 
  char *p;
  struct dirent direntObj;

  // Copy the new folder path
  strcpy(buf, folderPath);
  p = buf+strlen(buf);
  *p++ = '/';

  // Search through the directory we are currently in
  while (read(fileDescriptor, &direntObj, sizeof(direntObj)) == sizeof(direntObj)) {
    if(direntObj.inum == 0){
      continue;
    }

    memmove(p, direntObj.name, DIRSIZ);
    p[DIRSIZ] = 0;

    // Get the status for the current file, else move on to the next file.
    if(stat(buf, &statObj) < 0){
      printf(1, "find failed: Cannot get the status of %s\n", buf);
      continue;
    }

    // Since we know that both flags were passed in, we can start by narrowing down our search to only folders or files
    // From there we can check the size of that file/folder, and print it out if the name matches.
    if(strcmp(findCmd.type, FOLDER) == 0){
        if(statObj.type == T_FILE) {
            if(findCmd.equalSize != -1){
                if(findCmd.equalSize == statObj.size) {
                    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                            printf(1, "%s\n", buf);
                    }
                }
            } else if(findCmd.greaterThanSize != -1){
                if(findCmd.greaterThanSize < statObj.size) {
                    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                            printf(1, "%s\n", buf);
                    }
                }
            } else if(findCmd.lessThanSize != -1) {
                if(findCmd.lessThanSize > statObj.size) {
                    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                            printf(1, "%s\n", buf);
                    }
                }
            }
        }
    } else if(strcmp(findCmd.type, DIRECTORY) == 0) {
        if(statObj.type == T_DIR) {
            if(findCmd.equalSize != -1){
                if(findCmd.equalSize == statObj.size) {
                    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                            printf(1, "%s\n", buf);
                    }
                }
            } else if(findCmd.greaterThanSize != -1){
                if(findCmd.greaterThanSize < statObj.size) {
                    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                            printf(1, "%s\n", buf);
                    }
                }
            } else if(findCmd.lessThanSize != -1) {
                if(findCmd.lessThanSize > statObj.size) {
                    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                            printf(1, "%s\n", buf);
                    }
                }
            }
        } else {
		continue;
        }
    } 

    // If the current "file" is a directory, we need to search that directory for matches and additional nested directories that can contain matches
    // However, we do not want to recursively search the current directory, or traverse the parent directories 
    if (!isCurrentOrParentDir(buf) && statObj.type == T_DIR) {
        nestedDirectoryFound(findCmd, buf);
    }
  }
}

// Find command function if the user did not pass in any flags.
void findNoFlags(struct findCommandStruct findCmd, struct stat statObj, char *folderPath, int fileDescriptor, char *buf) { 
  char *p;
  struct dirent direntObj;

  // Copy the new folder path
  strcpy(buf, folderPath);
  p = buf+strlen(buf);
  *p++ = '/';

  // Search through the directory we are currently in
  while (read(fileDescriptor, &direntObj, sizeof(direntObj)) == sizeof(direntObj)) {
    if (direntObj.inum == 0 ) {
      continue;
    }

    memmove(p, direntObj.name, DIRSIZ);
    p[DIRSIZ] = 0;

    if (stat(buf, &statObj) < 0) {
      printf(2, "find failed: Cannot get the status of %s\n", buf);
      continue;
    }

    // Check for a matching file name, if so print it out.
    if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
        printf(1, "%s\n", buf);
    }

    // If the current "file" is a directory, we need to search that directory for matches and additional nested directories that can contain matches
    // However, we do not want to recursively search the current directory, or traverse the parent directories 
    if (!isCurrentOrParentDir(buf) && statObj.type == T_DIR) {
        nestedDirectoryFound(findCmd, buf);
    }
  }
}

// Find command function if the user only psased in one flag, either "-size" or "-name"
void findOneFlag(struct findCommandStruct findCmd, struct stat statObj, char *folderPath, int fileDescriptor, char *buf) { 
  char *p;
  struct dirent direntObj;

  // Copy the new folder path
  strcpy(buf, folderPath);
  p = buf+strlen(buf);
  *p++ = '/';

  // Search through the directory we are currently in
  while(read(fileDescriptor, &direntObj, sizeof(direntObj)) == sizeof(direntObj)) {
    if(direntObj.inum == 0){
      continue;
    }

    memmove(p, direntObj.name, DIRSIZ);
    p[DIRSIZ] = 0;

    if (stat(buf, &statObj) < 0) {
      printf(1, "find failed: Cannot get the status of %s\n", buf);
      continue;
    }

    // Check for a matching file name, and for flag matches. If match is found, print it out.
    if (strcmp(findCmd.type, FOLDER) == 0) {
        if(statObj.type == T_FILE) {
            if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                printf(1, "%s\n", buf);
            }
        }
    } else if (strcmp(findCmd.type, DIRECTORY) == 0) {
        if(statObj.type == T_DIR) {
            if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                printf(1, "%s\n", buf);
            }
        } else {
            continue;
        }
    } else if (findCmd.equalSize != -1) {
        if(findCmd.equalSize == statObj.size) {
            if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                    printf(1, "%s\n", buf);
            }
        }
    } else if (findCmd.greaterThanSize != -1) {
        if (findCmd.greaterThanSize < statObj.size) {
            if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                    printf(1, "%s\n", buf);
            }
        }
    } else if(findCmd.lessThanSize != -1) {
        if(findCmd.lessThanSize > statObj.size) {
            if (strcmp(fmtname(buf), findCmd.fileName) == 0) {
                    printf(1, "%s\n", buf);
            }
        }
    }

    // If the current "file" is a directory, we need to search that directory for matches and additional nested directories that can contain matches
    // However, we do not want to recursively search the current directory, or traverse the parent directories 
    if (!isCurrentOrParentDir(buf) && statObj.type == T_DIR) {
        nestedDirectoryFound(findCmd, buf);
    }
  }
}

// start main()
int main(int argc, char *argv[]) {
        // KC printing out uptime for performance analysis proj 2.
  printf(1, "\n find starting uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
    // Check for a valid number of arguments.
	if(argc < 4 || argc == 5 || argc == 7 || argc > 8) {
		displayFormattingErrorMsg();
	} 

    struct stat statObj; 
    char bufferStr[MAXSIZE];
    struct findCommandStruct findCmd;
    int startingFileDescriptor; 

    // Initialize findCommand struct to default values so we don't accidentally check an uninitialized value later on.
    findCmd.oneFlag = FALSE;
    findCmd.bothFlags = FALSE;
    findCmd.noFlags = FALSE;
    findCmd.type = NULLTYPE;
    findCmd.equalSize = NULLSIZE;
    findCmd.greaterThanSize = NULLSIZE;
    findCmd.lessThanSize = NULLSIZE;

    // Switch(argc) based on the number of arguments the user passed in, build the findCommand struct, open the first folder, and begin searching for matches.
	switch(argc) {
		case 4: {
            // Check for invalid argument structure.
			if(strcmp(argv[2], "-name") != 0) {
				displayFormattingErrorMsg();
			}
			
            findCmd.noFlags = TRUE;
		} break;

        case 6: { // If there are six arguments, then the user passed in only either the "-size" or "-name" flag
            // Check for invalid argument structure.
			if(strcmp(argv[2],"-name") != 0 || (strcmp(argv[4],"-type") != 0 && strcmp(argv[4],"-size") != 0)) {
				displayFormattingErrorMsg();
			}

			if(strcmp(argv[4], "-size") == 0){ 
                // Check for the greater than/less than size flag indicator (+/-). 
                // If so, pull that indicator off the string so we can pass a size int to our function
                    char indFlag = argv[5][0];
                    char* indFlag2 = &indFlag;
                    char* greater = "+";
                    char* lesser = "-";

                    char* newSizeFlagString = argv[5];
                    
                    if(strcmp(indFlag2, greater) == 0) {
                        char* sizeNumString[strlen(newSizeFlagString) - 1]; 

                        for(int i = 1; i < strlen(newSizeFlagString); i++){
                            strcpy(sizeNumString[i-1], &newSizeFlagString[i]);
                        }

                        findCmd.greaterThanSize = atoi(newSizeFlagString);
                    } else if (strcmp(indFlag2, lesser) == 0) {
                        char* sizeNumString[strlen(newSizeFlagString) - 1]; 

                        for(int i = 1; i < strlen(newSizeFlagString); i++){
                            strcpy(sizeNumString[i-1], &newSizeFlagString[i]);
                        }

                        findCmd.lessThanSize = atoi(newSizeFlagString);
                    } else {
                        findCmd.equalSize = atoi(argv[5]);
                    }

			}	

			if(strcmp(argv[4],"-type") == 0) {
				if(strcmp(argv[5], FOLDER) != 0 && strcmp(argv[5], DIRECTORY) != 0) {
					displayFormattingErrorMsg();
				}
				
				findCmd.type = argv[5];
			}

            // Check for a valid -type or -size argmument. 
            if(strcmp(argv[4], "-type") != 0 && (strcmp(argv[4], "-size") != 0)) {
                displayFormattingErrorMsg();
            }

            findCmd.oneFlag = TRUE;
		} break;

        case 8: { // If there are 8 arguments, then the user passed in both the "-size" and "-name" flag in any order.
            // Check for valid argument structure.
			if(strcmp(argv[2],"-name") != 0 || (strcmp(argv[4],"-type") != 0 && strcmp(argv[4],"-size") != 0) || (strcmp(argv[6],"-type") != 0 && strcmp(argv[6],"-size") != 0)) {
				displayFormattingErrorMsg();
			}

            // ** Get first argument flag information ** //
			if(strcmp(argv[4], "-size") == 0) {
                // Check for the greater than/less than size flag indicator (+/-). 
                // If so, pull that indicator off the string so we can pass a size int to our function
                    char indFlag = argv[5][0];
                    char* indFlag2 = &indFlag;
                    char* greater = "+";
                    char* lesser = "-";

                    char* newSizeFlagString = argv[5];
                    
                    if(strcmp(indFlag2, greater) == 0) {
                        char* sizeNumString[strlen(newSizeFlagString) - 1]; 

                        for(int i = 1; i < strlen(newSizeFlagString); i++){
                            strcpy(sizeNumString[i-1], &newSizeFlagString[i]);
                        }

                        findCmd.greaterThanSize = atoi(newSizeFlagString);
                    } else if (strcmp(indFlag2, lesser) == 0) {
                        char* sizeNumString[strlen(newSizeFlagString) - 1]; 

                        for(int i = 1; i < strlen(newSizeFlagString); i++){
                            strcpy(sizeNumString[i-1], &newSizeFlagString[i]);
                        }

                        findCmd.lessThanSize = atoi(newSizeFlagString);
                    } else {
                        findCmd.equalSize = atoi(argv[5]);
                    }

			} else if(strcmp(argv[4],"-type") == 0) {
				if(strcmp(argv[5],FOLDER) != 0 && strcmp(argv[5], DIRECTORY) != 0) {
					displayFormattingErrorMsg();
				}
				
				findCmd.type = argv[5];
			}

            // Check for a valid -type or -size argmument. 
            if(strcmp(argv[4], "-type") != 0 && (strcmp(argv[4], "-size") != 0)) {
                displayFormattingErrorMsg();
            }

            // ** Get second argument flag information ** //
            if (strcmp(argv[6], "-size") == 0) {
                    char indFlag = argv[7][0];
                    char* indFlag2 = &indFlag;
                    char* greater = "+";
                    char* lesser = "-";

                    char* newSizeFlagString = argv[7];
                    
                    if(strcmp(indFlag2, greater) == 0) {
                        char* sizeNumString[strlen(newSizeFlagString) - 1]; 

                        for(int i = 1; i < strlen(newSizeFlagString); i++){
                            strcpy(sizeNumString[i-1], &newSizeFlagString[i]);
                        }

                        findCmd.greaterThanSize = atoi(newSizeFlagString);
                    } else if (strcmp(indFlag2, lesser) == 0) {
                        char* sizeNumString[strlen(newSizeFlagString) - 1]; 

                        for(int i = 1; i < strlen(newSizeFlagString); i++){
                            strcpy(sizeNumString[i-1], &newSizeFlagString[i]);
                        }

                        findCmd.lessThanSize = atoi(newSizeFlagString);
                    } else {
                        findCmd.equalSize = atoi(argv[7]);
                    }

			} else if(strcmp(argv[6],"-type") == 0) {
				if(strcmp(argv[7],FOLDER) != 0 && strcmp(argv[7],DIRECTORY) != 0) {
					displayFormattingErrorMsg();
				}
				
				findCmd.type = argv[7];
			}

            // Check for a valid -type or -size argmument. 
            if(strcmp(argv[6], "-type") != 0 && (strcmp(argv[6], "-size") != 0)) {
                displayFormattingErrorMsg();
            }

            findCmd.bothFlags = TRUE;
		} break;
	}

    findCmd.fileName = argv[3];

    // Check for a null file name.
    if(findCmd.fileName == NULL){
            printf(1, "find failed: Please enter a valid file or folder name to search for\n");

    // KC: Added time_sched checks for Project 2
    printf(1, "Running user program: find. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\n find ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
            exit();
    }

    // Open the starting point folder path.
    if((startingFileDescriptor = open(argv[1], 0)) < 0) {
            printf(1, "find failed: Cannot open folder: %s, or folder does not exist.\n", argv[1]);
    // KC: Added time_sched checks for Project 2
    printf(1, "Running user program: find. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\n find ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
            exit();
    }

    // Get the status information for the starting point folder path
    if(fstat(startingFileDescriptor, &statObj) < 0) {
            printf(1, "find failed: Cannot get status information about: %s\n", argv[1]);
            close(startingFileDescriptor);
    // KC: Added time_sched checks for Project 2
    printf(1, "Running user program: find. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\n find ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
            exit();
    }

    // Begin traversing the folder for additional files or folders that may contain a match.
    if(findCmd.noFlags == TRUE) {
        findNoFlags(findCmd, statObj, argv[1], startingFileDescriptor, bufferStr);
    } else if(findCmd.oneFlag == TRUE) {
        findOneFlag(findCmd, statObj, argv[1], startingFileDescriptor, bufferStr);
    } else if(findCmd.bothFlags == TRUE) {
        findBothFlags(findCmd, statObj, argv[1], startingFileDescriptor, bufferStr);       
    }

    close(startingFileDescriptor);
    // KC: Added time_sched checks for Project 2
    printf(1, "Running user program: find. time_scheduled(%d): %d\n", getpid(), time_scheduled(getpid()));
      // KC printing out uptime for performance analysis proj 2.
  printf(1, "\n find ending uptime for PID: %d, uptime(): %d\n", getpid(), uptime());
	exit();
} // end main()
