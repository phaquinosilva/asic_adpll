if {[file isdirectory work]} { vdel -all -lib work }

vlib work
vmap work work

vlog ../../rtl/ADPLL.v
vlog ../../rtl/BangBangPD.v
vlog ../../rtl/Div8.v
vlog ../../rtl/LoopFilter.v
# vlog ../../rtl/PhaseAccum.v
vlog ../../rtl/DCO.sv
vlog ../../rtl/PhaseDetector.v
# vlog ../../rtl/PhaseDetectorDL.v
vlog ../../rtl/PulseOnPosEdge.v
vlog ../../rtl/PulseOnNegEdge.v
vlog ../../rtl/SRLatchGate.v
vlog ../../rtl/SaveCounter.v
vlog ../../rtl/Synchroniser.v
vlog ../../rtl/UpDownCounter.v
vlog ../../rtl/stateMachine.v

vsim -voptargs=+acc work.ADPLL 



