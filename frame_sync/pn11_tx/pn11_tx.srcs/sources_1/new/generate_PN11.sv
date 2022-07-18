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
    logic tmr_done, pilot_done, counter_reset, pilot_reset, clr_register;
    logic[10:0] register = 11'b10000000000;
    logic[15:0] pilot_bits;
    logic[11:0] counter3200 = 0; //4096 bits
    logic[10:0] counter2048 = 0; //2048 bits
    logic[7:0] counter128 = 0; //128 bits
    typedef enum logic[1:0] {idle, pilot, PN11, ERR='X}StateType;
    StateType ns,cs;
    
    
    always_comb
        begin
        ns = ERR;
        pilot_reset = 1;
        counter_reset = 0;
        out_bit = 0;
        clr_register = 0;
        
        if(clr)
            ns = idle;
        else
            case(cs)
                idle: 
                    begin
                        if(start)
                            begin 
                            ns = pilot;
                            pilot_reset = 0;
                            counter_reset = 1;
                            clr_register = 1;
                            end
                        else
                            begin
                            ns = idle;
                            end
                    end
                PN11: if(tmr_done)
                        begin
                        ns = pilot;
                        pilot_reset = 0;
                        out_bit = register[10];
                        end
                    else
                        begin
                        out_bit = register[10];
                        
                        pilot_reset = 1;
                        ns = PN11;
                        if(counter2048 != 0)
                            begin
                        
                            
                            end


                                               
                        end
                        
                pilot:
                    if (pilot_done)
                        begin
                        ns = PN11;
                        pilot_reset = 1;
                        out_bit = pilot_bits[15];
                        end
                    else 
                        begin
                        ns = pilot;
                        out_bit = pilot_bits[15];
                        pilot_reset = 0;
                        end
                        
                        
            endcase
        end
    
    //state switch
    always_ff@(posedge clk)
        cs <= ns;
    
    //counter
    always_ff@(posedge clk)
    begin
        if (clr_register)
            begin
            register <= 11'b10000000000;
            end
        if (counter_reset)
            begin
            counter128 <= 0;
            counter2048 <= 0;
            counter3200 <= 0;
            end
        if(pilot_reset)
            begin
            counter128 <= 0;
            pilot_bits = 16'b0110011011001100; //CD98 in hex, rotated
            if (counter2048 <= 2046)
                begin                 
                counter2048 <= counter2048 + 1;
                if (counter2048 > 0)
                    begin
                    register[10] <= register[9];  
                    register[9] <= register[8];
                    register[8] <= register[7];
                    register[7] <= register[6];
                    register[6] <= register[5];
                    register[5] <= register[4];
                    register[4] <= register[3];
                    register[3] <= register[2];
                    register[2] <= register[10]^register[1];
                    register[1] <= register[0];
                    register[0] <= register[10];
                    end
                end
            else
                begin
                counter2048 <= 1;
                register <= 11'b10000000000;
                end 
            if (counter3200 <= 3199)
                begin
                counter3200 <= counter3200 + 1;
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
                pilot_bits <= {{pilot_bits[14:0]}, {pilot_bits[15]}};
                counter2048 <= counter2048;
                counter3200 <= counter3200;
                end
            end
        end
endmodule
