connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Platform Cable USB 00001a2b007501" && level==0 && jtag_device_ctx=="jsn-DLC9LP-00001a2b007501-13722093-0"}
fpga -file D:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.sdk/ltc2264_app/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw D:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.sdk/ltc2264_plat/export/ltc2264_plat/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source D:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.sdk/ltc2264_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow D:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.sdk/ltc2264_app/Debug/ltc2264_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
