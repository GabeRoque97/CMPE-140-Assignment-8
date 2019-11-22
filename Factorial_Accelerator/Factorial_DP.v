`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 09:06:16 PM
// Design Name: 
// Module Name: Factorial_DP
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


module Factorial_DP(
    input   wire [31:0] n,   //major input/output
    output  wire [31:0] result,
    
    //control sig inputs
    input   wire clk, rst,
    input   wire Load_count,
    input   wire Load_reg,
    input   wire EN,
    input   wire sel,
    input   wire sel2,
    output  wire GT_flag,
    output  wire error_flag
    );
    
    //defining wires between modules
    wire [31:0] Mux1Z_LoadRegD;
    wire [31:0] LoadRegQ_MulY;
    wire [31:0] MulZ_Mux2in1_Mux1in0;
    wire [31:0] DecramenterQ_GT_CMPA_MULX;
    
    //connections for Decrementer
    Decrementer Decrementer(
    .Load_count(Load_count),
    .EN(EN),
    .CLK(clk),
    .D(n),
    .Q(DecramenterQ_GT_CMPA_MULX)
    );
    
    //connections for GT_CMP2
    GT_CMP GT_CMP2(
    .A(n),
    .B('b1100),
    .GT(error_flag)
    );
    
    //connections for GT_CMP
    GT_CMP GT_CMP(
    .A(DecramenterQ_GT_CMPA_MULX),
    .B('b1),
    .GT(GT_flag)
    );
    
    //connections for Mux1
    Mux Mux1(
    .in0(MulZ_Mux2in1_Mux1in0),
    .in1('b1),
    .sel(sel),
    .Z(Mux1Z_LoadRegD)
    );
    
    //connections for Load_Reg
    Load_Reg Load_Reg(
    .D(Mux1Z_LoadRegD),
    .Load_reg(Load_reg),
    .CLK(clk),
    .rst(rst),
    .Q(LoadRegQ_MulY)
    );
    
    //connections for MUL
    MUL MUL(
    .X(DecramenterQ_GT_CMPA_MULX),
    .Y(LoadRegQ_MulY),
    .Z(MulZ_Mux2in1_Mux1in0)
    );
    
    //connections for Mux2
    Mux Mux2(
    .in0('b0),
    .in1(LoadRegQ_MulY),
    .Z(result),
    .sel(sel2)
    );
endmodule
