`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:06:28 08/27/2014 
// Design Name: 
// Module Name:    contador_n 
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
module contador_n
	#(parameter N=8)
	(
    input clk,
    input reset,
	 input soft_reset,
    output max_tick,
    output [N-1:0] q
 );

//signal declaration
reg [N-1:0] r_reg;
wire [N-1:0] r_next;

// register
always @(posedge clk, posedge reset)
	if (reset)
		r_reg <= 0; // {N{1b'0}}
	else if (soft_reset)
		r_reg <= 0;
	else
		r_reg <= r_next;

// next - state logic
//assign r_next = r_reg + 1;
wire [N:0] sum_carry = r_reg + 1'b1;
assign r_next = sum_carry[N-1:0];
//assign r_next = sum_carry[N:1];

// output logic
assign q = r_reg;
assign max_tick = (r_reg >= 2**4) ? 1'b1 : 1'b0;


endmodule
