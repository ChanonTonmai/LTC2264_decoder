set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS25} [get_ports {ADC_CS[0]}]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS25} [get_ports {ADC_SCK}] 
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS25} [get_ports {ADC_SDI}] 
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS25} [get_ports {ADC_SDO}]

set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS25} [get_ports {ADC_CLK}]

#out1A+
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVDS_25} [get_ports {Data1_p}]
#out1A-
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVDS_25} [get_ports {Data1_n}]
#out2A+
#set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVDS_25} [get_ports {Data2_p}]
##out2A-
#set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVDS_25} [get_ports {Data2_n}]
#FR+
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVDS_25} [get_ports {FCLK_p}]
#FR-
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVDS_25} [get_ports {FCLK_n}]
#DCO+
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVDS_25} [get_ports {DCLK_p}]
#DCO-
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVDS_25} [get_ports {DCLK_n}]


#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/adcDecodeLVDS_0/inst/dclk_bufg]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/adcDecodeLVDS_0/inst/fclk_bufg]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/adcDecodeLVDS_0/inst/clk_par_dbg]
 set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/adcDecodeLVDS_0/inst/clk_ser_dbg]





