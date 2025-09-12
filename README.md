# ModularMultiplier
256-bit Implementation of the Paper "FPGA Modular Multipliers using Hybrid Reduction Techniques" on Xilinx Vivado

Prototyping and Testing done on a Nexys4 DDR FPGA board (Artix-7 FPGA).

The overall operation that we are aiming for is:

$$
Q \leftarrow X \cdot Y \pmod{M}
$$

The current implementation does not have a correctly functioning UART Receiver and Transmitter module. However, it implements the Modular Multiplication itself correctly.

P.S - The Repository is still work-in-progress, not fully functional yet :)
