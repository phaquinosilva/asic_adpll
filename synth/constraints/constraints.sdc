# SDC File for FSM calib loop harvester Circuit

# ---------------------------------------------------------
# Define the primary clock
# ---------------------------------------------------------

# Clock de referência: 600MHz
create_clock -name REF_CLK -period 3.33 [get_ports reference_i]

# Clock gerado pela ADPLL: Centro em 600Mhz MHz
create_clock -name GEN_CLK -period 3 [get_ports generated_i]

# Relacionamento entre os clocks (como são independentes, defina no_multicycle)
# Isso evita que a ferramenta tente cronometrar paths entre os domínios diretamente
set_clock_groups -asynchronous -group [get_clocks REF_CLK] -group [get_clocks GEN_CLK]

# Reset assíncrono
# Ignorar paths reset -> registradores
set_false_path -from [get_clocks *] -to [get_ports reset_i]

set_max_delay 0.1 -from [get_ports reset_i] -to [get_ports error_taps_buff_r]
set_load 0.05 [get_ports pd_clock_cycles_o] 


# ---------------------------------------------------------
# Set input delays
# ---------------------------------------------------------

# Set input delay relative to the rising edge of the clock
# Assume external delay of 2 ns for inputs a, b, and acc_in
#set_input_delay -clock clk -max 10 [get_ports generated_i]
#set_input_delay -clock clk -min 5 [get_ports generated_i]

# ---------------------------------------------------------
# Set output delays
# ---------------------------------------------------------

# Set output delay relative to the rising edge of the clock
# Assume external delay of 1.5 ns for acc_out
# set_output_delay -clock REF_CLK -max 1 [get_ports pd_clock_cycles_o]
# set_output_delay -clock REF_CLK -min 0.1 [get_ports pd_clock_cycles_o]

# ---------------------------------------------------------
# Define timing exceptions
# ---------------------------------------------------------

# Set false path between registers if needed (example path)
# set_false_path -from [get_cells register_a] -to [get_cells register_b]

# Set multicycle paths (e.g., if multiplication takes multiple cycles)
# Example: multiplication takes 2 cycles
#set_multicycle_path 2 -from [get_cells mul_stage1_reg] -to [get_cells mul_stage2_reg]

# ---------------------------------------------------------
# Specify I/O delay uncertainty
# ---------------------------------------------------------

# Add uncertainty for input and output delays (e.g., due to jitter or process variations)
#set_input_delay -clock clk -max 10 [get_ports generated_i]
#set_output_delay -clock clk -max 5 [get_ports pd_clock_cycles_o]

# ---------------------------------------------------------
# Set clock uncertainty
# ---------------------------------------------------------

# Define clock uncertainty (e.g., clock jitter)
#set_clock_uncertainty -setup 10 [get_clocks clk]
#set_clock_uncertainty -hold 10 [get_clocks clk]

# ---------------------------------------------------------
# Specify max delay for critical paths
# ---------------------------------------------------------

# Set maximum delay (e.g., critical path must not exceed 8 ns)
#set_max_delay 800 -from [get_ports {i_en_calib i_cmp_result}] -to [get_ports {o_flag_calib o_clk_cmp o_offset}]

# ---------------------------------------------------------
# Specify input and output transition times
# ---------------------------------------------------------

# Set input transition times (slew rate at input ports)
#set_input_transition 10 [get_ports generated_i]

# Set output load

# ---------------------------------------------------------
# Define clock groups
# ---------------------------------------------------------

# If there are multiple clocks, define them as mutually exclusive
# Example: asynchronous clock domains clk1 and clk2
# set_clock_groups -asynchronous -group {clk1} -group {clk2}

