`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:48 11/19/2014 
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
    input RsRx,
    output RsTx,
    output [3:0] an,
    output [7:0] sseg
    );

wire [7:0] w_data;
wire [7:0] r_data;
wire tx_full, rx_empty;

uart uart_1 (.clk(clk), .reset(1'b0), .rd_uart(1'b0), .rx(RsRx), .w_data(w_data), .tx(RsTx), .wr_uart(1'b1), .r_data(r_data));

assign w_data = 8'hcd;


wire [7:0] in_sseg_1;
wire [7:0] in_sseg_2;
wire [3:0] tmp;
wire [3:0] tmp2;

assign tmp =  r_data << 4 >> 4;
assign tmp2 = r_data << 4;

hex_to_sseg h2s_1 (.hex(tmp), .dp(1'b0), .sseg(in_sseg_1));
hex_to_sseg h2s_2 (.hex(tmp2), .dp(1'b0), .sseg(in_sseg_2));

disp_mux disp_m (.clk(clk), .reset(1'b0), .in0(in_sseg_1), .in1(in_sseg_2), .in2(8'hFF), .in3(8'hFF), .an(an), .sseg(sseg));


endmodule
