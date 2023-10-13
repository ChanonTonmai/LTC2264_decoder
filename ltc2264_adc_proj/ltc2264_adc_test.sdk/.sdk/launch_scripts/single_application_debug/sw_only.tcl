connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw D:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.sdk/ltc2264_plat/export/ltc2264_plat/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
stop
targets -set -nocase -filter {name =~ "*A9*#0"}
rst -processor
targets -set -nocase -filter {name =~ "*A9*#0"}
dow D:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.sdk/ltc2264_app/Debug/ltc2264_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
