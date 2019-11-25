`timescale 1ns / 1ps

module DQReg(
    input wire          En,
    input wire [31:0]   D,
    input wire          Clk,
    output reg [31:0]   Q,
    input wire Rst
    );
    
    always @ (posedge Clk, Rst) begin
        if(En)
                 Q <= D;
        else
                 Q <= Q;
        if(Rst)
                 Q<=0;
   end
   
endmodule
