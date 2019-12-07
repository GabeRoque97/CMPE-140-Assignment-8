module MEM_stage(
        input wire clk,
        input wire multu_enM,
        input wire jr_selM,
        input wire dm2regM,
        input wire jumpM,
        input wire jal_selM,
        input wire we_regM,
        input wire [31:0] pc_plus_4M,
        input wire [31:0] alu_paM,
        input wire [63:0] alu_outM,
        input wire [31:0] rd_dmM,
        input wire [31:0] jtaM,
        input wire [4:0] rf_waM,
        
        input wire [31:0] super_y, 
        
        
        
        output reg multu_enW,
        output reg jr_selW,
        output reg dm2regW,
        output reg jumpW,
        output reg jal_selW,
        output reg we_regW,
        output reg [31:0] pc_plus_4W,
        output reg [31:0] alu_paW,
        output reg [63:0] alu_outW,
        output reg [31:0] rd_dmW,
        output reg [31:0] jtaW,
        output reg [4:0] rf_waW,
        
        output reg [31:0] super_yW
        
        
    );
    
    always@(posedge clk)
    begin
     //Control signals
           multu_enW <= multu_enM;
           jr_selW <= jr_selM;
           dm2regW <= dm2regM;
           jumpW <= jumpM;
           jal_selW <= jal_selM;
           we_regW <= we_regM;
           
      //DP signals
           pc_plus_4W <= pc_plus_4M;
           alu_paW <= alu_paM;
           alu_outW <= alu_outM;
           rd_dmW <= rd_dmM;
           
           jtaW <= jtaM;
           rf_waW <= rf_waM;
             
           super_yW <= super_y;   
           
                 
           
    end
    
endmodule
