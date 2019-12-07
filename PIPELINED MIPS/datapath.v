module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instrF,
        input  wire [31:0] rd_dmM,
        output wire        we_dmM,
        output wire [31:0] pc_currentF,
        output wire [63:0] alu_outM,
        output wire [31:0] wd_dmM,
        output wire [31:0] rd3
    );


    
    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire [31:0]jal_out;//output of jal_mux
    wire [31:0]HI_q;//output of HI reg
    wire [31:0]LO_q;//output of LO reg
    wire [31:0]shifty;//output of combinational shifter
    wire [31:0]super_y;//output of super_mux, originally in write back, moved to mem-stage
    wire [31:0]pc_jmp;//output of pc_jmp_mux
    wire        zero;
    
    //newly added intermediate wires from here
    wire    branchD;
    wire    jumpD;
    wire    jal_selD;
    wire    jr_selD;
    wire    shiftD;
    wire    multu_enD;
    wire    we_regD;
    wire    alu_srcD;
    wire    we_dmD;
    wire    dm2regD;
    wire    shiftE;
    wire    zeroE;
    wire    alu_srcE;
    wire    we_regE;
    wire    multu_enE;
    wire    branchE;
    wire    jal_selE;
    wire    jr_selE;
    wire    dm2regE;
    wire    jumpE;
    wire    we_dmE;
    wire    br_and_zeroM;
    wire    jumpM;
    wire    dm2regM;
    wire    jr_selM;
    wire    jal_selM;
    wire    multu_enM;
    wire    branchM;
    wire    zeroM;
    wire    we_regM;
    wire    we_regW;
    wire    jumpW;
    wire    jr_selW;
    wire    multu_enW;
    wire    dm2regW;
    wire    jal_selW;
    
    wire [1:0]reg_dstD;
    wire [1:0]reg_dstE;
    wire [1:0]super_selD;
    wire [1:0]super_selE;
    wire [1:0]super_selM;
    wire [2:0]alu_ctrlD;
    wire [2:0]alu_ctrlE;
    wire [4:0]rf_waE;
    wire [4:0]rf_waM;
    wire [4:0]rf_waW;
    wire [31:0] rd1D; 
    wire [31:0] rd2D; 
    wire [31:0]instrD;
    wire [31:0]alu_paD;
    wire [31:0]wd_dmD;
    wire [31:0]sext_immD;
    wire [31:0]rd3D;

    wire [31:0]btaE;
    wire [31:0]alu_paEO;
    wire [31:0]wd_dmEO;
    wire [31:0]alu_paE;
    wire [31:0]wd_dmE;
    wire [31:0]sext_immE;
    wire [31:0] super_yW; 
    
    
    wire [31:0]shiftyE;
    
    wire [31:0]jtaE;
    wire [31:0]instrE;
    wire [31:0]btaM;
    wire [31:0]alu_paM;
    wire [31:0]jtaM;
    wire [31:0]shiftyM;
    wire [31:0]HI_qM;
    wire [31:0]LO_qM;
    wire [31:0]jtaW;
    wire [31:0]alu_paW;
    wire [31:0]wd_rfW;
    wire [31:0]rd_dmW;
    
    wire [4:0] ra1D, ra2D; 
    wire [4:0] ra1E, ra2E; 
    
    wire [31:0]pc_plus_4F;
    wire [31:0]pc_plus_4D;
    wire [31:0]pc_plus_4E;
    wire [31:0]pc_plus_4M;
    wire [31:0]pc_plus_4W;
    wire [63:0]alu_outE;
    wire [63:0]alu_outW;
    //to here
    
    
    
    assign ra1D = instrD[25:21]; 
    assign ra2D = instrD[20:16]; 
    assign br_and_zeroM = branchM & zeroM;
    assign ba = {sext_immE[29:0], 2'b00};
    assign jtaE = {pc_plus_4E[31:28], instrE[25:0], 2'b00};
    
    // --- Instruction Fetch Register --- //
    IF_stage IF_stage(
             .clk           (clk),
             .rst           (rst),
             .pc_plus_4F    (pc_plus_4F),
             .instrF        (instrF),
             .pc_plus_4D    (pc_plus_4D),
             .instrD        (instrD)
        );
    
    // --- Instruction Decode Register --- //
    ID_stage ID_stage(//note that we use position-based port mapping for this module
            clk,
            multu_enD,
            jr_selD,
            shiftD,
            super_selD,
            alu_ctrlD,
            alu_srcD,
            branchD,
            dm2regD,
            jumpD,
            reg_dstD,
            we_dmD,
            jal_selD,
            we_regD,
            pc_plus_4D,
            alu_paD,
            wd_dmD,
            rd3D,
            instrD,
            sext_immD,
            multu_enE,
            jr_selE,
            shiftE,
            super_selE,
            alu_ctrlE,
            alu_srcE,
            branchE,
            dm2regE,
            jumpE,
            reg_dstE,
            we_dmE,
            jal_selE,
            we_regE,
            pc_plus_4E,
            alu_paEO,
            wd_dmEO,
            rd3,
            instrE,
            sext_immE,

            ra1D, 
            ra2D,
            ra1E,
            ra2E
        );
    
    // --- Instruction Execute Register --- //
    EXE_stage EXE_stage(//note that we use position-based port mapping for this module
            clk,
            multu_enE,
            jr_selE,
            super_selE,
            branchE,
            dm2regE,
            jumpE,
            we_dmE,
            jal_selE,
            we_regE,
            pc_plus_4E,
            btaE,//pc_plus_brE was wrong naming
            alu_paE,
            alu_outE,
            zeroE,
            wd_dmE,
            shiftyE,
            jtaE,
            rf_waE,

            multu_enM,
            jr_selM,
            super_selM,
            branchM,
            dm2regM,
            jumpM,
            we_dmM,
            jal_selM,
            we_regM,
            pc_plus_4M,
            btaM,//pc_plus_brM was wrong naming
            alu_paM,
            alu_outM,
            zeroM,
            wd_dmM,
            shiftyM,
            jtaM,
            rf_waM

        );
    
    // --- Instruction Memory Register --- //
    MEM_stage MEM_stage(
            clk,
            multu_enM,
            jr_selM,
            dm2regM,
            jumpM,
            jal_selM,
            we_regM,
            pc_plus_4M,
            alu_paM,
            alu_outM,
            rd_dmM,
            jtaM,
            rf_waM, 
            super_y,
            multu_enW,
            jr_selW,
            dm2regW,
            jumpW,
            jal_selW,
            we_regW,
            pc_plus_4W,
            alu_paW,
            alu_outW,
            rd_dmW,
            jtaW,
            rf_waW,
            super_yW
        );
    
    // --- Control Unit --- //
    controlunit cu (
            .opcode     (instrD[31:26]),
            .funct      (instrD[5:0]),
            .branch     (branchD),
            .jump       (jumpD),
            .jal_sel    (jal_selD),   //JAL selecter
            .jr_sel     (jr_selD),    //JR selecter
            .shift      (shiftD),     //Shift operation selecter
            .multu_en   (multu_enD),  //HI & LO reg enable 
            .reg_dst    (reg_dstD),   //2-bits
            .super_sel   (super_selD), //super mux selecter
            .we_reg     (we_regD),
            .alu_src    (alu_srcD),
            .we_dm      (we_dmD),
            .dm2reg     (dm2regD),
            .alu_ctrl   (alu_ctrlD)
        );

    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_currentF)
        );

    adder pc_plus_4 (
            .a              (pc_currentF),
            .b              (32'd4),
            .y              (pc_plus_4F)
        );

    adder pc_plus_br (
            .a              (pc_plus_4E),
            .b              (ba),
            .y              (btaE)
        );

    mux2 #(32) pc_src_mux (
            .sel            (br_and_zeroM),//.sel            (1'b0),//
            .a              (pc_plus_4F),
            .b              (btaM),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jumpW),//.sel            (1'b0),//
            .a              (pc_pre),
            .b              (jtaW),
            .y              (pc_jmp)
        );
        
    mux2 #(32) jr_mux (//mux for writing value of $ra to pc_next
            .a              (pc_jmp),
            .b              (alu_paW),
            .sel            (jr_selW),//.sel            (1'b0),//
            .y              (pc_next)            
        );

    // --- RF Logic --- //
    mux4 #(5) rf_wa_mux (
            .sel            (reg_dstE),
            .a              (instrE[20:16]),
            .b              (instrE[15:11]),
            .c              (5'b11111),//we want to write to register 31 ($ra)
            .d              (5'b00000), //may need to add this so input isn't floating
            .y              (rf_waE)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_regW),
            .ra1            (instrD[25:21]),
            .ra2            (instrD[20:16]),
            .ra3            (ra3),
            .wa             (rf_waW),
            .wd             (wd_rfW),
            .rd1            (rd1D),
            .rd2            (rd2D),
            .rd3            (rd3D)
        );

    signext se (
            .a              (instrD[15:0]),
            .y              (sext_immD)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_srcE),
            .a              (wd_dmE),
            .b              (sext_immE),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrlE),
            .a              (alu_paE),
            .b              (alu_pb),
            .zero           (zeroE),
            .y              (alu_outE)
        );
        
    ENdreg LO_reg (//LO reg for multiplication
            .clk    (clk),
            .rst    (rst),
            .EN     (multu_enM),
            .d      (alu_outM[31:0]),
            .q      (LO_qM)
        );
    
    ENdreg HI_reg (//LO reg for multiplication
            .clk    (clk),
            .rst    (rst),
            .EN     (multu_enM),
            .d      (alu_outM[63:32]),
            .q      (HI_qM)
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2regW),
            .a              (jal_out),
            .b              (rd_dmW),
            .y              (wd_rfW)
        );
   
    mux4 #(32) super_mux (//for multiplexing input to regfile
            .sel    (super_selM),
            .a      (alu_outM[31:0]),
            .b      (HI_qM),
            .c      (LO_qM),
            .d      (shiftyM),
            .y      (super_y)
        );

    mux2 #(32) jal_mux (//for multiplexing pc_plus4 to regfile
            .a      (super_yW),
            .b      (pc_plus_4W),
            .sel    (jal_selW),
            .y      (jal_out)
        );
    
    shifter Shifter (//combinational shifter
            .a      (wd_dmE),
            .shamt  (instrE[10:6]),
            .op1    (shiftE),
            .y      (shiftyE)
        );
        
    data_forwarding_unit DFU(
        .ra1(ra1E), 
        .ra2(ra2E), 
        .wa_M(rf_waM), 
        .wa_W(rf_waW),      
        .rd1(alu_paEO), 
        .rd2(wd_dmEO), 
        .wd_rfM(super_y), 
        .wd_rfW(wd_rfW), 
        .data_a(alu_paE), 
        .data_b(wd_dmE)     
    ); 
    
    write_to_decode_forwarding WtDF(
        .ra1(ra1D), 
        .ra2(ra2D), 
        .wa(rf_waW),
        .rd1(rd1D),
        .rd2(rd2D),
        .wd_rf(wd_rfW),
        .data_a(alu_paD),
        .data_b(wd_dmD)
    ); 

endmodule
