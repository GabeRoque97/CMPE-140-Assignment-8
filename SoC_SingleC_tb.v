`timescale 1ns / 1ps

module SoC_SingleC_tb;
    reg clk, rst;
    reg [31:0] gpIn1;
    wire [31:0] gpOut1, gpOut2;
    reg [31:0] ra3; 
    wire [31:0] rd3; 
    wire dispSe, factErr;
    
    system DUT( 
        .clk (clk),
        .rst (rst),
        .ra3(ra3),
        .rd3(rd3),
        .gpI1 (gpIn1),
        .gpO1 (gpOut1),
        .gpO2 (gpOut2),
        .gpI2 (gpOut1)
    );
    
    assign dispSe = gpOut1[4];
    assign factErr = gpOut1[0];
    
    integer i,j;
    
    initial begin
        rst = 1;
        tick;
        rst = 0; 
        for(i = 0; i < 65; i = i + 1)begin
            tick;   
        end
    
    //while(factErr == 0) tick;
    
    end
    
    task tick; 
    begin  
            clk <= 0; #5;
            clk <= 1; #5; 
            end
    endtask
endmodule
