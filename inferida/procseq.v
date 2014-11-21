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
   #( parameter ADDR_BITS = 10)
(
	input clk,
	input reset,
	input wire rx,
	output wire tx
);




wire write_enable_dst;
wire [4:0] addr;
wire [23:0] DI;
wire [23:0] DO;

//wire [23:0] DI_dst;
wire [23:0] DO_dst;
wire [7:0] ret;


reg [2:0] state_reg;
reg [2:0] state_next;
reg [ADDR_BITS-1:0] addr_reg = 15'b0;
reg [ADDR_BITS-1:0] addr_next = 15'b0;


assign DI = 24'h00;

// Source tiene que ser de 15 bits y dst de 13
meminferida #(.RAM_ADDR_BITS(ADDR_BITS), .RAM_WIDTH(24)) src(.clk(clk), .write_enable(1'b0), .addr(addr_reg), .DI(DI), .DO(DO));

// signal declaration
wire tx_full, rx_empty;
wire [7:0] data_dst, dummy;
reg uart_wr_reg, uart_wr_next;

assign dummy = 8'h00;

// body
// instantiate uart
uart uart_unit
   (.clk(clk), .reset(reset), .rd_uart(1'b0),
    .wr_uart(uart_wr_reg), .rx(rx), .w_data(data_dst),
    .tx_full(tx_full), .rx_empty(rx_empty),
    .r_data(dummy), .tx(tx));

// XXX: El que recibe, recibe 1 byte pero para escribir la imagen correctamente
// se tiene que escribir ese byte 3 veces (1 para R, otro para G y otro para B)
// Y de esta manera queda en escala de grises (pues es el mismo valor para cada uno.
bwfilter bw(.pixel(DO), .ret(data_dst));
//assign DI_dst = {ret, ret, ret};


always @(posedge clk, posedge reset) begin
	if (reset) begin
		addr_reg <= 10'h0;
		state_reg <= 2'b00;
		uart_wr_reg <= 1'b0;
	end 
	else begin
		addr_reg <= addr_next;
		state_reg <= state_next;
		uart_wr_reg <= uart_wr_next;
	end
end

always @* begin
	addr_next = addr_reg;
	state_next = state_reg;
	uart_wr_next = uart_wr_reg;
   if (addr_reg < 3) begin
	/*
	   case (state_reg)
			2'b00: // read
				begin
					state_next = 2'b01;
				end
			2'b01: // apply 
				begin
					state_next = 2'b10;
				end
			2'b10: // write
				begin
					state_next = 2'b11;
					uart_wr_next = 1'b1;
				end
			2'b11: // next
				begin
					state_next = 2'b00;
					addr_next = addr_reg + 1'b1;
					uart_wr_next = 1'b0;
				end
		endcase
		*/
		case (state_reg)
			3'h0: // read
				begin
					state_next = 3'h1;
				end
			3'h1: // apply 
				begin
					state_next = 3'h2;
				end
			3'h2: // apply 
				begin
					state_next = 3'h3;
				end
			3'h3: // apply 
				begin
					state_next = 3'h4;
				end
			3'h4: // apply 
				begin
					state_next = 3'h5;
				end
			3'h5: // apply 
				begin
					state_next = 3'h6;
					uart_wr_next = 1'b1;
				end
			3'h6: // write
				begin
					state_next = 3'h7;
				end
			3'h7: // next
				begin
					state_next = 3'h0;
					addr_next = addr_reg + 1'b1;
					uart_wr_next = 1'b0;
				end
		endcase
	end
	else begin
		state_next = 3'h0;
		addr_next = 15'b0;
		uart_wr_next = 1'h0;
	end
end

/*
wire [7:0] in_sseg_1;
wire [7:0] in_sseg_2;
wire [7:0] in_sseg_3;
wire [7:0] in_sseg_4;
wire [3:0] tmp;
wire [3:0] tmp2;
wire [3:0] tmp3;
wire [3:0] tmp4;

wire [7:0] DO_dst_div3;
wire [7:0] DO_div3;

assign tmp =  DO_dst << 20 >> 20;
assign tmp2 = DO_dst >> 20;
assign tmp3 =  DI_dst << 20 >> 20;
assign tmp4 = DI_dst >> 20;

hex_to_sseg h2s_1 (.hex(tmp), .dp(1'b0), .sseg(in_sseg_1));
hex_to_sseg h2s_2 (.hex(tmp2), .dp(1'b0), .sseg(in_sseg_2));

hex_to_sseg h2s_3 (.hex(tmp3), .dp(1'b0), .sseg(in_sseg_3));
hex_to_sseg h2s_4 (.hex(tmp4), .dp(1'b0), .sseg(in_sseg_4));

disp_mux disp_m (.clk(clk), .reset(1'b0), .in0(in_sseg_1), .in1(in_sseg_2), .in2(in_sseg_3), .in3(in_sseg_4), .an(an), .sseg(sseg));
*/

endmodule
