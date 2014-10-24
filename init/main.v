`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:39 10/22/2014 
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
   output [3:0] an,
   output [7:0] sseg
);

wire [7:0] DO;
wire [7:0] DI;

assign DI = 8'h1;

bram bram1 (
	.DO(DO), 
	.DI(DI), 
	.RDADDR(11'b0), 
	.RDCLK(clk), 
	.REGCE(1'b1), 
	.RST(1'b0), 
	.WE(1'b0), 
	.RDEN(1'b1), 
	.WRADDR(11'b0), 
	.WRCLK(1'b0), 
	.WREN(1'b0)
);
	


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
disp_mux disp_m (.clk(clk), .reset(1'b0), .in0(in_sseg_1), .in1(in_sseg_2), .in2(8'hff), .in3(8'hff), .an(an), .sseg(sseg));


endmodule
