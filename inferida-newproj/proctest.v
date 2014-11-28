`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:52:37 10/31/2014
// Design Name:   procseq
// Module Name:   /home/itirabasso/filtro/inferida/proctest.v
// Project Name:  filtro
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: procseq
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module proctest;
	localparam T=20; // clock period

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [3:0] an;
	wire [7:0] sseg;

	// Instantiate the Unit Under Test (UUT)
	procseq uut (
		.clk(clk), 
		.reset(reset), 
		.an(an), 
		.sseg(sseg)
	);

	always begin
		#(T/2)  clk = ~clk; // alterna el clock cada T/2 bases de tiempo
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
	end
      
endmodule

