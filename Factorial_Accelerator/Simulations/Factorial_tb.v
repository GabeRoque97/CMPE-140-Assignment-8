`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2019 07:43:25 PM
// Design Name: 
// Module Name: Factorial_tb
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


module Factorial_tb;
    reg clk, go;
    wire done, error; 
    reg [31:0] n;
    wire [31:0] result; 
    
    Factorial DUT(
    .clk(clk), 
    .go(go),
    .n(n),
    .result(result),
    .done(done), 
    .Error(error)
    ); 
   
    integer i;
    initial begin
    tick;
    go = 0;
    tick;
    
    n = 13; 
    go = 1; 
    tick; 
    go = 0; 
    tick; 
    
    for(i = 0; i < 13; i = 1 + i) begin
        go = 1;
        n = i; 
        tick; 
        go = 0; 
        while(done != 1) begin
        tick; 
        end
        tick; 
    end
    end
    
    
    task tick; begin  
        clk = 0; #5;
        clk <= 1; #5; 
        end
    endtask
endmodule
