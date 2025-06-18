`timescale 1ns / 1ps

/*****************************************************************************/
/* Author   : Conor Dooley, Pedro Aquino (adaptation for ASIC)               */
/* Date     : ??-June-2025                                                   */
/* Function : Custom DCO-driven ADPLL                                        */
/*****************************************************************************/

// `define SYNTH

module ADPLL #(
    parameter FCW_WIDTH = 8,
    parameter PDET_WIDTH = 6,
    parameter DCO_CC_WIDTH = 8,
    parameter BIAS = (1 << (DCO_CC_WIDTH - 1)),  //biased to 5 MHZ @ 258 MHZ CLOCK

    //LoopFilter Settings
    parameter DYNAMIC_VAL = 0,  //set to allow variable control of the filter gains with ki/p_i
    parameter ERROR_WIDTH = PDET_WIDTH,
    parameter KP_WIDTH = 6,
    parameter KP_FRAC_WIDTH = 5,
    parameter KP = 6'b000001,
    parameter KI_WIDTH = 8,
    parameter KI_FRAC_WIDTH = 7,
    parameter KI = 8'd00000001
) (
    input wire reset_i,  //reset high
    input wire ref_clk_i,
    input wire enable_i,
    input wire [KP_WIDTH-1:0] kp_i,
    input wire [KI_WIDTH-1:0] ki_i,

`ifdef SYNTH
    // DCO IOs
    input wire gen_clk_x,
    output wire signed [FCW_WIDTH-1:0] f_sel_sw_pa_x,
`endif

    output wire gen_clk_o,
    output wire gen_div8_o,
    output wire signed [PDET_WIDTH-1:0] error_o,
    output wire signed [DCO_CC_WIDTH-1:0] dco_cc_o
);

  /*************************************************************************/
  /* Define constants and nets                                             */
  /*************************************************************************/

`ifndef SYNTH
  wire [FCW_WIDTH-1:0] f_sel_sw_pa_x;
  wire gen_clk_x;
`endif

  wire gen_div8_x;
  wire signed [PDET_WIDTH-1:0] error_x;

  assign gen_clk_o = gen_clk_x;
  assign gen_div8_o = gen_div8_x;
  assign error_o = error_x;

  /*************************************************************************/
  /* Module instantiation                                                  */
  /*************************************************************************/

`ifndef SYNTH
  // "DCO"
  DCO #(
      .CTRL_WIDTH(FCW_WIDTH)
  ) testOsc (
      .enable_i(enable_i),
      .reset_i(reset_i),
      .freq_sel_i(f_sel_sw_pa_x),
      .clk_o(gen_clk_x)
  );
`endif

  Div8 div8 (
      .reset_i (reset_i),
      .signal_i(gen_clk_x),
      .div8_o  (gen_div8_x)
  );

  PhaseDetectorDL #(
      .WIDTH(PDET_WIDTH)
  ) testPDet (
      .reset_i(reset_i),
      .reference_i(ref_clk_i),
      .generated_i(gen_div8_x),
      .pd_clock_cycles_o(error_x)
  );

  LoopFilter #(
      .ERROR_WIDTH(ERROR_WIDTH),
      .DCO_CC_WIDTH(DCO_CC_WIDTH),
      .KP_WIDTH(KP_WIDTH),
      // .KP_FRAC_WIDTH(KP_FRAC_WIDTH),
      .KP(KP),
      .KI_WIDTH(KI_WIDTH),
      // .KI_FRAC_WIDTH(KI_FRAC_WIDTH),
      .KI(KI),
      .DYNAMIC_VAL(DYNAMIC_VAL)
  ) loopFilter (
      .gen_clk_i(gen_clk_x),
      .reset_i(reset_i),
      .error_i(error_x),
      .kp_i(kp_i),
      .ki_i(ki_i),
      .dco_cc_o(dco_cc_o)
  );

  //add control code to the bias
  assign f_sel_sw_pa_x = BIAS + $signed(dco_cc_o);

endmodule  // ADPLL

