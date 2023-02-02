# COP6611.001S23 OperatingSystems - Project 1

## Group Members
* Katarina Capalbo 
* John Maurer
* Azim Ibragimov

## System Environments
- Windows (WSL/Ubuntu)
    > No special steps other than running "make clean" and then "make qemu-nox" to prevent x-forwarding.

## Implementation Notes

### find command Implementation Notes
The find command has been implemented, as per Professor Gene Kim's instructions, the user MUST specify the "-name" flag at the very least in order to use the command. Additionally, the user cannot use regex to find files.

To implement the find command, I created a find command struct that holds all of the needed to data in order to search for the file name the user wants with the correct flags specified. Throughout the code, we use that findCommand struct while traversing through directories to search for a match. Additionally, there is a recursive search that is performed in order to traverse through each nested directory that may be inside the starting point. 

Error checking has been implemented throughout to ensure the user has formatted the find command correctly.



