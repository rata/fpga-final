`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:57 10/17/2014 
// Design Name: 
// Module Name:    meminferida 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module meminferida
	#(parameter RAM_WIDTH=8,
		RAM_ADDR_BITS=16)
	(
	input wire clk,
	input wire write_enable,
	input wire [RAM_ADDR_BITS-1:0] addr,
	input wire [RAM_WIDTH-1:0] DI,
	output wire [RAM_WIDTH-1:0] DO	
); 

reg [RAM_WIDTH-1:0] image [(2**RAM_ADDR_BITS)-1:0];


initial
$readmemh("ratacapo.txt", image, 0, 7);

always @(posedge clk)
	if (write_enable)
		image[addr] <= DI;


assign DO = image[addr];

endmodule
