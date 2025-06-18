
# force -freeze sim:/ADPLL/ref_clk_i 1 0, 0 {0.83 ns} -r 1.667 ns
# force -freeze sim:/ADPLL/fpga_clk_i 1 0, 0 {0.25 ns} -r 0.5 ns
force -freeze sim:/DCO/reset_i 0 0, 1 2 ns, 0 3 ns
force -freeze sim:/DCO/enable_i 0 0, 1 4 ns
#
force -freeze {sim:/DCO/freq_sel_i[0]} 0 0, 1 {0.125 us} -r 0.25 us
force -freeze {sim:/DCO/freq_sel_i[1]} 0 0, 1 {0.25 us} -r 0.5 us
force -freeze {sim:/DCO/freq_sel_i[2]} 0 0, 1 {0.5 us} -r 1 us
force -freeze {sim:/DCO/freq_sel_i[3]} 0 0, 1 1 us -r 2 us
force -freeze {sim:/DCO/freq_sel_i[4]} 0 0, 1 2 us -r 4 us
force -freeze {sim:/DCO/freq_sel_i[5]} 0 0, 1 4 us -r 8 us
force -freeze {sim:/DCO/freq_sel_i[6]} 0 0, 1 8 us -r 16 us
  force -freeze {sim:/DCO/freq_sel_i[7]} 0 0, 1 16 us -r 32 us
