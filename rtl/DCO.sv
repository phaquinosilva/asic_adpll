`timescale 1ns / 1ps

module DCO #(
    parameter CTRL_WIDTH = 8
) (
    input  wire                  enable_i,    //enable high
    input  wire                  reset_i,     // reset high
    input  wire [CTRL_WIDTH-1:0] freq_sel_i,  //bigger is shorter period
    output reg                   clk_o
);

  // Parameters
  parameter real central_frequency = 2.0e9;  // 2.5 GHz
  parameter real range = 0.4e9;  // +/- 500 MHz range
  real frequency;  // Current frequency
  real period;  // Clock period in nanoseconds

  // Clock generation process
  initial begin
    clk_o = 0;
    frequency = central_frequency;
    period = 1e9 / frequency;

    forever begin
      if (reset_i) begin
        frequency = central_frequency;
        #1;
      end else if (enable_i) begin
        // Calculate frequency based on input
        for (integer i = 0; i < CTRL_WIDTH; i = i + 1) begin
          frequency = freq_sel_i[i] == 1 ? frequency + (2.0 ** (i+1) * range) / (2.0 ** CTRL_WIDTH)
                        : central_frequency - (2.0 ** (i+1) * range) / (2.0 ** CTRL_WIDTH);
        end
        #(period / 2.0) clk_o = ~clk_o;
        // Calculate clock period (T = 1/f), converted to nanoseconds
      end else #1;
      period = 1e9 / frequency;
    end
  end


endmodule

