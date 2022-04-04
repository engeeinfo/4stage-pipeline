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
	pipelining uut (
		.rs1(rs1), 
		.rs2(rs2), 
		.rd(rd), 
		.z(z), 
		.addr(addr), 
		.func(func), 
		.clk1(clk1), 
		.clk2(clk2)
	);

initial begin
// Initialize Inputs
	clk1=0;
	clk2=0;
	repeat(20)
		begin
		#5 clk1=1;
		#5 clk1=0;
		#5 clk2=1;
		#5 clk2=0;
		end
	end
	
	//initialize registers
	initial begin
	for(k=0;k<16;k=k+1)
	uut.regbank[k] = k;
   end
	
initial begin
#5 
rs1=5;
rs2=3;
rd=1;
func=0;
addr=125;
#20
rs1=6;
rs2=4;
rd=2;
func=1;
addr=126;
#20
rs1=7;
rs2=5;
rd=3;
func=0;
addr=127;
#20
rs1=8;
rs2=6;
rd=4;
func=1;
addr=128;
#20
rs1=9;
rs2=7;
rd=5;
func=0;
addr=129;
end
      
endmodule
