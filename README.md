# VHDL-Based GCD Calculator

This project implements a finite state machine (FSM) in VHDL to compute the greatest common divisor (GCD) of two 8-bit numbers using the Euclidean algorithm with subtraction. The design was tested in simulation and on a Boolean Board.

## Features
- Implements Euclidean algorithm through repeated subtraction
- Supports 8-bit inputs for A and B
- Uses FSM with five states to control operations
- Components: 2x8 multiplexers, 8-bit registers, comparator, conditional inverses, ripple carry adder (RCA), and 7-segment display decoder
- Outputs displayed on simulated waveforms and hardware 7-segment display

## Skills Used
- VHDL programming
- FSM design and datapath integration
- Digital design with registers, muxes, comparators, and adders
- Simulation and hardware testing on Boolean Board

## How It Works
1. Load inputs A and B into registers.
2. FSM compares values:
   - If A = B, output is the GCD.
   - If A > B, perform A ← A - B.
   - If B > A, perform B ← B - A.
3. Process repeats until A = B.
4. Result is displayed on 7-segment output.

## Files
- `GCD_top.vhdl` → Main top-level design with FSM and datapath.
- Component files (registers, muxes, RCA, comparator, decoder).
- Lab report (PDF) with design, simulations, and results.

## Example Simulation
- Inputs: A = 24, B = 15
- Output: GCD = 3
- Verified in both ModelSim waveform simulation and Boolean Board hardware test.

## License
This project is licensed under the MIT License.
