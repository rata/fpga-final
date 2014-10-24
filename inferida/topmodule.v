`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:49 10/22/2014 
// Design Name: 
// Module Name:    topmodule 
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
module topmodule(
	input wire clk,
//	input wire ram_enable,
//	input wire write_enable,
//	input wire [2:0] addr,
//	input wire [7:0] DI,
//	output reg [7:0] DO,
   output [3:0] an,
   output [7:0] sseg
	
); 


parameter RAM_WIDTH = 8;
parameter RAM_ADDR_BITS = 3;

reg [RAM_WIDTH-1:0] image [(2**RAM_ADDR_BITS)-1:0];
reg [RAM_WIDTH-1:0] DO;
wire [RAM_ADDR_BITS-1:0] addr;
//wire [RAM_WIDTH-1:0] DI;
// The forllowing code is only necessary if you wish to initialize the RAM
// contents via an external file (use $readmemb for binary data)

wire ram_enable;
wire write_enable;
assign ram_enable = 1;
assign write_enable = 0;

//initial
//$readmemh("/home/itirabasso/fifo/imagentest.bin", image, 0, 7);

assign addr = 3'b0;

always @(posedge clk)
	image[0] <= 8'h1;


//	if (ram_enable)
//		if (write_enable)
//			image[addr] <= DI;*/
//		else

/*/
assign DO = image[0];

wire [7:0] in_sseg_1;
wire [7:0] in_sseg_2;
wire [7:0] in_sseg_3;
wire [7:0] in_sseg_4;
wire [3:0] tmp;
wire [3:0] tmp2;


assign tmp = DO;
assign tmp2 = DO >> 4;

hex_to_sseg h2s_1 (.hex(tmp), .dp(1'b1), .sseg(in_sseg_1));
hex_to_sseg h2s_2 (.hex(tmp2), .dp(1'b0), .sseg(in_sseg_2));
//hex_to_sseg h2s_3 (.hex(tmp3), .dp(1'b0), .sseg(in_sseg_3));
//hex_to_sseg h2s_4 (.hex(tmp4), .dp(1'b0), .sseg(in_sseg_4));
disp_mux disp_m (.clk(clk), .reset(1'b0), .in0(in_sseg_2), .in1(in_sseg_1), .in2(8'hff), .in3(8'hff), .an(an), .sseg(sseg));

	
*/

endmodule
