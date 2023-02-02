# COP6611.001S23 OperatingSystems - Project 1

## Group Members
* Katarina Capalbo 
* John Maurer
* Azim Ibragimov

## System Environments
- Windows (WSL/Ubuntu)
    > No special steps other than running "make clean" and then "make qemu-nox" to prevent x-forwarding.

## Implementation Notes

### `ls` Command Implementation Notes
The ls command was implemented as advised on the Canvas instructions page. The ls command hides hidden files by checking if there is "." at the start of the file name. Additionally, it checks if a file type of a current entry is a folder, and if there is so, it appends "/" to the end of the file. Additionally, the flag `-a` makes it possible to display hidden files. 

### `sleep` Command Implementation Notes
This instruction followed the guidelines of Dr. Kim. Particluraly, it accepts an integer number that indicates the number of CPU Clock Ticks the sleep command is going to be working for. Then it passes the argument to the sleep system class. To make it easier for users to use this function, we added it to the makefile so that users can call it from the terminal. 


### `find` Command Implementation Notes
The find command has been implemented, as per Professor Gene Kim's instructions, the user MUST specify the "-name" flag at the very least in order to use the command. Additionally, the user cannot use regex to find files.

To implement the find command, I created a find command struct that holds all of the needed to data in order to search for the file name the user wants with the correct flags specified. Throughout the code, we use that findCommand struct while traversing through directories to search for a match. Additionally, there is a recursive search that is performed in order to traverse through each nested directory that may be inside the starting point. 

Error checking has been implemented throughout to ensure the user has formatted the find command correctly.

### `uniq` Command Implementation Notes
The project specified that `uniq` was intended to find duplicated lines in a file that are adjacent to one another. Additionally, the program was also to accept 3 different flags (in any combination) and also support piping from other commands, such as `cat`. The program reads in the arguments of the command call, and if the flags match, a `flags` array is updated before being sent into the `uniq` function.

Using the structure of `cat` as a base, I decided to read in the file character by character, searching for newline characters to determine when to populate my string arrays. Comparisons are performed to determine when matches have been made, and integer flags are set and reset - depending on the situation - to determine when to print and what to print.
