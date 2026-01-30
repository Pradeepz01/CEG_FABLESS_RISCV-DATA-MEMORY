# RISC-V RV32I Data Memory Module (AXI IP)

Part of the **CEG Fabless Dev Initiative** — developing a **RISC-V (RV32I) General Purpose Processor** targeting eventual tape-out.

This repository contains my contribution: the **Data Memory Module**, fully verified and packaged as a reusable **custom Vivado IP** with **AXI4-Lite** interface.

---

## Overview

The Data Memory supports all RV32I base integer memory instructions:

- **Loads**: `LB`, `LH`, `LW`, `LBU`, `LHU`
- **Stores**: `SB`, `SH`, `SW`

Key design characteristics:
- Synchronous writes
- Asynchronous reads (low-latency)
- Byte/halfword/word access with correct byte-lane selection
- Sign-extension & zero-extension logic
- Address alignment handling

After standalone verification, the module was wrapped with an **AXI4-Lite slave interface** and packaged as a **Vivado IP core**.

---

## Verification – Standalone Module

Thoroughly tested using a dedicated Verilog testbench in Vivado Simulator.

### Features Verified
- Correct byte / halfword / word read & write
- Sign / zero extension behavior
- Byte-lane selection using address[1:0]
- Synchronous write timing
- Asynchronous read path
- No read-after-write hazard issues in test patterns

### Simulation Results

**Timing waveform – load & store operations**

![Waveform – LB/LH/LW/SB/SH/SW](https://github.com/user-attachments/assets/e1e6689c-7a9a-4f59-b4ef-5276f2da56fa)

**Simulation console transcript**

![Transcript – pass with correct values](https://github.com/user-attachments/assets/120276a7-acf2-456e-a204-2b5c0e162c6b)

**RTL schematic views**


![RTL view 1](https://github.com/user-attachments/assets/a66c0a59-7141-4090-854f-a59f702daa48)

![RTL view 2](https://github.com/user-attachments/assets/67c4f607-f407-4fb2-b463-3eeaeea71203)

---
## Power Analysis – Post-Implementation Estimate

Power estimation was carried out in **Xilinx Vivado Power Analyzer** using the fully **implemented** (placed & routed) netlist of the AXI-integrated Data Memory IP.

Activity rates are derived from:
- User constraints
- Simulation traces (where applied)
- Vectorless estimation (fallback)

<img width="925" height="500" alt="Screenshot 2026-01-30 163154" src="https://github.com/user-attachments/assets/64c2ac3b-e98a-42fa-aabe-8808a9299179" />


## AXI IP Packaging – Xilinx Vivado

The memory module has been successfully converted into a **custom AXI4-Lite IP core** using Vivado IP Packager.

### Steps Completed
- Wrapped original memory with AXI4-Lite slave logic
- Implemented proper AXI handshaking & address decoding
- Generated IP packaging files:
  - `component.xml`
  - `xgui/` folder (customization GUI)
  - AXI wrapper source files
- All IP-related files → placed in folder **`AXI_FILES/`**
- IP successfully appears in Vivado IP Catalog

<img width="452" height="796" alt="image" src="https://github.com/user-attachments/assets/10746923-d91e-4fa1-8923-9dba61e2e54a" />


---

## Tools & Environment

- **Tool**          : Xilinx Vivado (202X.X recommended)
- **Language**      : Verilog
- **Simulation**    : Vivado Simulator
- **Interface**     : AXI4-Lite (AMBA)
- **Target**        : FPGA prototyping (ASIC flow compatible)

---

## Status

✅ Functional RTL verified  
✅ Testbench passing with 100% instruction coverage for memory ops  
✅ Converted to custom AXI4-Lite IP  
✅ Packaged and ready for integration in Vivado block designs

Next steps:
- Add IP integrator screenshots
- Include post-synthesis power & resource utilization reports
- System-level integration with processor core

---

Pradeep  
CEG – RISC-V Fabless Development Team  
January 2026
