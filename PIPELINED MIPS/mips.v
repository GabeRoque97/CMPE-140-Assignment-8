module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [63:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instrF         (instr),
            .rd_dmM         (rd_dm),
            .we_dmM         (we_dm),
            .pc_currentF    (pc_current),
            .alu_outM       (alu_out),
            .wd_dmM         (wd_dm),
            .rd3            (rd3)            
        );

endmodule
