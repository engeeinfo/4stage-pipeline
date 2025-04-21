module pipe_tb;

    // Inputs
    reg [3:0] rs1;
    reg [3:0] rs2;
    reg [3:0] rd;
    reg [7:0] addr;
    reg [1:0] func;
    reg clk1;
    reg clk2;

    // Outputs
    wire [15:0] z;
    integer k;

    // Instantiate the Unit Under Test (UUT)
    pipe uut (
        .rs1(rs1), 
        .rs2(rs2), 
        .rd(rd), 
        .z(z), 
        .addr(addr), 
        .func(func), 
        .clk1(clk1), 
        .clk2(clk2)
    );

    // Clock Generation
    initial begin
        clk1 = 0;
        clk2 = 0;
        repeat(20) begin
            #5 clk1 = 1;
            #5 clk1 = 0;
            #5 clk2 = 1;
            #5 clk2 = 0;
        end
    end

    // Initialize register bank values
    initial begin
        for(k = 0; k < 16; k = k + 1) begin
            uut.regbank[k] = k;  // Initialize each register to its index value
        end
    end

    // Stimulus Generation (Test cases)
    initial begin
        #5 
        rs1 = 5; rs2 = 3; rd = 1; func = 2'b00; addr = 125;  // Add 5 + 3 -> 8
        #20
        rs1 = 6; rs2 = 4; rd = 2; func = 2'b01; addr = 126;  // Sub 6 - 4 -> 2
        #20
        rs1 = 7; rs2 = 5; rd = 3; func = 2'b00; addr = 127;  // Add 7 + 5 -> 12
        #20
        rs1 = 8; rs2 = 6; rd = 4; func = 2'b01; addr = 128;  // Sub 8 - 6 -> 2
        #20
        rs1 = 9; rs2 = 7; rd = 5; func = 2'b00; addr = 129;  // Add 9 + 7 -> 16
    end

    // Monitor the outputs
    initial begin
        $monitor("Time=%0t, rs1=%d, rs2=%d, rd=%d, func=%b, addr=%d, z=%d", 
                 $time, rs1, rs2, rd, func, addr, z);
    end

endmodule
