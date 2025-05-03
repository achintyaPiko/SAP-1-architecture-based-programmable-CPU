# SAP-1 Architecture-Based Programmable CPU

This project is a Verilog implementation of the **SAP-1 (Simple As Possible)** CPU architecture, extended with a custom `STA` (Store Accumulator) instruction and deployed on the **Papilio Pro FPGA development board** featuring a **Spartan-6 FPGA**.

It serves as both a learning tool and a programmable CPU core capable of executing simple 8-bit programs using a minimal instruction set. This implementation follows the classic SAP-1 design from digital computer architecture references and includes key enhancements to support more practical use.

---

## Features

- Fully implemented SAP-1 CPU architecture in Verilog
- Deployed on Papilio Pro FPGA (Spartan-6)
- Supports 6 instructions, including a custom `STA` instruction
- Instruction execution modeled via a multi-step control sequence
- Includes sample programs with explanations
- Demonstrates basic arithmetic, memory load/store, and output operations

---

## Instruction Set

| Mnemonic   | Opcode | Description                                                                      |
|------------|--------|----------------------------------------------------------------------------------|
| `LDA $Xh`  | `0000` | Load value from memory address `Xh` into the accumulator                         |
| `ADD $Xh`  | `0001` | Add value at memory address `Xh` to the accumulator                              |
| `SUB $Xh`  | `0010` | Subtract value at memory address `Xh` from the accumulator                       |
| `STA $Xh`  | `0100` | Store value from accumulator into memory address `Xh` (custom extension)         |
| `OUT`      | `1110` | Output contents of register at memory address `0Eh` and `0Fh` onto display       |
| `HLT`      | `1111` | Halt program execution                                                           |

### STA Instruction (Custom Extension)

The `STA` (Store Accumulator) instruction is not part of the original SAP-1 specification. It allows writing the contents of the accumulator to a specified memory address, enabling two-way memory interaction. This addition makes the CPU more programmable and practical and closer to Turing Completeness.

---

## Architecture Overview

The design follows the classic SAP-1 architecture as described in *Digital Computer Electronics* by Albert Paul Malvino and Jerald A. Brown. It features a single 8-bit data bus (W bus) connecting all major components, including:

- Program Counter
- Memory Address Register (MAR)
- 16x8 RAM
- Instruction Register
- Accumulator
- B Register
- Adder/Subtractor
- Output Register
- Control Sequencer

Each component is activated by dedicated control signals issued by the controller/sequencer based on the current instruction and timing step.  
In this implementation of the modified SAP-1 architecture, the MAR and the 16×8 RAM are combined into a single module called the `MemoryController`. This module is additionally connected to the accumulator (A register) to support the custom `STA` (Store Accumulator) instruction.
 

### Block Diagram

![SAP-1 Block Diagram](<insert-image-path-or-link-here>)

> *Diagram source: "Digital Computer Electronics" by Malvino & Brown*

