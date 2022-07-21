`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2022 10:00:08 AM
// Design Name: 
// Module Name: GenerateOutput
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


module GenerateOutput(
    input wire logic clk,
    input wire logic start,
    input wire logic clr,
    output logic out_bit
    );

    logic enablePn11 = 0;
    logic startPreamble;
    logic preambleFinished;
    logic preambleOut;
    logic pn11Out;
    logic[11:0] counter3200;

    PN11 pn11_mod(.clk(clk), .enable(enablePn11), .clr(clr), .out_bit(pn11Out));
    Preamble preamble_mod(.clk(clk), .start(startPreamble), .finished(preambleFinished), .out_bit(preambleOut));


    typedef enum logic[1:0] {idle, preamble, pn11, ERR='X}StateType;
    StateType ns,cs;


    // Logic for state machine
    always_comb
    begin
        ns = ERR;
        out_bit = 0;
        startPreamble = 0;
        enablePn11 = 0;


        if(clr)
        begin
            ns = idle;
        end

        else
        begin
            case(cs)
                idle:
                begin
                    if(start)
                    begin
                        ns = preamble;
                        startPreamble = 1;
                    end
                    else
                    begin
                        ns = idle;
                    end
                end
                preamble:
                begin
                    out_bit = preambleOut;
                    if(preambleFinished)
                    begin
                        ns = pn11;
                        enablePn11 = 1;
                    end
                    else
                    begin
                        ns = preamble;
                    end
                end
                pn11:
                begin
                    out_bit = pn11Out;
                    if(counter3200 <= 3199)
                    begin
                        enablePn11 = 1;
                        ns = pn11;
                    end
                    else
                    begin
                        ns = preamble;
                        startPreamble = 1;
                    end
                end
            endcase
        end
    end

    always_ff@(posedge clk)
    begin
        cs <= ns;
    end

    // A counter for the pn11 sequence
    always_ff@(posedge clk)
    begin
        if(enablePn11)
        begin
            if (counter3200 <= 3199)
            begin
                counter3200 <= counter3200 + 1;
            end
            else
            begin
                counter3200 <= 0;
            end
        end
        else
        begin
            counter3200 <= 0;
        end
    end

endmodule
