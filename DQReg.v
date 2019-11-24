`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 01:23:58 PM
// Design Name: 
// Module Name: DQReg
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


module DQReg(
    input wire          En,
    input wire [31:0]   D,
    input wire          Clk,
    output reg [31:0]   Q,
    input Rst
    );
    
    always @ (posedge Clk, Rst) begin;
        if(En)
                 Q <= D;
        else
                 Q <= Q;
        if(Rst)
                 Q<=0;
   end
   
endmodule