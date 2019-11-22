`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2019 01:31:55 PM
// Design Name: 
// Module Name: Factorial_Accelerator
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


module Factorial_Accelerator(
    input [1:0] A,
    input [3:0] WD,
    input WE,  
    input clk, rst, 
    output [31:0] RD
    );
    
    wire [3:0] n; 
    wire [31:0] nf, Result; 
    
    wire go_en, n_en; 
    wire [1:0] RdSel; 
    
    wire Go, Done, Err, ResDone, ResErr; 
    wire GoPulse; 
    
    wire GoPulseCmb; 
    Factorial_Address_Decoder FAD(
        .A(A),
        .WE(WE), 
        .WE1(n_en),
        .WE2(go_en), 
        .RdSel(RdSel)
    ); 
    
    f_register #1 go_register(
        .clk(clk),
        .rst(rst),
        .en(go_en), 
        .D(WD[0]), 
        .Q(Go)
    ); 
    
    assign GoPulseCmb = WD[0] & go_en; 
    
    f_register #1 GoPulse_register(
        .clk(clk),
        .rst(rst),
        .en('b1), 
        .D(GoPulseCmb), 
        .Q(GoPulse)
    ); 
    
    f_register #4 n_register(
        .clk(clk),
        .rst(rst),
        .en(n_en),
        .D(WD), 
        .Q(n)
    ); 
    
    f_register result_register(
        .clk(clk),
        .rst(rst),
        .en(Done),
        .D(nf),
        .Q(Result)
    ); 
    
    Factorial FA(
        .clk(clk),
        .rst(rst),
        .go(GoPulse), 
        .n({28'b0, n}), 
        .done(Done), 
        .Error(Err), 
        .result(nf)
    ); 
    
    set_reset_register done_sr(
        .clk(clk),
        .set(Done), 
        .reset(GoPulseCmb), 
        .Q(ResDone)
    );
    
    set_reset_register err_sr(
        .clk(clk),
        .set(Err), 
        .reset(GoPulseCmb), 
        .Q(ResErr)
    ); 
    
    f_output_mux output_mux(
        .sel(RdSel),
        .a({28'b0, n}),
        .b({31'b0, Go}),
        .c({30'b0, ResErr, ResDone}),
        .d(Result),
        .Q(RD)
    ); 
    
    
endmodule
