# ModularMultiplier
256-bit Implementation of the Paper "FPGA Modular Multipliers using Hybrid Reduction Techniques" with architectural differences in Karatsuba Multiplication style, using Xilinx Vivado

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

The architecture implemented here was as shown below:

![Microarchitecture of Modular Multiplier](Images/AlgoDiagram.jpeg)

The Karatsuba Multiplier was inspired by FloPoCo, specifically for the usage of Rectangular Karatsuba Multipliers to account for 25x18 DSP48E1 blocks in Nexys4 DDR. 

## Implementation Comparison

Our results and the corresponding comparison to that of the paper's implementation on state-of-the-art FPGA can be seen below:

| Metric                     | Paper's Implementation        | Our Implementation           |
|----------------------------|-------------------------------|------------------------------|
| **FPGA Family**            | Agilex 7                      | Artix 7                      |
| **Logic Resources**        | 11,505 LUTs                   | 20,278 LUTs                  |
| **Flip-Flops**             | —                             | 14,263 FFs                   |
| **DSP Blocks**             | 75                            | 211                          |
| **BRAM / Memory Blocks**   | 105 M20Ks                     | 68 BRAMs                     |
| **Latency**                | 57 cycles                     | 28 cycles                    |
| **FMax (Achieved)**        | 804 MHz                       | 110 MHz                      |
| **FMax (Operational)**     | 600 MHz                       | 100 MHz                      |

