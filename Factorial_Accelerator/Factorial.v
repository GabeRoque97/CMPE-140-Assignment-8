`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2019 07:15:13 PM
// Design Name: 
// Module Name: Factorial
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


module Factorial(
    input wire clk, go, rst,
    input wire [31:0] n,
    output wire [31:0] result,
    output wire done, Error
    );
    
    wire [6:0] internal;
    Factorial_CU CU(
        .Go(go), 
        .clk(clk), 
        .GT_flag(internal[5]), 
        .inError(internal[6]),
        .Load_count(internal[0]),
        .Load_reg(internal[1]),
        .EN(internal[2]),
        .sel(internal[3]),
        .sel2(internal[4]),
        .done(done), 
        .Error(Error)
    ); 
    
    Factorial_DP DP(
        .n(n),   
        .result(result),
        .clk(clk),
        .rst(rst),
        .Load_count(internal[0]),
        .Load_reg(internal[1]),
        .EN(internal[2]),
        .sel(internal[3]),
        .sel2(internal[4]),
        .GT_flag(internal[5]),
        .error_flag(internal[6])
    );
    
    
    
endmodule
