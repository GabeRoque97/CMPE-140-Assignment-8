module mux2 #(parameter WIDTH = 8) (
        input  wire             sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        output reg [WIDTH-1:0] y
    );
    
    initial
    begin
        y = a;
    end
    always@(*)
    begin
        case(sel)
            1'b0:       y = a;
            1'b1:       y = b;
            default:    y = a;
        endcase
    end
endmodule

/*
module mux2 #(parameter WIDTH = 8) (
        input  wire             sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        output wire [WIDTH-1:0] y
    );

    assign y = (sel) ? b : a;

endmodule
*/
