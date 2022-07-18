`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2022 01:14:14 PM
// Design Name: 
// Module Name: tx_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tx_top(
    input wire logic clk,
    input wire logic btnc,
    input wire logic btnu,
    output logic[1:0] led
    );
    wire clk10_4;
    wire locked;
    generate_PN11(.start(btnc),.clk(clk10_4),.clr(btnu),.out_bit(led[1]));
    clk_wiz_1(.reset(btnu),.clk_in1(clk),.locked(locked),.clk_out1(clk10_4));
    assign led[0] = clk10_4;
endmodule

