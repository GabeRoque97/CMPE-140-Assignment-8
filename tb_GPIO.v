`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 02:25:15 PM
// Design Name: 
// Module Name: tb_GPIO
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


module tb_GPIO;
    reg         Clk;
    reg         Rst;
    reg        WE;
    reg [1:0]  A;
    reg [31:0] gpI1;
    reg [31:0] gpI2;
    reg [31:0] WD;
    wire [31:0] RD;
    reg [31:0] gpOut1;
    reg [31:0] gpOut2;
    
        GPIO tbGPIO (
            .Clk            (Clk),
            .Rst            (Rst),
            .WE             (WE),
            .A              (A),
            .gpI1           (gpI1),
            .gpI2           (gpI2),
            .WD             (WD)
        );
    task tick; 
    begin 
        Clk = 1'b0; #5;
        Clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        Rst = 1'b0; #5;
        Rst = 1'b1; #5;
        Rst = 1'b0;
    end
    endtask
    
    integer i;
    initial begin
        reset;
        
        for(i = 0; i<4; i=i+1) begin
              A=i; 
              WE=0;  
              gpI1=10;
              WD = 5;
              gpOut1 = 7;
              tick;
        end
        for(i = 0; i<4; i=i+1) begin
              A=i;
              WE=1; 
              gpI2=11;
              WD = 7;
              gpOut2 = 9;
              tick;
              
        end
         
    end

endmodule

/*
module tb_GPIO;
reg     clk;
reg     rst;
reg     WE;
reg     [1:0]  A;
reg     [31:0] gpI1;
reg     [31:0] gpI2;
reg     [31:0] WD;
wire    [31:0] RD;
wire    [31:0] gpOut1;
wire    [31:0] gpOut2;
    
    GPIO DUT (
            .clk            (clk),
            .rst            (rst),
            .WE             (WE),
            .A              (A),
            .gpI1           (gpI1),
            .gpI2           (gpI2),
            .WD             (WD),
            .RD             (RD),
            .gpO1           (gpOut1),
            .gpO2           (gpOut2)
        );
        
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    
    integer i;
    initial
    begin
        reset;
        
        WE=1;
        for(i = 0; i<4; i=i+1) begin
              A=i;  
              gpI1=i+1;
              gpI2=i*3;
              WD = i*4;
             
              tick;
        end
        WE=0;
        
        for(i = 0; i<4; i=i+1) begin
              A=i;  
              gpI1=i+1;
              gpI2=i*3;
              WD = i*5;
             
              tick;
        end         
    end

endmodule

*/
