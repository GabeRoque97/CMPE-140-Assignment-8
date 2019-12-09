`timescale 1ns / 1ps

module SoC_SingleC_tb;
    reg clk, rst;
    reg [3:0] switches;
    reg       Sel;
   // reg [31:0] ra3;
    wire [31:0] gpOut1, gpOut2;
   // wire [31:0] rd3;
    wire dispSe, factErr;
    wire [31:0]   gpIn1;
    
    assign gpIn1 = {27'b0,Sel,switches[3:0]};
    
    assign dispSe = gpOut1[4];
    assign factErr = gpOut1[0];
    
    system DUT( 
        .clk (clk),
        .rst (rst),
        .gpI1 (gpIn1),
        .gpO1 (gpOut1),
        .gpO2 (gpOut2),
        .gpI2 (gpOut1)
       // .ra3    (ra3),
       // .rd3    (rd3)
    );
    
   //if(DUT.fact_top.FA.done == 1)
   
    
    integer i,j,k,done_check,error_check, jump_check,write_check;
    
    initial begin
        done_check = 0;
        error_check = 0;
        jump_check = 0;
        write_check = 0;
        rst = 1;
        tick;
        rst = 0;
        /*
        while(write_check != 16)begin
             tick;
             rst = 0;
             write_check = DUT.mips.dp.MEM_stage.we_regW;
                            
        end
        
       
       tick;
     */
       
        for(j = 0; j < 2; j = j + 1)begin   
            Sel = j;    
            for(i = 0; i < 16; i = i + 1)begin
            
                switches = i;
                 //for(k = 0; k < 40; k = k + 1)begin 
                 //if(i > 12) error_check = 1;
                
                 
               /* while(done_check == 0 && error_check == 0)begin 
                    tick;//clock through Factorial calculation
                    done_check = DUT.fact_top.FA.done; 
                    error_check = DUT.fact_top.FA.Error; 
                end
                
                done_check = 0;
                error_check = 0;
               */
                while(jump_check == 0)begin
                    tick;
                    jump_check = DUT.mips.dp.MEM_stage.jumpW;
                    
                end
                jump_check = 0;
              
              
            end
           
          
        end
    //while(factErr == 0) tick;
    
    end
    
    task tick; 
    begin  
            clk <= 0; #10;
            clk <= 1; #10; 
            end
    endtask
endmodule
