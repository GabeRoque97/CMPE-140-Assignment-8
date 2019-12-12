module mips_fpga (
        input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire [3:0] switches,  //n for factorial
        input wire        Sel,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT,
        output wire       dispSel,
        output wire       factErr0,
        output wire       factErr1,
        output wire       factErr2,
        output wire       factErr3
    );

    wire [15:0] reg_hex;
    wire        clk_sec;
    wire        clk_5KHz;
    wire        clk_pb;

    wire [7:0]  digit0;
    wire [7:0]  digit1;
    wire [7:0]  digit2;
    wire [7:0]  digit3;

    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] dispData;
    
    wire [31:0] gpO1_wire;
    wire [31:0] gpO2_wire;
    wire [31:0] gpI1_wire;
    wire [31:0] system_out;

    clk_gen clk_gen (
            .clk100MHz          (clk),
            .rst                (rst),
            .clk_4sec           (clk_sec),
            .clk_5KHz           (clk_5KHz)
        );

    button_debouncer bd (
            .clk                (clk_5KHz),
            .button             (button),
            .debounced_button   (clk_pb)
        );

    //Pipelined System

    /*
    switches[4:0] are used as the 3rd read address (ra3) of the RF,
    dispData is the register contents from the RF's 3rd read port (rd3).
    
    */
    system system(
            //.ra3            (),
            .gpI1           ({27'b0,Sel,switches[3:0]}),
            .gpI2           (gpO1_wire),
            //.rd3            (),
            .gpO1           (gpO1_wire),
            .gpO2           (system_out),
            .rst            (rst),
            .clk            (clk_pb)
    
          );
    
    assign dispSel = gpO1_wire[4];
    assign factErr0 = gpO1_wire[0];
    assign factErr1 = gpO1_wire[0];
    assign factErr2 = gpO1_wire[0];
    assign factErr3 = gpO1_wire[0];
    
    mux2 #(16) displaymux (
            .sel                (gpO1_wire[4]),
            .a                  (system_out[15:0]),
            .b                  (system_out[31:16]),
            .y                  (reg_hex)
         );
    hex_to_7seg hex3 (
            .HEX                (reg_hex[15:12]),
            .s                  (digit3)
        );

    hex_to_7seg hex2 (
            .HEX                (reg_hex[11:8]),
            .s                  (digit2)
        );

    hex_to_7seg hex1 (
            .HEX                (reg_hex[7:4]),
            .s                  (digit1)
        );

    hex_to_7seg hex0 (
            .HEX                (reg_hex[3:0]),
            .s                  (digit0)
        );

    led_mux led_mux (
            .clk                (clk_5KHz),
            .rst                (rst),
            .LED3               (digit3),
            .LED2               (digit2),
            .LED1               (digit1),
            .LED0               (digit0),
            .LEDSEL             (LEDSEL),
            .LEDOUT             (LEDOUT)
        );
  
   
endmodule
