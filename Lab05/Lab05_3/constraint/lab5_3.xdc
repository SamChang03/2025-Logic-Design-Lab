set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports pause_resume_raw]
set_property IOSTANDARD LVCMOS33 [get_ports start_stop_raw]
set_property IOSTANDARD LVCMOS33 [get_ports set_sec_raw]
set_property IOSTANDARD LVCMOS33 [get_ports set_min_raw]
set_property IOSTANDARD LVCMOS33 [get_ports setting]

set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]


set_property PACKAGE_PIN W5 [get_ports clk]
set_property PACKAGE_PIN R2 [get_ports rst_n]
set_property PACKAGE_PIN V17 [get_ports setting]
set_property PACKAGE_PIN U17 [get_ports pause_resume_raw]
set_property PACKAGE_PIN T18 [get_ports start_stop_raw]
set_property PACKAGE_PIN T17 [get_ports set_sec_raw]
set_property PACKAGE_PIN W19 [get_ports set_min_raw]

set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]

set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]

set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
set_property PACKAGE_PIN V3 [get_ports {LED[9]}]
set_property PACKAGE_PIN W3 [get_ports {LED[10]}]
set_property PACKAGE_PIN U3 [get_ports {LED[11]}]

set_property PACKAGE_PIN P3 [get_ports {LED[12]}]
set_property PACKAGE_PIN N3 [get_ports {LED[13]}]
set_property PACKAGE_PIN P1 [get_ports {LED[14]}]
set_property PACKAGE_PIN L1 [get_ports {LED[15]}]



set_property IOSTANDARD LVCMOS33 [get_ports {SSD[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSD[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSD[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSD[0]}]
set_property PACKAGE_PIN W4 [get_ports {SSD[3]}]
set_property PACKAGE_PIN V4 [get_ports {SSD[2]}]
set_property PACKAGE_PIN U4 [get_ports {SSD[1]}]
set_property PACKAGE_PIN U2 [get_ports {SSD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pattern[0]}]
set_property PACKAGE_PIN W7 [get_ports {pattern[7]}]
set_property PACKAGE_PIN W6 [get_ports {pattern[6]}]
set_property PACKAGE_PIN U8 [get_ports {pattern[5]}]
set_property PACKAGE_PIN V8 [get_ports {pattern[4]}]
set_property PACKAGE_PIN U5 [get_ports {pattern[3]}]
set_property PACKAGE_PIN V5 [get_ports {pattern[2]}]
set_property PACKAGE_PIN U7 [get_ports {pattern[1]}]
set_property PACKAGE_PIN V7 [get_ports {pattern[0]}]

create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add
