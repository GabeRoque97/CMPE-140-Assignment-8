module system(
        input wire  clk,
        input wire rst,
        input wire  [4:0]ra3,
        input wire  [31:0]gpI1,
        input wire  [31:0]gpI2,
        output wire [31:0]rd3,
        output wire [31:0]gpO1,
        output wire [31:0]gpO2
    );

wire WE, WE1, WE2, WEM;
wire [1:0]RdSel;
wire [31:0]pc_current;
wire [31:0]Instruction;
wire [31:0]RD;
wire [31:0]A;
wire [31:0]WD;
wire [31:0]DMemData;
wire [31:0]FactData;
wire [31:0]GPIOData;

imem imem(
        .a  (pc_current[7:2]),
        .y  (Instruction)
    );
/*
mips mips(
        .clk            (clk),
        .rst            (rst),
        .ra3            (ra3),
        .instr          (Instruction),
        .rd_dm          (RD),
        .we_dm          (WE),
        .pc_current     (pc_current),
        .alu_out        (A),
        .wd_dm          (WD),
        .rd3            (rd3)
    );
*/   
/*addr_dec addr_dec(
        .WE     (WE),
        .A      (A),
        .WE1    (WE1),
        .WE2    (WE2),
        .WEM    (WEM),
        .RdSel  (RdSel)
    );
*/
dmem dmem (
        .clk            (clk),
        .we             (WEM),
        .a              (A[7:2]),//this is because every address ends with 2'b00
        .d              (WD),
        .q              (DMemData)
    );

Factorial_Accelerator fact_top(
        .clk    (clk),
        .rst    (rst),
        .A      (A[3:2]),
        .WE     (WE1),
        .WD     (WD[3:0]),
        .RD     (FactData)
    );
    
/*gpio_top gpio_top(
        .clk    (clk),
        .rst    (rst),
        .A      (A[3:2]),
        .WE     (WE2),
        .WD     (WD),
        .gpI1   (gpI1),
        .gpI2   (gpI2),
        .RD     (GPIOData),
        .gpO1   (gpO1),
        .gpO2   (gpO2)
    );
*/    
mux4 #(32) mux4(
        .sel    (RdSel),
        .a      (DMemData),
        .b      (DMemData),
        .c      (FactData),
        .d      (GPIOData),
        .y      (RD)
    );
endmodule
