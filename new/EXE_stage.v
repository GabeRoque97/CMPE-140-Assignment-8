`timescale 1ns / 1ps

module EXE_stage(
     input wire clk,
     input wire multu_enE,
     input wire jr_selE,
     input wire [2:0] super_selE,
     input wire branchE,
     input wire dm2regE,
     input wire jumpE,
     input wire we_dmE,
     input wire jal_selE,
     input wire we_regE,
     input wire [31:0] pc_plus_4E,
     input wire [31:0] btaE,//pc_plus_brE was wrong naming
     input wire [31:0] alu_paE,
     input wire [63:0] alu_outE,
     input wire zeroE,
     input wire [31:0] wd_dmE,
     input wire [31:0] shiftyE,
     input wire [31:0] jtaE,
     input wire [4:0] rf_waE,
     input wire [31:0] HI_qE,
     input wire [31:0] LO_qE,
     
          output reg multu_enM,
          output reg jr_selM,
          output reg [2:0] super_selM,
          output reg branchM,
          output reg dm2regM,
          output reg jumpM,
          output reg we_dmM,
          output reg jal_selM,
          output reg we_regM,
          output reg [31:0] pc_plus_4M,
          output reg [31:0] btaM,//pc_plus_brM was wrong naming
          output reg [31:0] alu_paM,
          output reg [63:0] alu_outM,
          output reg zeroM,
          output reg [31:0] wd_dmM,
          output reg [31:0] shiftyM,
          output reg [31:0] jtaM,
          output reg [4:0] rf_waM,
          output reg [31:0] HI_qM,
          output reg [31:0] LO_qM

    );
    
    always@(posedge clk)begin
        //Control signals
        multu_enM <= multu_enE;
        jr_selM <= jr_selE;
        super_selM <= super_selE;
        branchM <= branchE;
        dm2regM <= dm2regE;
        jumpM <= jumpE;
        we_dmM <= we_dmE;
        jal_selM <= jal_selE;
        we_regM <= we_regE;
        
        //DP signals
        pc_plus_4M <= pc_plus_4E;
        btaM <= btaE;
        alu_paM <= alu_paE;
        alu_outM <= alu_outE;
        zeroM <= zeroE;
        wd_dmM <= wd_dmE;
        shiftyM <= shiftyE;
        jtaM <= jtaE;
        rf_waM <= rf_waE;
        HI_qM <= HI_qE;
        LO_qM <= LO_qE;
    end
endmodule
