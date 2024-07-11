#include "kernel/syscall.h"

.text
.global sigreturn

sigreturn:
    // Retrieve the process pointer from tp register
    mv a0, tp
    lw a0, PADDR(a0)  // Get the physical address of the process pointer
    lw a0, (a0)       // Get the process pointer

    // Check if the process has a valid signal frame
    lw t0, SIG_FRAME_VALID_OFFSET(a0)
    beqz t0, no_valid_frame

    // Restore the user context
    la t1, SIG_BACKUP_OFFSET(a0)
    la t2, TRAPFRAME_OFFSET(a0)
    la t3, TRAPFRAME_SIZE
    add t2, t2, t3
    lw t3, t3(t1)
    sw t3, 0(t2)
    lw t3, -4(t1)
    sw t3, -4(t2)
    lw t3, -8(t1)
    sw t3, -8(t2)
    // Continue for all relevant registers

    // Clear the flag indicating that the signal frame is no longer valid
    no_valid_frame:
    li t0, 0
    sw t0, SIG_FRAME_VALID_OFFSET(a0)

    // Return to user mode using the sret instruction
    sret

.data
.align 3
SIG_FRAME_VALID_OFFSET:
    .word 0x0  // Offset for sig_frame_valid field in struct proc

SIG_BACKUP_OFFSET:
    .word 0x0  // Offset for sig_backup field in struct proc
