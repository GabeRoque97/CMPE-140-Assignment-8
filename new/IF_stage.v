`timescale 1ns / 1ps

module IF_stage(
     input wire clk,
     input wire rst,
     input wire [31:0] pc_plus_4F,
     input wire [31:0] InstrF,
     output reg [31:0] pc_plus_4D,
     output reg [31:0] InstrD
    );
    
    always@(posedge clk, posedge rst)begin
        if(rst) begin pc_plus_4D <= 0;
                      InstrD <=0; 
                end
        else begin 
                    pc_plus_4D <= pc_plus_4F; 
                    InstrD <= InstrF; 
             end

        
    end
endmodule
