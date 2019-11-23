module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire        jump,
        output wire        jal_sel,   //JAL selecter
        output wire        jr_sel,    //JR selecter
        output wire        shift,     //Shift operation selecter
        output wire        multu_en,  //HI & LO reg enable 
        output wire  [1:0] reg_dst,   //2-bits
        output wire  [1:0] super_sel, //super mux selecter
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        dm2reg,
        output wire [2:0]  alu_ctrl
    );
    
    wire [1:0] alu_op;

    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .reg_dst        (reg_dst),
        .we_reg         (we_reg),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .dm2reg         (dm2reg),
        .alu_op         (alu_op),
        .jal_sel        (jal_sel)    //JAL selecter
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl), 
        .shift          (shift),     //shift operation selecter
        .jr_sel         (jr_sel),    //JR selecter
        .multu_en       (multu_en),  //HI & LO reg enable
        .super_sel      (super_sel)  //super mux selecter 
    );

endmodule