
# XM-Sim Command File
# TOOL:	xmsim(64)	23.09-s013
#
#
# You can restore this configuration with:
#
#      xrun -smartorder -lwdgen -sdf_cmd_file /home/ciinovador/pedro.aquino/work/adpll/scripts/sdf.cmd /home/ciinovador/pedro.aquino/work/tsmc65lp_workspace/tcbn65lpbwp7tlvt_220a_FE/TSMCHOME/digital/Front_End/verilog/tcbn65lpbwp7tlvt_141a/tcbn65lpbwp7tlvt.v -linedebu -access +rwc -f file_list_annotated.f -s -input /home/ciinovador/pedro.aquino/work/adpll/sim/xcelium/pll.tcl
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
set vcd_compact_mode 0
set vhdl_forgen_loopindex_enum_pos 0
set tcl_sigval_prefix {#}
alias . run
alias indago verisium
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves tb_ADPLL.adpll.ref_clk_i tb_ADPLL.adpll.gen_div8_o tb_ADPLL.adpll.gen_clk_o tb_ADPLL.adpll.dco_cc_o tb_ADPLL.adpll.error_o tb_ADPLL.adpll.ki_i tb_ADPLL.adpll.kp_i tb_ADPLL.adpll.enable_i tb_ADPLL.adpll.reset_i
probe -create -database waves tb_ADPLL.adpll.testPDet.clear_tdl_c tb_ADPLL.adpll.testPDet.count_c tb_ADPLL.adpll.testPDet.count_delayed_c tb_ADPLL.adpll.testPDet.done_c tb_ADPLL.adpll.testPDet.error_2s_comp_c tb_ADPLL.adpll.testPDet.error_bin_r tb_ADPLL.adpll.testPDet.error_taps_buff_r tb_ADPLL.adpll.testPDet.error_taps_r tb_ADPLL.adpll.testPDet.gen_q_r tb_ADPLL.adpll.testPDet.ref_q_r tb_ADPLL.adpll.testPDet.sign_c tb_ADPLL.adpll.testPDet.sign_delay_r tb_ADPLL.adpll.testPDet.which_first_c

simvision -input pll.tcl.svcf
