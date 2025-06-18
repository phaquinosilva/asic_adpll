`timescale 1ns / 10ps

module tb_ADPLL;

  parameter real CLK_PERIOD = 3.333;

  parameter DCO_CC_WIDTH = 8;
  parameter FCW_WIDTH = 8;
  parameter PDET_WIDTH = 8;
  parameter ERROR_WIDTH = PDET_WIDTH;
  parameter KP_WIDTH = 6;
  parameter KP_FRAC_WIDTH = 5;
  parameter KI_WIDTH = 8;
  parameter KI_FRAC_WIDTH = 7;

  parameter KP = 6'd8;
  parameter KI = 8'd2;

  logic reset_i;
  logic ref_clk_i;
  logic enable_i;
  logic [KP_WIDTH-1:0] kp_i;
  logic [KI_WIDTH-1:0] ki_i;
  logic gen_clk_o;
  logic gen_div8_o;
  logic signed [PDET_WIDTH-1:0] error_o;
  logic signed [DCO_CC_WIDTH-1:0] dco_cc_o;

  ADPLL #(
      .FCW_WIDTH(FCW_WIDTH),
      .DCO_CC_WIDTH(DCO_CC_WIDTH),
      .PDET_WIDTH(PDET_WIDTH),
      .ERROR_WIDTH(PDET_WIDTH),
      .KP_WIDTH(KP_WIDTH),
      .KP_FRAC_WIDTH(KP_FRAC_WIDTH),
      .KP(KP),
      .KI_WIDTH(KI_WIDTH),
      .KI_FRAC_WIDTH(KI_FRAC_WIDTH),
      .KI(KI)
  ) adpll (
      .reset_i(reset_i),
      .ref_clk_i(ref_clk_i),
      .enable_i(enable_i),
      .kp_i(kp_i),
      .ki_i(ki_i),
      .gen_clk_o(gen_clk_o),
      .gen_div8_o(gen_div8_o),
      .error_o(error_o),
      .dco_cc_o(dco_cc_o)
  );

  // always #(CLK_PERIOD / 2) ref_clk_i = ~ref_clk_i;
  always #(CLK_PERIOD / 2) ref_clk_i = ~ref_clk_i;

  initial begin
    ref_clk_i = 0;
    kp_i = KP;
    ki_i = KI;
    enable_i = 0;
    reset_i = 0;

    #1 reset_i = 1;
    #5 reset_i = 0;
    #1 enable_i = 1;

    #1_000 $stop;

    #4_000 $stop;
  end

endmodule
