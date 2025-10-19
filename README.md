# ModularMultiplier
256-bit Implementation of the Paper "FPGA Modular Multipliers using Hybrid Reduction Techniques" using Xilinx Vivado

Prototyping and Testing done on a Nexys4 DDR FPGA board (Artix-7 FPGA).

The overall operation that we are aiming for is:

$$
Q \leftarrow X \cdot Y \pmod{M}
$$

This operation is being done via the usage of the following steps:

- 1 Full Multiplication (256x256)
- 1 Folding-based Reduction
- Coarse Grain Reduction
- Fine Grain Reduction

The exact details of these steps can be seen in the paper based on which implementation has been done. The design is perfectly pipelined.

Specifics:

- Clock Frequency - 100MHz
- Throughput - 25.6 GB/s
- Latency (Cycles) - 36

The architecture implemented here was as shown below:

![Microarchitecture of Modular Multiplier][Images/MM_Implementation.jpeg]

The Karatsuba Multiplier had the following structure:

![Karatsuba Multiplier Structure][Images_Karatsuba_Multiplier.jpeg]


