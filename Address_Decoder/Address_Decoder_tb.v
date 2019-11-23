`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 02:31:42 PM
// Design Name: 
// Module Name: Address_Decoder_tb
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


module Address_Decoder_tb;
    reg clk; 
    
    reg [31:0] Address;
    reg write_enable; 
    
    wire out_WE1, out_WE2, out_WEM;
    wire [1:0] Read_Data_Sel; 
    
    Address_Decoder DUT(
        .A(Address),
        .WE(write_enable),
        .WE1(out_WE1),
        .WE2(out_WE2),
        .WEM(out_WEM),
        .RdSel(Read_Data_Sel)
    );
    
    reg [31:0] i; 
    initial begin
    
        // Memory Module
        for(i = 0; i < 'hFD; i = i + 1) begin
            Address <= i; 
            write_enable <= 0;
            tick; 
        end
        
        for(i = 0; i < 'hFD; i = i + 1) begin
            Address <= i; 
            write_enable <= 1;
            tick; 
        end
        
        // Factorial Module
        for(i = 0; i < 'h0C; i = i + 1) begin
            Address <= i + 'h800; 
            write_enable <= 0;
            tick; 
        end
        
        for(i = 0; i < 'h0C; i = i + 1) begin
            Address <= i + 'h800; 
            write_enable <= 1; 
            tick;
        end 
        
        // GPIO Module
        for(i = 0; i < 'h0C; i = i + 1) begin
            Address <= i + 'h900; 
            write_enable <= 0;
            tick; 
        end
        
        for(i = 0; i < 'h0C; i = i + 1) begin
            Address <= i + 'h900; 
            write_enable <= 1;
            tick; 
        end
        
        // unmapped Addresses
        for(i = 0; i < 'hFF; i = i + 1) begin
            Address <= i + 'h100; 
            write_enable <= 1;
            tick; 
        end
        for(i = 0; i < 'hFF; i = i + 1) begin
            Address <= i + 'h200; 
            write_enable <= 0;
            tick; 
        end
        for(i = 0; i < 'hFF; i = i + 1) begin
            Address <= i + 'h1000; 
            write_enable <= 1;
            tick; 
        end
        
    end
    
    
    
    task tick; begin  
        clk <= 0; #5;
        clk <= 1; #5; 
        end
    endtask
endmodule
