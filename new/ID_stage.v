`timescale 1ns / 1ps

module ID_stage(
    input wire clk,
    input wire multu_enD,
    input wire jr_selD,
    input wire shiftD,
    input wire [2:0] super_selD,
    input wire [2:0] alu_ctrlD,
    input wire alu_srcD,
    input wire branchD,
    input wire dm2regD,
    input wire jumpD,
    input wire [1:0] reg_dstD,
    input wire we_dmD,
    input wire jal_selD,
    input wire we_regD,
    input wire [31:0] pc_plus_4D,
    input wire [31:0] alu_paD,
    input wire [31:0] wd_dmD,
    input wire [31:0] rd3D,
    input wire [31:0] instrD,
    input wire [31:0] sext_immD,
    input wire [31:0] HI_qD,
    input wire [31:0] LO_qD,
    
      
        output reg multu_enE,
        output reg jr_selE,
        output reg shiftE,
        output reg [2:0] super_selE,
        output reg [2:0] alu_ctrlE,
        output reg alu_srcE,
        output reg branchE,
        output reg dm2regE,
        output reg jumpE,
        output reg [1:0] reg_dstE,
        output reg we_dmE,
        output reg jal_selE,
        output reg we_regE,
        output reg [31:0] pc_plus_4E,
        output reg [31:0] alu_paE,
        output reg [31:0] wd_dmE,
        output reg [31:0] rd3,
        output reg [31:0] instrE,
        output reg [31:0] sext_immE,
        output reg [31:0] HI_qE,
        output reg [31:0] LO_qE
           
    );
    
    always@(posedge clk)begin
        //Control signals
        multu_enE <= multu_enD;
        jr_selE <= jr_selD;
        shiftE <= shiftD;
        super_selE <= super_selD;
        alu_ctrlE <= alu_ctrlD;
        alu_srcE <= alu_srcD;
        branchE <= branchD;
        dm2regE <= dm2regD;
        jumpE <= jumpD;
        reg_dstE <= reg_dstD;
        we_dmE <= we_dmD;
        we_regE <= we_regD;
        
        //DP signals
        pc_plus_4E <= pc_plus_4D;
        alu_paE <= alu_paD;
        wd_dmE <= wd_dmD;
        rd3 <= rd3D;
        instrE <= instrD;
        sext_immE <= sext_immD;
        HI_qE <= HI_qD;
        LO_qE <= LO_qD;
    end
endmodule
