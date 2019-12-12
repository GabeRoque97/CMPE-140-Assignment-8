`timescale 1ns / 1ps

module data_forwarding_unit(
    input wire [4:0] ra1, ra2, wa_M, wa_W, 
    input wire [31:0] rd1, rd2, wd_rfM, wd_rfW,
    output reg [31:0] data_a, data_b
    );
    
    always@(*) begin
        if(ra1 == wa_W) begin
            data_a <= wd_rfW;
        end
        else if(ra1 == wa_M) begin
            data_a <= wd_rfM; 
        end
        else begin
            data_a <= rd1; 
        end
        
        if(ra2 == wa_W) begin
            data_b <= wd_rfW;
        end
        else if(ra2 == wa_M) begin
            data_b <= wd_rfM; 
        end
        else begin
            data_b <= rd2; 
        end
    end
endmodule


module write_to_decode_forwarding(
    input wire [4:0] ra1, ra2, wa,
    input wire [31:0] rd1, rd2, wd_rf,
    
    output reg [31:0] data_a, data_b
    );

    always@(*) begin
        if(ra1 == wa) data_a <= wd_rf; 
        else data_a <= rd1; 
        
        if(ra2 == wa) data_b <= wd_rf; 
        else data_b <= rd2; 
    end
endmodule