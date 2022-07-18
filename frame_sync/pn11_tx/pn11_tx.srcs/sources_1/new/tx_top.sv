`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Preston Walker, Gustavo Oliveira, Riley Kirkwood, Joe Lamb, Ben Havens
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


//module tx_top(
//    input wire logic clk,
//    input wire logic btnc,
//    input wire logic btnu,
//    output logic[1:0] led
//    );
//    wire clk10_4;
//    wire locked;
//    generate_PN11(.start(btnc),.clk(clk10_4),.clr(btnu),.out_bit(led[1]));
//    clk_wiz_1(.reset(btnu),.clk_in1(clk),.locked(locked),.clk_out1(clk10_4));
//    assign led[0] = clk10_4;
//endmodule

module tx_top(
    input wire logic CLK100MHZ,
    input wire logic btnC,
    input wire logic btnU,
    output logic[1:0] LED,
    output logic[1:0] JA
    );
    logic clk10_4;
    logic out_data;
    logic locked;
    generate_PN11(.start(btnC),.clk(clk10_4),.clr(btnU),.out_bit(out_data));
    clk_wiz_1(.reset(btnU),.clk_in1(CLK100MHZ),.locked(locked),.clk_out1(clk10_4));
    assign JA[1] = clk10_4;
    assign JA[0] = out_data;
    assign LED[1] = out_data;
    assign LED[0] = clk10_4;
endmodule

