module DQReg(
        input wire          En,
        input wire [31:0]   D,
        input wire          clk,
        output reg [31:0]   Q,
        input wire rst
    );
    
always @ (posedge clk, posedge rst)
begin
    if(rst) Q <= 0;
    else if(En) Q <= D;
    else Q <= Q;
end
   
endmodule
