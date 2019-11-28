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
        ra3 <= 'h09; 
        for(i = 0; i < 31; i = i + 1)begin
            gpIn1 = i; // Sel = 0 & n = 0 to 15
         
            for(j = 0; j < 19; j = j + 1)begin 
                tick;//clock through the driver code
            end
        
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
