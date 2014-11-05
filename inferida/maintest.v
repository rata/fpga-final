`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:52:18 10/31/2014
// Design Name:   main
// Module Name:   /home/itirabasso/filtro/inferida/maintest.v
// Project Name:  filtro
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module maintest;

	// Inputs
	reg clk;
	reg sw;

	// Outputs
	wire [3:0] an;
	wire [7:0] sseg;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.sw(sw), 
		.an(an), 
		.sseg(sseg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		sw = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

