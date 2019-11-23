module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire [1:0]  reg_dst, //2-bits
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire        dm2reg,
        input  wire        shift,//new
        input  wire        jr_sel,//new
        input  wire        multu_en,//new
        input  wire [1:0]  super_sel,//new
        input  wire        jal_sel, //new 
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire [31:0] pc_current,
        output wire [63:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );

    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire [31:0]jal_out;//new
    wire [31:0]HI_q;//new
    wire [31:0]LO_q;//new
    wire [31:0]shifty;//new
    wire [31:0]super_y;//new
    wire [31:0]pc_jmp;//new
    wire        zero;
    
    assign pc_src = branch & zero;
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre),
            .b              (jta),
            .y              (pc_jmp)
        );
        
    mux2 #(32) jr_mux (//new
            .a              (pc_jmp),
            .b              (alu_pa),
            .sel            (jr_sel),
            .y              (pc_next)            
        );

    // --- RF Logic --- //
    mux4 #(5) rf_wa_mux (
            .sel            (reg_dst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .c              (5'b11111),//we want to write to register 31 ($ra)
            .d              (5'b00000), //may need to add this so input isn't floating
            .y              (rf_wa)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (rf_wa),
            .wd             (wd_rf),
            .rd1            (alu_pa),
            .rd2            (wd_dm),
            .rd3            (rd3)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            .a              (wd_dm),
            .b              (sext_imm),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrl),
            .a              (alu_pa),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out)
        );
        
    ENdreg LO_reg (//new
            .clk    (clk),
            .rst    (rst),
            .EN     (multu_en),
            .d      (alu_out[31:0]),
            .q      (LO_q)
        );
    
    ENdreg HI_reg (//new
            .clk    (clk),
            .rst    (rst),
            .EN     (multu_en),
            .d      (alu_out[63:32]),
            .q      (HI_q)
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2reg),
            .a              (jal_out),
            .b              (rd_dm),
            .y              (wd_rf)
        );
   
   mux4 #(32) super_mux (//new
            .sel    (super_sel),
            .a      (alu_out[31:0]),
            .b      (HI_q),
            .c      (LO_q),
            .d      (shifty),
            .y      (super_y)
        );

    mux2 #(32) jal_mux (//new
            .a      (super_y),
            .b      (pc_plus4),
            .sel    (jal_sel),
            .y      (jal_out)
        );
    
    shifter Shifter (//new
            .a      (wd_dm),
            .shamt  (instr[10:6]),
            .op1    (shift),
            .y      (shifty)
        );

endmodule
