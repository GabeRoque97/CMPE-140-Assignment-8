`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 12:55:49 PM
// Design Name: 
// Module Name: AddrDec
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


module AddrDec(
    input wire [1:0]    A,
    input wire          WE,
    output wire         WE2,
    output wire         WE1,
    output wire [1:0]   Read_Sel
    );
    
    reg [1:0] ctrl;
    
    assign {WE2, WE1} = ctrl;
    assign {Read_Sel} = A;
    
    always @ (A, WE) begin
        if(WE) begin
            case (A)
            2'b00: ctrl = 2'b0_0; //propegate gpl1 to RD
            2'b01: ctrl = 2'b0_0; //propegate gpl2 to RD
            2'b10: ctrl = 2'b0_1; //propegate gpO1 to RD
            2'b11: ctrl = 2'b1_0; //propegate gpO2 to RD
            endcase           
        end
        
        
    end     
endmodule
