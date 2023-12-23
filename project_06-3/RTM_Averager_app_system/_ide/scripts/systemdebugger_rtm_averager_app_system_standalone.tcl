# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\Users\james\source\repos\E_E-324\project_06-3\RTM_Averager_app_system\_ide\scripts\systemdebugger_rtm_averager_app_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\Users\james\source\repos\E_E-324\project_06-3\RTM_Averager_app_system\_ide\scripts\systemdebugger_rtm_averager_app_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "RealDigital Bla 887200000130A" && level==0 && jtag_device_ctx=="jsn1-13723093-0"}
fpga -file C:/Users/james/source/repos/E_E-324/project_06-3/RTM_Averager_app/_ide/bitstream/RTM_system_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw E:/E_E-324/project_06-2/RTM_system/export/RTM_system/hw/RTM_system_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/Users/james/source/repos/E_E-324/project_06-3/RTM_Averager_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/Users/james/source/repos/E_E-324/project_06-3/RTM_Averager_app/Debug/RTM_Averager_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
