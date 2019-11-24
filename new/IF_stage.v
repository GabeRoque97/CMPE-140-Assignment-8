module IF_stage(
     input wire clk,
     input wire rst,
     input wire [31:0] pc_plus_4F,
     input wire [31:0] instrF,
     output reg [31:0] pc_plus_4D,
     output reg [31:0] instrD
    );
    
always@(posedge clk, posedge rst)begin
    if(rst)
    begin
        pc_plus_4D <= 0;
        instrD <= 0; 
    end
    else 
    begin 
        pc_plus_4D <= pc_plus_4F; 
        instrD <= instrF; 
    end       
end
    
endmodule
