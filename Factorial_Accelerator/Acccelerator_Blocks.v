`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2019 02:00:27 PM
// Design Name: 
// Module Name: Acccelerator_Blocks
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

module Factorial_Address_Decoder(
    input [1:0] A,
    input WE, 
    output wire WE1, WE2, 
    output wire [1:0] RdSel
); 
    reg [1:0] control; 
    assign {WE1, WE2} = control; 
    assign RdSel = A; 
    always@(A, WE)begin
        
        if(WE) begin
            case(A)
                'b00: control <= 'b1_0; 
                
                'b01: control <= 'b0_1; 
                
                default: control <= 'b0_0; 
                
            endcase
        end
        else begin
            control <= 'b00; 
        end
        
    end
endmodule

module f_register #(parameter width = 32)(
    input clk, en, rst,
    input [width-1:0] D,
    output reg [width-1:0] Q
); 
    always@(posedge clk, posedge rst) begin
        if(rst) Q <= 0;
        else if(en) Q <= D;
        else Q <= Q; 
    end
endmodule

module set_reset_register(
    input clk, set, reset,
    output reg Q
); 
    always@(posedge clk, posedge reset) begin 
        if(reset) Q <= 'b0;
        else if(set) Q <= 'b1; 
        else Q <= Q;
    end

endmodule

module f_output_mux(
    input [1:0] sel,
    input [31:0] a, b, c, d,
    output reg [31:0] Q
); 
    always@(*) begin
        case(sel) 
            'b00: Q <= a;
            'b01: Q <= b; 
            'b10: Q <= c; 
            'b11: Q <= d; 
            default: Q <= a;     
        endcase
    end

endmodule