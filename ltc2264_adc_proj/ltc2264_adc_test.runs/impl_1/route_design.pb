
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
�Clock Placer Checks: Poor placement for routing between an IO pin and BUFG. 
Resolution: Poor placement of an IO pin and a BUFG has resulted in the router using a non-dedicated path between the two.  There are several things that could trigger this DRC, each of which can cause unpredictable clock insertion delays that result in poor timing.  This DRC could be caused by any of the following: (a) a clock port was placed on a pin that is not a CCIO-pin (b)the BUFG has not been placed in the same half of the device or SLR as the CCIO-pin (c) a single ended clock has been placed on the N-Side of a differential pair CCIO-pin.
 This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	%s (IBUFDS.O) is locked to %s
	%s (BUFG.I) is provisionally placed by clockplacer on %s
%s*DRC2x
 "b
%design_1_i/adcDecodeLVDS_0/inst/BUFF1	%design_1_i/adcDecodeLVDS_0/inst/BUFF12default:default2default:default2@
 "*
	IOB_X0Y10
	IOB_X0Y102default:default2default:default2�
 "�
5design_1_i/adcDecodeLVDS_0/inst/clk_ser_dbg_BUFG_inst	5design_1_i/adcDecodeLVDS_0/inst/clk_ser_dbg_BUFG_inst2default:default2default:default2H
 "2
BUFGCTRL_X0Y2
BUFGCTRL_X0Y22default:default2default:default2;
 #DRC|Implementation|Placement|Clocks2default:default8ZPLCK-12h px� 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
B
-Phase 1 Build RT Design | Checksum: fec49597
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:13 ; elapsed = 00:00:12 . Memory (MB): peak = 1918.004 ; gain = 36.1172default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
A
,Phase 2.1 Create Timer | Checksum: fec49597
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:13 ; elapsed = 00:00:12 . Memory (MB): peak = 1918.004 ; gain = 36.1172default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
M
8Phase 2.2 Fix Topology Constraints | Checksum: fec49597
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:13 ; elapsed = 00:00:12 . Memory (MB): peak = 1924.047 ; gain = 42.1602default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
F
1Phase 2.3 Pre Route Cleanup | Checksum: fec49597
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:13 ; elapsed = 00:00:12 . Memory (MB): peak = 1924.047 ; gain = 42.1602default:defaulth px� 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px� 
B
-Phase 2.4 Update Timing | Checksum: 61047e02
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:14 ; elapsed = 00:00:14 . Memory (MB): peak = 1934.047 ; gain = 52.1602default:defaulth px� 
�
Intermediate Timing Summary %s164*route2K
7| WNS=0.155  | TNS=0.000  | WHS=-0.986 | THS=-124.450|
2default:defaultZ35-416h px� 
}

Phase %s%s
101*constraints2
2.5 2default:default2.
Update Timing for Bus Skew2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
2.5.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
D
/Phase 2.5.1 Update Timing | Checksum: 5d5840eb
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:15 ; elapsed = 00:00:15 . Memory (MB): peak = 1940.785 ; gain = 58.8982default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=0.155  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
O
:Phase 2.5 Update Timing for Bus Skew | Checksum: ca5c2ca2
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:15 ; elapsed = 00:00:15 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
H
3Phase 2 Router Initialization | Checksum: f4c907ff
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:15 ; elapsed = 00:00:15 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
B
-Phase 3 Initial Routing | Checksum: b9f136da
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:16 ; elapsed = 00:00:16 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=-0.141 | TNS=-0.278 | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.1 Global Iteration 0 | Checksum: 1ec60b2fd
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:20 ; elapsed = 00:00:23 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=-0.131 | TNS=-0.299 | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.2 Global Iteration 1 | Checksum: 1612add01
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
F
1Phase 4 Rip-up And Reroute | Checksum: 1612add01
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 5.1.1 Update Timing | Checksum: 1b9ff80be
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=-0.063 | TNS=-0.079 | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
B
-Phase 5.1 Delay CleanUp | Checksum: c6e9dfd7
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
L
7Phase 5.2 Clock Skew Optimization | Checksum: c6e9dfd7
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
N
9Phase 5 Delay and Skew Optimization | Checksum: c6e9dfd7
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
D
/Phase 6.1.1 Update Timing | Checksum: 8cb96ac6
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=-0.050 | TNS=-0.050 | WHS=0.023  | THS=0.000  |
2default:defaultZ35-416h px� 
B
-Phase 6.1 Hold Fix Iter | Checksum: e5f4aeb1
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
@
+Phase 6 Post Hold Fix | Checksum: e5f4aeb1
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px� 
A
,Phase 7 Route finalize | Checksum: fd7d2707
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
H
3Phase 8 Verifying routed nets | Checksum: fd7d2707
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:25 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
E
0Phase 9 Depositing Routes | Checksum: 1c2ba4a90
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:22 ; elapsed = 00:00:26 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
�
Estimated Timing Summary %s
57*route2J
6| WNS=-0.050 | TNS=-0.050 | WHS=0.023  | THS=0.000  |
2default:defaultZ35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
G
2Phase 10 Post Router Timing | Checksum: 1c2ba4a90
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:23 ; elapsed = 00:00:26 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:23 ; elapsed = 00:00:26 . Memory (MB): peak = 1955.137 ; gain = 73.2502default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1462default:default2
262default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:00:262default:default2
00:00:282default:default2
1955.1372default:default2
73.2502default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:012default:default2 
00:00:00.5132default:default2
1961.9492default:default2
6.8122default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2j
VD:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.runs/impl_1/design_1_wrapper_routed.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2�
�Executing : report_drc -file design_1_wrapper_drc_routed.rpt -pb design_1_wrapper_drc_routed.pb -rpx design_1_wrapper_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
xreport_drc -file design_1_wrapper_drc_routed.rpt -pb design_1_wrapper_drc_routed.pb -rpx design_1_wrapper_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
ZD:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.runs/impl_1/design_1_wrapper_drc_routed.rptZD:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.runs/impl_1/design_1_wrapper_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file design_1_wrapper_methodology_drc_routed.rpt -pb design_1_wrapper_methodology_drc_routed.pb -rpx design_1_wrapper_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file design_1_wrapper_methodology_drc_routed.rpt -pb design_1_wrapper_methodology_drc_routed.pb -rpx design_1_wrapper_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
450*coretcl2�
fD:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.runs/impl_1/design_1_wrapper_methodology_drc_routed.rptfD:/fpga_work/ltc2264_adc_test/ltc2264_adc_test.runs/impl_1/design_1_wrapper_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_power -file design_1_wrapper_power_routed.rpt -pb design_1_wrapper_power_summary_routed.pb -rpx design_1_wrapper_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_power -file design_1_wrapper_power_routed.rpt -pb design_1_wrapper_power_summary_routed.pb -rpx design_1_wrapper_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1582default:default2
262default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
%s4*runtcl2�
mExecuting : report_route_status -file design_1_wrapper_route_status.rpt -pb design_1_wrapper_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -file design_1_wrapper_timing_summary_routed.rpt -pb design_1_wrapper_timing_summary_routed.pb -rpx design_1_wrapper_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px� 
�
}There are set_bus_skew constraint(s) in this design. Please run report_bus_skew to ensure that bus skew requirements are met.223*timingZ38-436h px� 
�
%s4*runtcl2m
YExecuting : report_incremental_reuse -file design_1_wrapper_incremental_reuse_routed.rpt
2default:defaulth px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
%s4*runtcl2m
YExecuting : report_clock_utilization -file design_1_wrapper_clock_utilization_routed.rpt
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file design_1_wrapper_bus_skew_routed.rpt -pb design_1_wrapper_bus_skew_routed.pb -rpx design_1_wrapper_bus_skew_routed.rpx
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 


End Record