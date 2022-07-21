`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: ICE lab
// Engineer: Preston Walker / Riley Kirkwood
// 
// Create Date: 07/21/2022 11:18 AM
// Design Name: 
// Module Name: Preamble
// Project Name: Generate PN11
// Target Devices: 
// Description: 
// 
// Dependencies: 
// 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PN11(
    input wire logic clk,
    input wire logic enable,
    input wire logic clr,
    output logic out_bit
);
logic[10:0] counter2047 = 0;
logic[10:0] pn11_bits = 11'b10000000000;

always_ff @(posedge clk)
begin
    if(clr)
    begin
        pn11_bits = 11'b10000000000;
        counter2047 = 0;
    end
    else if(enable)
    begin
        out_bit <= pn11_bits[10];
        pn11_bits[10:3] <= pn11_bits[9:2];
        pn11_bits[2] <= pn11_bits[1]^pn11_bits[10];
        pn11_bits[1] <= pn11_bits[0];
        pn11_bits[0] <= pn11_bits[10];

        if (counter2047 < 2047)
        begin
            counter2047 <= counter2047 + 1;
        end
        else
        begin
            counter2047 <= 1;
        end
    end

end
endmodule