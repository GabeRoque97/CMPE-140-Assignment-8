`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 01:48:09 PM
// Design Name: 
// Module Name: Address_Decoder
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


module Address_Decoder(
    input [31:0] A,
    input WE,
    
    output reg WE1, WE2, WEM, 
    output reg [1:0] RdSel
    );
    
    always@(A, WE)begin
        casez(A) 
            32'h0000_00??: begin
                WEM <= WE; 
                WE1 <= 0; 
                WE2 <= 0; 
                RdSel <= 0; 
            end
            
            32'h0000_08??: begin
                WE1 <= WE;
                WEM <= 0;
                WE2 <= 0;  
                RdSel <= 2; 
            end
            
            32'h0000_09??: begin
                WE2 <= WE; 
                WEM <= 0;
                WE1 <= 0; 
                RdSel <= 3;                 
            end
            
            default: begin
                WEM <= 0;
                WE2 <= 0;
                WE1 <= 0; 
                RdSel <= 0; 
            end
        endcase
    end
endmodule
