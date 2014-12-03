`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:23:26 10/29/2014 
// Design Name: 
// Module Name:    procseq 
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
module procseq
   #( parameter ADDR_BITS = 13)
(
	input clk,
	input reset,
	input wire rx,
	output wire tx
);

wire [12:0] addr;
wire [23:0] DI;
wire [23:0] DO;


wire [7:0] ret;

reg [ADDR_BITS-1:0] addr_reg;
wire [ADDR_BITS-1:0] addr_next;

assign DI = 24'h00;

// Source tiene que ser de 15 bits y dst de 13
meminferida #(.RAM_ADDR_BITS(ADDR_BITS), .RAM_WIDTH(24)) src(.clk(clk), .write_enable(1'b0), .addr(addr_reg), .DI(DI), .DO(DO));

wire tx_full, rx_empty;
wire [7:0] data_dst, dummy;

assign dummy = 8'h00;


// instantiate uart
uart uart_unit
   (.clk(clk), .reset(reset), .rd_uart(1'b0),
	 .wr_uart(1'b1), .rx(rx), .w_data(data_dst),
    .tx_full(tx_full), .rx_empty(rx_empty),
    .r_data(dummy), .tx(tx));

// XXX: El que recibe, recibe 1 byte pero para escribir la imagen correctamente
// se tiene que escribir ese byte 3 veces (1 para R, otro para G y otro para B)
// Y de esta manera queda en escala de grises (pues es el mismo valor para cada uno.
bwfilter bw(.pixel(DO), .ret(data_dst));


always @(posedge clk, posedge reset) begin
	if (reset) begin
		addr_reg <= 10'h0;
	end 
	else begin
		addr_reg <= addr_next;
	end
end

assign addr_next = (addr_reg < 13'd6766) ? addr_reg + 1'b1 : 0;

endmodule
