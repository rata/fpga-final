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

reg [2:0] state_reg;
reg [2:0] state_next;
reg [ADDR_BITS-1:0] addr_reg;
wire [ADDR_BITS-1:0] addr_next;

reg [2:0] wait_reg;
reg [2:0] wait_next;


assign DI = 24'h00;

// Source tiene que ser de 15 bits y dst de 13
meminferida #(.RAM_ADDR_BITS(ADDR_BITS), .RAM_WIDTH(24)) src(.clk(clk), .write_enable(1'b0), .addr(addr_reg), .DI(DI), .DO(DO));


wire tx_full, rx_empty;
wire [7:0] data_dst, dummy;
reg uart_wr_reg;
reg uart_wr_next;

assign dummy = 8'h00;

//wire [7:0] test_do;
//assign test_do = DO[23:16];

// body
// instantiate uart
uart uart_unit
   (.clk(clk), .reset(reset), .rd_uart(1'b0),
    //.wr_uart(uart_wr_reg), .rx(rx), .w_data(data_dst),
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
		state_reg <= 2'b00;
		//uart_wr_reg <= 1'b0;
		wait_reg <= 3'b00;
	end 
	else begin
		addr_reg <= addr_next;
		state_reg <= state_next;
		//uart_wr_reg <= uart_wr_next;
		wait_reg <= wait_next;
	end
end

assign addr_next = (addr_reg < 13'd6866) ? addr_reg + 1'b1 : 0;

//assign uart_wr_next = (addr_reg == 4) ? 1:0;

//assign uart_wr_test = (uart_wr_test) ? 1'b1 : ((addr_reg >= 4 )? 1 : 0);
//assign addr_next = addr_reg + 1;
/*
always @(posedge clk) begin
		case (wait_reg)
			3'h0: // read
				begin
					uart_wr_reg = 1'b0;
					if (addr_reg == 0) begin
						wait_next = 3'h1;
					end
					else begin
						wait_next = 3'h0;
					end
					
				end
			3'h1: // apply 
				begin
					uart_wr_reg = 1'b0;
					if (addr_reg == 0) begin
						wait_next = 3'h2;
					end
					else begin
						wait_next = 3'h1;
					end					
					
					//wait_next = 3'h2;
				end
			3'h2: // apply 
				begin
					uart_wr_reg = 1'b1;
					
					//wait_next = 3'h3;
					wait_next = 3'h2;
				end
			3'h3: // apply 
				begin
					wait_next = 3'h4;
				end
			3'h4: // apply 
				begin
					wait_next = 3'h5;
				end
			3'h5: // apply 
				begin
					wait_next = 3'h6;
				end
			3'h6: // write
				begin
					wait_next = 3'h7;
				end
			3'h7: // next
				begin
					state_next = 3'h7;
					uart_wr_next = 1'b1;
				end
		endcase
end
*/


endmodule
