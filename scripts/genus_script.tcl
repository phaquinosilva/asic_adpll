set USER pedro.aquino
set HOME /home/ciinovador/

set_db init_lib_search_path <REDACTED>

set_db init_hdl_search_path ../../rtl

read_libs { <REDACTED> }

read_physical -lef {
  <REDACTED>
}


set DESIGN PhaseDetectorDL


read_hdl PhaseDetectorDL.v 
elaborate $DESIGN

set_db [get_db lib_cells lib_cell:default_emulate_libset_max/<REDACTED>/DEL*] .dont_touch true
set_db [get_db lib_cells lib_cell:default_emulate_libset_max/<REDACTED>/DEL*] .avoid false

read_sdc ../constraints/constraints.sdc

init_design

set_db syn_generic_effort medium
set_db syn_map_effort medium
# set_db syn_opt_effort medium

syn_generic
syn_map

# syn_opt

# Reports
report_timing > reports/report_timing.rpt
report_power  > reports/report_power.rpt
report_area   > reports/report_area.rpt
report_qor    > reports/report_qor.rpt

# Outputs
write_hdl > outputs/PhaseDetectorDL_netlist.v

write_sdc > outputs/PhaseDetectorDL_netlist_constraints.sdc

write_sdf -version {OVI 3.0} -edges check_edge -setuphold split -recrem split > outputs/delays.sdf

write_db -common -legacy -all_root_attributes ../innovus/

