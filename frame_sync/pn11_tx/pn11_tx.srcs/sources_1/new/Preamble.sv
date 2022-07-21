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


module Preamble(
    input wire logic clk,
    input wire logic start,
    output logic finished,
    output logic out_bit
);

logic[2:0] counter8;
logic[3:0] counter16;
logic[15:0] preamble_bits = 16'b0001100110110011;
logic counter8_finished;
logic counter16_finished;


always_ff @(posedge clk)
begin 

    // if the start goes high, reset the counters
    if (start) 
    begin 
        counter8 <= 0;
        counter16 <= 0;
        finished <= 0;
        out_bit <= preamble_bits[0];
    end
    else
    begin
    // count through the preamble 8 times
        // count through the preamble bits

        // this gets bits 0 through 14
        if (counter16 <= 14)
        begin
            out_bit <= preamble_bits[counter16+1];
            counter16 <= counter16 + 1;
            
            if (counter8 == 7 && counter16 == 14)
            begin
                finished <= 1;
            end
        end
        // get the 15th bit 
        else
        begin 
            counter16 <= 0;
            out_bit <= preamble_bits[0];
            counter8 <= counter8 + 1;
        end
        
    end
end


endmodule