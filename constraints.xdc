set_property IOSTANDARD LVCMOS33 [get_ports clock]
set_property PACKAGE_PIN E3 [get_ports clock]
create_clock -name clk100 -period 10 [get_ports clock]

set_property IOSTANDARD LVCMOS33 [get_ports reset_all]
set_property PACKAGE_PIN V10 [get_ports reset_all]

set_property IOSTANDARD LVCMOS33 [get_ports en_Rx]
set_property PACKAGE_PIN U12 [get_ports en_Rx]

set_property IOSTANDARD LVCMOS33 [get_ports ready]
set_property PACKAGE_PIN V14 [get_ports ready]

set_property IOSTANDARD LVCMOS33 [get_ports Rx]
set_property PACKAGE_PIN C4 [get_ports Rx]

set_property IOSTANDARD LVCMOS33 [get_ports out_valid]
set_property PACKAGE_PIN T16 [get_ports out_valid]