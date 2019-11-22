`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2019 12:46:15 PM
// Design Name: 
// Module Name: Factorial_CU
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


module Factorial_CU(
    input wire Go, clk, 
    input wire GT_flag, inError,
    output wire Error, 
    output reg Load_count, Load_reg, EN, sel, sel2, 
    output reg done
    );
    reg [2:0] current_state, next_state;
    assign Error = inError; 
    always@(current_state, Go, GT_flag, inError) begin
        
        case (current_state)
            'b000: begin 
                   if (inError | ~Go) next_state <= 'b000;
                   else              next_state <= 'b001;
                   end
            'b001: next_state <= 'b010;
            'b010: next_state <= 'b011;  
            'b011: begin
                   if (GT_flag) next_state <= 'b100;
                   else         next_state <= 'b110;
                   end 
             'b100: next_state <= 'b101;
             'b101:begin
                   if (GT_flag) next_state <= 'b100;
                   else         next_state <= 'b110;
                   end 
             'b110: next_state <= 'b000; 
             default: next_state <= 'b000; 
        endcase
     end 
    //at clock, load next state into current state
    always@(posedge clk) begin
        current_state <= next_state; 
    end
    //at change of current state, update output signals
    always@(current_state) begin
        case (current_state)
            'b000: begin    //idle
                   Load_count <= 0;
                   EN <= 0;
                   Load_reg <= 0; 
                   sel <= 1;
                   sel2 <= 0;
                   done <= 0; 
                   end 
            'b001: begin    //load data
                   Load_count <= 1;
                   EN <= 1;
                   Load_reg <= 1; 
                   sel <= 1;
                   sel2 <= 0;
                   done <= 0; 
                   end 
            'b010: begin    //wait
                   Load_count <= 0;
                   EN <= 0;
                   Load_reg <= 0; 
                   sel <= 1;
                   sel2 <= 0;
                   done <= 0; 
                   end 
            'b011: begin    //wait
                   Load_count <= 0;
                   EN <= 0;
                   Load_reg <= 0; 
                   sel <= 1;
                   sel2 <= 0;
                   done <= 0; 
                   end
            'b100: begin    //load register, count down
                   Load_count <= 0;
                   EN <= 1;
                   Load_reg <= 1; 
                   sel <= 0;
                   sel2 <= 0;
                   done <= 0; 
                   end 
            'b101: begin    //wait 
                   Load_count <= 0;
                   EN <= 0;
                   Load_reg <= 0; 
                   sel <= 0;
                   sel2 <= 0;
                   done <= 0; 
                   end 
            'b110: begin    //Done
                   Load_count <= 0;
                   EN <= 0;
                   Load_reg <= 0; 
                   sel <= 0;
                   sel2 <= 1;
                   done <= 1;
                   end
            
        endcase
    end
    
endmodule
