## RISCV Processor

Introduction
This RISCV Processor is a 16-bit computer system with 8 registers. It follows the standard 6 stage pipelines
(Instruction Fetch, Instruction Decode, Register Read, Execute, Memory Access, and Write Back).
The architecture designed is optimized for performance, includes hazard mitigation techniques, for which
I have implemented a forwarding mechanism.
Instruction Set Architecture

The processor is an 8-register, 16-bit computer system. It has 8 general purpose registers (R0 to R7).
Register R0 is always stores Program Counter. All addresses are byte addresses and instructions.
It always fetches two bytes for instruction and data.
This architecture uses condition code register which has two flags Carry flag (C) and Zero flag (Z). There are three
machine-code instruction formats (R, I, and J type) and a total of 14 instructions.


