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
   output [3:0] an,
   output [7:0] sseg
);


wire write_enable;
wire [9:0] addr;
wire [7:0] DI;
wire [7:0] DO;

assign write_enable = 1'b1;
assign addr = 9'b0;
assign DI = 8'h3;

meminferida mem(.clk(clk), .write_enable(write_enable), .addr(addr), .DI(DI), .DO(DO));

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

endmodule
