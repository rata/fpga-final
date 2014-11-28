`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:13 10/22/2014 
// Design Name: 
// Module Name:    main 
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
module main(
	input clk,
	input sw,
	input wire rx,
   output wire tx,
	output wire [3:0] an,
	output wire [7:0] sseg
);

procseq proc(.clk(clk), .reset(sw), .rx(rx), .tx(tx), .an(an), .sseg(sseg));

endmodule
