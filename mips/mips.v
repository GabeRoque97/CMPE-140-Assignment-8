module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    wire       branch;
    wire       jump;
    wire [1:0] reg_dst; //2 bits
    wire       shift;   //shift operation selecter
    wire       jal_sel; //JAL selecter
    wire       jr_sel;  //JR selecter
    wire       multu_en;// HI & LO reg enable
    wire [1:0] super_sel;//super mux selecter    
    wire       we_reg;  
    wire       alu_src;
    wire       dm2reg;
    wire [2:0] alu_ctrl;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3),
            .shift          (shift), //new
            .jr_sel         (jr_sel), //new
            .jal_sel        (jal_sel),// new
            .multu_en       (multu_en),//new
            .super_sel      (super_sel)//new
            
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .branch         (branch),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .shift          (shift), //new
            .jr_sel         (jr_sel), //new
            .jal_sel        (jal_sel),// new
            .multu_en       (multu_en),//new
            .super_sel      (super_sel)//new
        );

endmodule
