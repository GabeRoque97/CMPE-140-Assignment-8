`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 01:51:55 PM
// Design Name: 
// Module Name: F_Decoder_tb
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

module F_Decoder_tb; 
    reg clk; 
    reg [1:0] input_address;
    reg we_input; 
    wire we1_output, we2_output; 
    wire [1:0] RdSel_output; 
    
    Factorial_Address_Decoder DUT(
        .A(input_address),
        .WE(we_input),
        .WE1(we1_output),
        .WE2(we2_output),
        .RdSel(RdSel_output)
    );
    
    integer i; 
    
    initial begin
        //not write enabled
        for(i = 0; i < 4; i = i + 1)begin
            we_input <= 0; 
            input_address <= i; 
            tick; 
        end
        
        //is write enabled
        for(i = 0; i < 4; i = i + 1)begin
            we_input <= 1; 
            input_address <= i; 
            tick; 
        end
    end
    
    task tick; begin  
        clk <= 0; #5;
        clk <= 1; #5; 
        end
    endtask
endmodule
