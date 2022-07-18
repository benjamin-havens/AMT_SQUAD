// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Fri Jul 15 13:03:31 2022
// Host        : CB428-EE10977 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/plwalker/AMT_SQUAD/frame_sync/pn11_tx/pn11_tx.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_in2, clk_in_sel, clk_out1, reset, locked, 
  clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_in2,clk_in_sel,clk_out1,reset,locked,clk_in1" */;
  input clk_in2;
  input clk_in_sel;
  output clk_out1;
  input reset;
  output locked;
  input clk_in1;
endmodule
