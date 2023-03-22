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

![Breaking sbrk](/Project%203%20Screenshots/Breaking%20sbrk.PNG)

We get the same `trap 14 err 6` at the same `eip` and `addr` locations, which is a page fault trap. It seems xv6 creates small processes initially and uses `growproc()` to allocate as much space as each individual program needs. Without it, it immediately page faults regardless of which program is run, which shows the significance of the original `sbrk()` implementation. 

### Part 3 - Implementing Lazy Page Allocation & Evaluation

To implement lazy allocation, we copied `mappages()` and `walkpgdir()` from `vm.c` into `trap.c`. Based on the new implementation of `sbrk()`, we added code in the trap handler to identify `trap 14` right before the print statement we saw before. Since the trap knows which process called it, we have the virtual address it is complaining about (given by `rcr2()`) as well as it's new size (`myproc()->sz`). 

The functions `growproc()` and `allocuvm()` allocate memory contiguously up to the size of the process. It must be done in this manner, otherwise `allocuvm()` will falsely believe it has run out of memory. The image below shows the old implementation of `sbrk()` with print statements located whenever `allocuvm()` and `deallocuvm()` is called. Observe that it allocates from address `0x4000` to address `0xb000` contiguously.

![ls - Old sbrk implementation](/Project%203%20Screenshots/ls%20-%20Old%20sbrk%20Implementation.PNG)

With this in mind, our trap handler in `trap.c` emulates the behavior of `growproc()` by calling a function `allocPage(pgdir, va, size)` which accepts the process's page table, the complaining address (`rcr2()`) and the process's size (`myproc()->sz`). This function emulates the behavior of `allocuvm()`, except it allocates from the faulting address up to current size of the process. The image below shows the lazy allocation under the new implementation of `sbrk()`, which allocates the same memory addresses as in the old implementation.

![ls - Lazy Allocation](/Project%203%20Screenshots/ls%20-%20Lazy%20Allocation.PNG)

Screenshots for the other commands can be found in the [Project 3 Screenshots](/Project%203%20Screenshots) folder.
