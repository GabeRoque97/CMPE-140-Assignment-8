`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2019 09:54:59 PM
// Design Name: 
// Module Name: Factorial_Blocks
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

//Building Blocks for factorial system

module Mux(
    input wire [31:0] in1, in0, //32 bit inputs
    input sel,                  //1 bit sel input
    output reg [31:0] Z         //32 bit output 
    );
    always@(*) begin 
        if (sel == 'b0) Z = in0;  //sel set to 0, output in0
        if (sel == 'b1) Z = in1;  //sel set to 1, output in1
    end
endmodule

module GT_CMP(
    input wire [31:0] A, B,     //32 bit inputs
    output reg GT               //1 bit output
    );
    always@(*) begin
    GT = A > B;     //A > B, result into GT
    end
endmodule

//load/pass through register
module Load_Reg(
    input wire[31:0] D,
    input wire Load_reg,
    input wire CLK,
    input wire rst, 
    output reg [31:0] Q
    );
    always@(posedge CLK, posedge rst) begin
    if(rst) Q <= 0; 
    else if(Load_reg) Q <= D;
    else Q <= Q;
    end
endmodule

//32 bit multiplier
module MUL(
    input wire [31:0] X, Y,     //32 bit input operands
    output reg [31:0] Z         //32 bit output product
    );
    always@(*) begin
    Z <= X * Y;     // multiplies X with Y, puts product in Z
    end
endmodule

//load/count down Counter
module Decrementer(
    input wire [31:0] D,
    input wire Load_count,
    input wire EN,
    input wire CLK,
    output reg [31:0] Q
    );
    reg [31:0] count;
    always@(posedge CLK) begin
    if(EN & Load_count) count <= D;
    else if(EN)
        if(count > 0)count <= count-1;
        else count <= 0;
    else count <= count;
    Q <= count;
    end
endmodule