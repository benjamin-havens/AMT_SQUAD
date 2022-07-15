`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: ICE lab
// Engineer: Preston Walker
// 
// Create Date: 07/14/2022 12:43:57 PM
// Design Name: 
// Module Name: generate_PN11
// Project Name: PN11 tx
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


module generate_PN11(
    input wire logic clk,
    input wire logic start,
    input wire logic clr,
    output logic out_bit
    );
    logic tmr_done, pilot_reset, pilot_done, counter_reset;
    logic[10:0] register = 11'b00000000001;
    logic[15:0] pilot_bits;
    logic[11:0] counter3200 = 0; //4096 bits
    logic[10:0] counter2048 = 0; //2048 bits
    logic[6:0] counter128 = 0; //128 bits
    typedef enum logic[1:0] {idle, pilot, PN11, ERR='X}StateType;
    StateType ns,cs;
    
    
    always_comb
        begin
        ns = ERR;
        pilot_reset = 0;
        counter_reset = 0;
        
        if(clr)
            ns = idle;
        else
            case(cs)
                idle: 
                    begin
                        if(start)
                            begin 
                            ns = pilot;
                            counter128 = 0;
                            pilot_bits = 16'b1100110110011000; //CD98 in hex
                            end
                        else
                            begin
                            ns = idle;
                            counter128 = 0;
                            end
                    end
                PN11: if(tmr_done)
                        begin
                        ns = pilot;
                        pilot_bits = 16'b1100110110011000; //CD98 in hex
                        end
                    else
                        begin
                        out_bit = register[0];
                        
                        pilot_reset = 1;
                        ns = PN11;
                        if(counter2048 != 0)
                            begin
                        
                            register[0] = register[1];  
                            register[1] = register[2];
                            register[2] = register[3];
                            register[3] = register[4];
                            register[4] = register[5];
                            register[5] = register[6];
                            register[6] = register[7];
                            register[7] = register[8];
                            register[8] = out_bit^register[9];
                            register[9] = register[10];
                            register[10] = out_bit;
                            end


                                               
                        end
                        
                pilot:
                    if (pilot_done)
                        begin
                        ns = PN11;
                        pilot_reset = 1;
                        end
                    else 
                        begin
                        ns = pilot;
                        out_bit = pilot_bits[15];
                        
                        end
                        
                        
            endcase
        end
    
    //state switch
    always_ff@(posedge clk)
        cs <= ns;
    
    //counter
    always_ff@(posedge clk)
    begin
        if(pilot_reset)
            begin
            counter128 <= 0;
            if (counter2048 <= 2046)
                begin
                counter2048 = counter2048 + 1;
                end
            else
                begin
                counter2048 <= 0;
                register <= 11'b00000000001;
                end 
            if (counter3200 <= 3199)
                begin
                counter3200 = counter3200 + 1;
                tmr_done <= 0;
                end
            else
                begin
                counter3200 <= 0;
                tmr_done <= 1;
                end
            end
        else
            begin
            if (counter128 <= 126)
                begin
                counter128 <= counter128 + 1;
                pilot_done <= 0;
                pilot_bits <= {{pilot_bits[14:0]}, {pilot_bits[15]}};
                end
            else
                begin
                pilot_done <= 1;
                end
            end
        end
endmodule
