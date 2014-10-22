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
module meminferida(
	input wire clk,
	input wire write_enable,
	input wire [RAM_ADDR_BITS-1:0] addr,
	input wire [RAM_WIDTH-1:0] DI,
	output wire [RAM_WIDTH-1:0] DO	
); 


parameter RAM_WIDTH = 8;
parameter RAM_ADDR_BITS = 10;

reg [RAM_WIDTH-1:0] image [(2**RAM_ADDR_BITS)-1:0];

/*
initial
$readmemh("/home/itirabasso/fifo/imagentest.bin", image, 0, 24);
*/

always @(posedge clk)
	if (write_enable)
		image[addr] <= DI;


assign DO = image[addr];

endmodule
