module shifter(
        input wire  [31:0]a,
        input wire  [4:0]shamt,
        input wire  op1,
        output reg  [31:0]y
    );
    
always@(*)
begin
    if(op1) y = (a >> shamt); // shift right
    else y = (a << shamt); // shift left
end
endmodule
