module pipe(
    input clk1, clk2,
    input [3:0] rs1, rs2, rd,  // Register source and destination addresses
    input [1:0] func,           // Function for the operation
    input [7:0] addr,           // Memory address
    output [15:0] z             // Output result
);

    // Internal registers to hold data between pipeline stages
    reg [15:0] L12_A, L12_B, L23_z, L34_z;
    reg [3:0] L12_rd, L12_func, L23_rd;
    reg [7:0] L12_addr, L23_addr, L34_addr;

    // Register and memory initialization
    reg [15:0] regbank [0:15];  // 16 general-purpose registers
    reg [15:0] mem [0:255];     // Memory (256 locations)

    // Output the final result
    assign z = L34_z;

    // Stage 1 (Clock 1: Fetch operands from register bank)
    always @(posedge clk1) begin
        L12_A <= regbank[rs1];  // Load operand A from regbank
        L12_B <= regbank[rs2];  // Load operand B from regbank
        L12_rd <= rd;           // Set destination register
        L12_func <= func;       // Set function for operation
        L12_addr <= addr;       // Set memory address
    end

    // Stage 2 (Clock 2: Perform operation)
    always @(negedge clk2) begin
        case(func)
            2'b00: L23_z <= L12_A + L12_B;  // Addition
            2'b01: L23_z <= L12_A - L12_B;  // Subtraction
            2'b10: L23_z <= L12_A & L12_B;  // Bitwise AND
            2'b11: L23_z <= L12_A ^ L12_B;  // Bitwise XOR
            default: L23_z <= 16'hxxxx;     // Invalid operation
        endcase
        L23_rd <= L12_rd;  // Pass destination register address
        L23_addr <= L12_addr;  // Pass memory address
    end

    // Stage 3 (Clock 1: Write result to regbank)
    always @(posedge clk1) begin
        regbank[L23_rd] <= L23_z;  // Write result back to regbank
        L34_z <= L23_z;  // Pass result to next stage
        L34_addr <= L23_addr;  // Pass address to next stage
    end

    // Stage 4 (Clock 2: Write result to memory)
    always @(negedge clk2) begin
        mem[L34_addr] <= L34_z;  // Write result to memory
    end 

endmodule
