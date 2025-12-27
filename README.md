# CEG_FABLESS_RISCV-DATA-MEMORY
This repository contains a team-based implementation of an RV32I RISC-V processor developed by CEG ECE students under the team name **CEG FABLESS DEV**.
Each team member contributes to an independent processor module. My contribution focuses on the **Data Memory block**, designed with synchronous write and asynchronous read operations.
## Contributions
- Data Memory block design
- Addressed load/store operations with clocked write and combinational read
- Designed for easy integration into non-pipelined and pipelined architectures

# Single-Port RAM (Asynchronous Read, Synchronous Write)

## 📌 Project Overview
This project implements a **single-port RAM with asynchronous read and synchronous write** using Verilog HDL.  
The memory is organized as **4K × 8-bit**, addressed through a 32-bit address bus with upper address bits used for address decoding. Write operations occur on the rising edge of the clock, while read operations are purely combinational, allowing immediate data access based on the address.

---

## 🧠 Design Details
- Memory implemented as a **two-dimensional register array (4K × 8-bit)**  
- **Synchronous write** operation triggered on the positive edge of the clock  
- **Asynchronous read** operation using combinational logic  
- Address decoding ensures valid memory access only when the upper address bits are zero  
- No reset logic is included, reflecting realistic RAM behavior where initial contents are undefined (`X`)

This design demonstrates core HDL concepts such as memory modeling, address masking, and mixed synchronous–asynchronous behavior.

---

## 🧪 Verification & Testing
A custom testbench was developed to verify correct functionality of the RAM module.  
The testbench:
- Performs multiple write and read operations
- Uses random data values for testing
- Compares read data against expected values
- Tracks successful memory operations using a counter

Simulation results confirm correct synchronous write behavior, asynchronous read functionality, and proper address decoding.

---

## 📊 Results
The design was successfully simulated and verified.  
Screenshots of the following are included in this repository:
- **Timing waveform analysis**
  <p align="center">
  <img width="1844" height="750" alt="image" src="https://github.com/user-attachments/assets/b941ac65-7de0-4727-b789-3bec734c6f44" />
  </p>
- **RTL schematic view**
<p align="center">
 <img width="1534" height="837" alt="image" src="https://github.com/user-attachments/assets/29b72b6c-4ada-4df4-807e-07a20c9ac5e0" />
</p>
These results validate correct signal timing, data integrity, and synthesized structure of the RAM design.

---

## 🔧 Tools Used
- **Verilog HDL**
- **ModelSim** – Simulation and waveform analysis  
- **Quartus** – RTL elaboration and timing analysis

---

## 📎 Notes
This RAM module is suitable for learning and experimentation purposes, and can be extended or adapted for use as a data memory block in processor or SoC-based designs.




