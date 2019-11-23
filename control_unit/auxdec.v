module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [2:0] alu_ctrl,
        output wire       shift,    // shift left = 0, shift right = 1
        output wire       jr_sel,   // select jr 
        output wire       multu_en, // enable HI and LO reg
        output wire [1:0] super_sel // select input for super_mux
    );

    reg [7:0] ctrl;

    assign {shift, jr_sel, multu_en, super_sel, alu_ctrl} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)   // alu_ctrl   shift
            2'b00: ctrl = 8'b010;          // ADD
            2'b01: ctrl = 8'b110;          // SUB
            default: case (funct)
                //ALU 
                6'b10_0100: ctrl = 8'b0_0_0_00_000; // AND 
                6'b10_0101: ctrl = 8'b0_0_0_00_001; // OR
                6'b10_0000: ctrl = 8'b0_0_0_00_010; // ADD
                6'b10_0010: ctrl = 8'b0_0_0_00_110; // SUB
                6'b10_1010: ctrl = 8'b0_0_0_00_111; // SLT
                
                //MULTU, MFHI, MFLO
                6'b01_1001: ctrl = 8'b0_0_1_00_100; // MULTU
                6'b01_0000: ctrl = 8'b0_0_0_01_000; // MFHI
                6'b01_0010: ctrl = 8'b0_0_0_10_000; // MFLO
                
                //SLL & SLR
                6'b00_0000: ctrl = 8'b0_0_0_11_000; // SLL
                6'b00_0010: ctrl = 8'b1_0_0_11_000; // SLR
                
                //JR
                6'b00_1000: ctrl = 8'b0_1_0_00_000; // JR 
                default:    ctrl = 8'b0_0_0_00_xxx;
            endcase
        endcase
    end

endmodule