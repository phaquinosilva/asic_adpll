`timescale 1ns / 1ps
/*****************************************************************************/
/* Author   : Xilinx                                                         */
/* Date     : ??-??-????                                                     */
/* Function : https://www.xilinx.com/support/documentation/university/       */
/*                Vivado-Teaching/HDL-Design/2013x/Nexys4/Verilog/           */
/*                docs-pdf/lab5.pdf                                          */
/*****************************************************************************/
`ifndef __SRLATCHGATE_v__
`define __SRLATCHGATE_v__

module SRLatchGate (
    R,
    S,
    Q,
    Qbar
);
  input R;  // cadence syn_keep=1
  input S;  // cadence syn_keep=1
  output Q;  // cadence syn_keep=1
  output Qbar;  // cadence syn_keep=1

  assign Q = ~(R || Qbar);
  assign Qbar = ~(S || Q);
endmodule

`endif
