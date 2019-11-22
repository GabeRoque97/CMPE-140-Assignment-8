`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 01:04:34 PM
// Design Name: 
// Module Name: F_Accel_tb
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


module F_Accel_tb;
    reg clk, rst; 
    reg [1:0] input_address; 
    reg write_enable;
    reg [3:0] write_data;
    
    wire [31:0] read_data; 

    Factorial_Accelerator tb(
        .A(input_address),
        .WE(write_enable),
        .WD(write_data),
        .rst(rst),
        .clk(clk),
        .RD(read_data)
    ); 
    
    integer i; 

    initial begin
    
        //reset
        tick;
        reset;
        tick; 
        
        //loop through all valid n inputs
        for(i = 0; i < 13; i = i +1) begin
        
            //write n
            write_data <= i; 
            input_address <= 0; 
            write_enable <= 1;
            tick;
            
            //write go
            write_data <= 1; 
            input_address <= 1; 
            write_enable <= 1; 
            tick;
            
            //read status bits
            write_data <= 'hZ; 
            input_address <= 2; 
            write_enable <= 0; 
            tick;
            
            //wait till done
            while(read_data[0] == 0) begin
                tick;
            end
            
            //read result
            write_data <= 'hZ; 
            input_address <= 3; 
            write_enable <= 0; 
            tick;   
        end
        
        
        //try INVALID n inputs
        for(i = 13; i < 16; i = i +1) begin
        
            //write n
            write_data <= i; 
            input_address <= 0; 
            write_enable <= 1;
            tick;
            
            //write go
            write_data <= 1; 
            input_address <= 1; 
            write_enable <= 1; 
            tick;
            
            //read status bits
            write_data <= 'hZ; 
            input_address <= 2; 
            write_enable <= 0; 
            tick;
            
            //wait till done or if Error
            while(read_data[0] || read_data[1] == 0) begin
                tick;
            end
            
            //read result
            write_data <= 'hZ; 
            input_address <= 3; 
            write_enable <= 0; 
            tick;   
        end
        
        //try reset mid calculation?
    
    end

    task tick; begin  
        clk <= 0; #5;
        clk <= 1; #5; 
        end
    endtask
    
    task reset; begin
        rst <= 0; 
        tick; 
        rst <= 1; 
        tick;  
        rst <= 0; 
        end
    endtask    
    
endmodule
