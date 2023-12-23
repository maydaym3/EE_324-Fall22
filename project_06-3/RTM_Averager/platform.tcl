# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\james\source\repos\E_E-324\project_06-3\RTM_Averager\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\james\source\repos\E_E-324\project_06-3\RTM_Averager\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {RTM_Averager}\
-xpfm {E:/E_E-324/project_06-2/RTM_system/export/RTM_system/RTM_system.xpfm}\
-out {C:/Users/james/source/repos/E_E-324/project_06-3}

platform write
platform active {RTM_Averager}
platform active {RTM_Averager}
bsp reload
platform generate
