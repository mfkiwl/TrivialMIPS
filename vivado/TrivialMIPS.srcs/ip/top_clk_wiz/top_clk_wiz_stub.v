// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Thu Aug 16 12:35:54 2018
// Host        : Skyworks-WinServer running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/harry/Desktop/TrivialMIPS/vivado/TrivialMIPS.srcs/ip/top_clk_wiz/top_clk_wiz_stub.v
// Design      : top_clk_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module top_clk_wiz(out_10M, out_30M, out_60M, out_60M_shift, 
  out_40M, out_80M, out_80M_shift, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="out_10M,out_30M,out_60M,out_60M_shift,out_40M,out_80M,out_80M_shift,reset,locked,clk_in1" */;
  output out_10M;
  output out_30M;
  output out_60M;
  output out_60M_shift;
  output out_40M;
  output out_80M;
  output out_80M_shift;
  input reset;
  output locked;
  input clk_in1;
endmodule
