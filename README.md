# COP6611.001S23 - Operating Systems - Project 3

## Group Members (Same Team from Projects 1 & 2)
* Katarina Capalbo 
* John Maurer
* Azim Ibragimov

## System Environments
- Windows (WSL/Ubuntu)
    > No special steps other than running `make clean` and then `make qemu-nox` to prevent x-forwarding.

## Implementation Notes

### Part 1 - Breaking `sbrk()`

We have commented out the original implementation of `sbrk()` (just in case we need to reference it in the future). We replaced it with a function that changes the process's size, but does not call `growproc()`. When running `make qemu-nox`, everything boots up as normal. Below is a screenshot of what happens when we try to run some commands:

![Breaking sbrk](https://user-images.githubusercontent.com/43382258/224521806-bbd14b31-cb60-4499-8aac-96c4f64fb87a.PNG)

We get the same `trap 14 err 6` at the same `eip` and `addr` locations, which is a page fault trap. It seems xv6 creates small processes initially and uses `growproc()` to allocate as much space as each individual program needs. Without it, it immediately page faults regardless of which program is run, which shows the significance of the original `sbrk()` implementation. 

### Part 2 - Implementing Lazy Page Allocation

### Part 3 - Evaluation of Lazy Page Allocation
