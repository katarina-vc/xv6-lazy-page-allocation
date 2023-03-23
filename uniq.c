/* Uniq Command Implementation
 * Author - John Maurer
 * Based off of functionality from cat.c
 */

//Include libraries
#include "types.h"
#include "stat.h"
#include "user.h"

//Perform uniq functionality
void
uniq(int fileDescriptor, int flags[])
{

	//Variable definitions
	int hasChar;
	int isFirstIteration = 1;
	int line1len = 0;
	int line2len = 0;
	int matchesFound = 0;

	//Line arrays
	char line1[512];
	char line2[512];

	//Char buffer for file
	char currentChar;
	
	//Loop through file character by character
	while((hasChar = read(fileDescriptor, &currentChar, 1)) > 0){

		//If the current character is a newline character, we have a line
		if(currentChar == '\n'){
			if(isFirstIteration){
				isFirstIteration = 0;
			}else{
				//Compare lines
				if(strcmp(line1, line2) == 0){
					//Lines match, increment match counter, set first line as printed.
					matchesFound += 1;
                        	}else{
					//Lines do not match. If duplicate flag is set and match count is 0, skip printing.
					if(flags[2] == 1 && matchesFound == 0){
						//Do nothing
					}else{
						//If the count flag is set, append the number of occurrences
						if(flags[0] == 1){
							printf(1, "%d  ", matchesFound + 1); 
						}

						//Print Line 1
						printf(1, "%s\n", line1);
					
						//Reset match count
						matchesFound = 0;

					}
					
                        	}

				//Flush old data from line 1
				memset(line1, 0, line1len);

				//Line 1 is now replaced with line 2
				memmove(line1, line2, line2len);
				line1len = line2len;

				//Flush old data from line 2
				memset(line2, 0, line2len);
				line2len = 0;
			}
		}else{
			//Line not completed yet. Ignore case if ignore flag is set.
			if(flags[1] == 1){
	
				//If character is capital, replace with lower case
				if(currentChar >= 65 && currentChar <= 90){
					currentChar += 32;
				}
			}

			//Append characters to lines
			if(isFirstIteration){
				line1[line1len] = currentChar;
				line1len += 1;
			}else{
				line2[line2len] = currentChar;
				line2len += 1;
			}
		}
		
	}
	
	//Error checking - ensure read() exited successfully
	if(hasChar < 0){
		printf(1, "uniq: could not read file\n");
		exit();
	}
	
	//Last line printout - check duplicate flag
	if(flags[2] == 1 && matchesFound == 0){
		//Do nothing
	}else{
		//Check count flag, print last line
		if(flags[0] == 1){
			printf(1, "%d  ", matchesFound + 1);
		}

		printf(1, "%s\n", line1);
	}
}

//Main method
int
main(int argc, char *argv[])
{
	//Variable definitions
	int fileDescriptor, argParseIndex;
	int fileNameLocation = argc - 1;

	//xv6 has a limited string library. Hence, this garbage.
	//flags = [c, i, d], 1 if enabled, 0 if disabled
	int flags[] = {0, 0, 0};

	//Error checking - Check for too few arguments
	if(argc < 1){
		printf(1, "uniq: too few arguments\n");
		exit();
	}

	//Check if pulling from pipe
	if (argc == 1){
		printf(1, "\n");
		uniq(0, flags);
		printf(1, "\n");
		exit();
	}
	
	//Error checking - See if file even opens
	if ((fileDescriptor = open(argv[fileNameLocation],0)) < 0){
		printf(1, "uniq: %s cannot be opened\n", argv[fileNameLocation]);
		exit();
	}

	//Loop through the array of arguments to find flags
	for(argParseIndex = 1; argParseIndex < (argc - 1); argParseIndex++){

		//If the command contains a flag we want, add it to what we want to pass to uniq
		if (strcmp(argv[argParseIndex], "-c") == 0){
			flags[0] = 1;

		}else if (strcmp(argv[argParseIndex], "-i") == 0){
			flags[1] = 1;
			
		}else if (strcmp(argv[argParseIndex], "-d") == 0){
			flags[2] = 1;
		}

	}

	//Call the command with the arguments, exit when done
	printf(1, "\n");
	uniq(fileDescriptor, flags);
	printf(1, "\n");
	exit();
}
