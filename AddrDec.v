`timescale 1ns / 1ps

module AddrDec(
    input wire [1:0]    A,
    input wire          WE,
    output wire         WE2,
    output wire         WE1,
    output wire [1:0]   Read_Sel
    );
    
    reg [1:0] ctrl;
    
    assign {WE2, WE1} = ctrl;
    assign {Read_Sel} = A;
    
    always @ (A, WE) begin
        if(WE) begin
            case (A)
            2'b00: ctrl = 2'b0_0; //propegate gpl1 to RD
            2'b01: ctrl = 2'b0_0; //propegate gpl2 to RD
            2'b10: ctrl = 2'b0_1; //propegate gpO1 to RD
            2'b11: ctrl = 2'b1_0; //propegate gpO2 to RD
            default: ctrl = 2'b0_0;
            endcase           
        end
        
        
    end     
endmodule
/*
module AddrDec(
        input wire [1:0]    A,
        input wire          WE,
        output wire         WE2,
        output wire         WE1,
        output wire [1:0]   Read_Sel
    );
    
reg [3:0] ctrl;

assign {WE2, WE1, Read_Sel} = ctrl;

always @ (*) begin
    case (A)
        2'b00: ctrl = 4'b0000; //propagate gpl1 to RD
        2'b01: ctrl = 4'b0001; //propagate gpl2 to RD
        2'b10: 
            begin
                if(WE) ctrl = 4'b0110; //propagate gpO1 to RD and write to gpO1 reg
                else ctrl = 4'b0010; //propagate gpO1 to RD
            end
        2'b11:
            begin
                if(WE) ctrl = 4'b1011; //propagate gpO2 to RD and write to gpO2 reg
                else ctrl = 4'b0011; //propagate gpO2 to RD
            end
        default: ctrl = 4'b0000;
    endcase           
end     
endmodule

*/
