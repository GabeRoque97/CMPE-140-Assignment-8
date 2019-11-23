module imem (
        input  wire [5:0]  a,
        output wire [31:0] y
    );

    reg [31:0] rom [0:63];

    initial begin
        $readmemh ("C:/Users/gabri/Desktop/CMPE 140/basys3_single_cycle_mips_validation/memfile.dat", rom);
    end

    assign y = rom[a];
    
endmodule