`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:55:10 09/03/2014 
// Design Name: 
// Module Name:    contador_digito 
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
module contador_digito
	#(parameter N=20)
	(
    input clk,
    input reset,
	 input soft_reset,
    input prev_tick,
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
assign r_next = (prev_tick)? (r_reg + 1'b1) : r_reg;
//assign r_next = (prev_tick==1'b1)? 1'b0 : 1'b0;

// output logic
assign q = r_reg;
assign max_tick = (r_reg >= 2**10) ? 1'b1 : 1'b0;
endmodule
