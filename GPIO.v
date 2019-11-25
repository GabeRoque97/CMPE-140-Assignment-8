`timescale 1ns / 1ps

module GPIO(
    input wire [1:0]    A,
    input wire          WE,
    input wire [31:0]   gpI1,
    input wire [31:0]   gpI2,
    input wire [31:0]   WD,
    input wire          Rst,
    input wire          Clk,
    output wire [31:0]  RD,
    output wire [31:0]  gpO1,
    output wire [31:0]  gpO2
    );
    
    wire [31:0] gpOut1;
    wire [31:0] gpOut2;
    wire WE2;
    wire WE1;
    wire [1:0] Read_Sel;
    
    assign gpO1 = gpOut1;//error caught here
    assign gpO2 = gpOut2;//error caught here
    
    AddrDec AddrDec(
        .A  (A),
        .WE (WE),
        .WE2 (WE2),
        .WE1 (WE1),
        .Read_Sel (Read_Sel)
    );
    
    DQReg Reg2 (
        .En (WE2),
        .D  (WD),
        .Clk    (Clk),
        .Q  (gpOut2),
        .Rst (Rst)
    );
    
    DQReg Reg1 (
        .En (WE1),
        .D  (WD),
        .Clk    (Clk),
        .Q  (gpOut1),
        .Rst (Rst)
    ); 
    
    mux4 #(32) MuxA (
        .sel    (Read_Sel),
        .a  (gpI1),
        .b  (gpI2),  
        .c  (gpO1),
        .d  (gpO2),
        .y  (RD)
    );
    
endmodule
