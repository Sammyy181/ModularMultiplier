set_property IOSTANDARD LVCMOS33 [get_ports clock]
set_property PACKAGE_PIN E3 [get_ports clock]
create_clock -name clk100 -period 16 [get_ports clock]

## For UART RxD Trial
if{0} {
set_property IOSTANDARD LVCMOS33 [get_ports Rx]
set_property PACKAGE_PIN C4 [get_ports Rx]

set_property IOSTANDARD LVCMOS33 [get_ports reset_all]
set_property PACKAGE_PIN U11 [get_ports reset_all]
set_property IOSTANDARD LVCMOS33 [get_ports en_Rx]
set_property PACKAGE_PIN V10 [get_ports en_Rx]
set_property IOSTANDARD LVCMOS33 [get_ports ready]
set_property PACKAGE_PIN V11 [get_ports ready]

set_property IOSTANDARD LVCMOS33 [get_ports display[7]]
set_property PACKAGE_PIN U16 [get_ports display[7]]
set_property IOSTANDARD LVCMOS33 [get_ports display[6]]
set_property PACKAGE_PIN U17 [get_ports display[6]]
set_property IOSTANDARD LVCMOS33 [get_ports display[5]]
set_property PACKAGE_PIN V17 [get_ports display[5]]
set_property IOSTANDARD LVCMOS33 [get_ports display[4]]
set_property PACKAGE_PIN R18 [get_ports display[4]]
set_property IOSTANDARD LVCMOS33 [get_ports display[3]]
set_property PACKAGE_PIN N14 [get_ports display[3]]
set_property IOSTANDARD LVCMOS33 [get_ports display[2]]
set_property PACKAGE_PIN J13 [get_ports display[2]]
set_property IOSTANDARD LVCMOS33 [get_ports display[1]]
set_property PACKAGE_PIN K15 [get_ports display[1]]
set_property IOSTANDARD LVCMOS33 [get_ports display[0]]
set_property PACKAGE_PIN H17 [get_ports display[0]]

## For UART TxD Trial
set_property IOSTANDARD LVCMOS33 [get_ports Tx]
set_property PACKAGE_PIN D4 [get_ports Tx]

set_property IOSTANDARD LVCMOS33 [get_ports start]
set_property PACKAGE_PIN V10 [get_ports start]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN U12 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports done]
set_property PACKAGE_PIN V11 [get_ports done]

## TxD Constraints for Top Module (Lots of errors popping up, better to use ILA to analyse
set_property IOSTANDARD LVCMOS33 [get_ports Tx]
set_property PACKAGE_PIN D4 [get_ports Tx]
set_property IOSTANDARD LVCMOS33 [get_ports start_Tx]
set_property PACKAGE_PIN H6 [get_ports start_Tx]
set_property IOSTANDARD LVCMOS33 [get_ports Tx_done]
set_property PACKAGE_PIN V15 [get_ports Tx_done]
}


## For Top Module Implementation
set_property IOSTANDARD LVCMOS33 [get_ports Rx]
set_property PACKAGE_PIN C4 [get_ports Rx]

set_property IOSTANDARD LVCMOS33 [get_ports reset_all]
set_property PACKAGE_PIN V10 [get_ports reset_all]

set_property IOSTANDARD LVCMOS33 [get_ports en_Rx]
set_property PACKAGE_PIN U12 [get_ports en_Rx]
set_property IOSTANDARD LVCMOS33 [get_ports start_MM]
set_property PACKAGE_PIN R16 [get_ports start_MM]

set_property IOSTANDARD LVCMOS33 [get_ports Rx_done]
set_property PACKAGE_PIN V14 [get_ports Rx_done]
set_property IOSTANDARD LVCMOS33 [get_ports MM_done]
set_property PACKAGE_PIN T16 [get_ports MM_done]