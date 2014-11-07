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
module procseq(
	input clk,
	input reset,
   output [3:0] an,
   output [7:0] sseg
);


wire write_enable_dst;
wire [4:0] addr;
wire [23:0] DI;
wire [23:0] DO;

wire [23:0] DI_dst;
wire [23:0] DO_dst;
wire [7:0] ret;


reg [1:0] state_reg;
reg [1:0] state_next;
reg [9:0] addr_reg = 10'b0;
reg [9:0] addr_next = 10'b0;


assign DI = 24'h00;

meminferida #(.RAM_ADDR_BITS(30), .RAM_WIDTH(24)) src(.clk(clk), .write_enable(1'b0), .addr(addr_reg), .DI(DI), .DO(DO));
meminferida #(.RAM_ADDR_BITS(30), .RAM_WIDTH(24)) dst(.clk(clk), .write_enable(1'b1), .addr(addr_reg), .DI(DI_dst), .DO(DO_dst));

bwfilter bw(.pixel(DO), .ret(ret));
assign DI_dst = {ret, ret, ret};


always @(posedge clk, posedge reset) begin
	if (reset) begin
		addr_reg <= 10'h0;
		state_reg <= 2'b00;
	end 
	else begin
		addr_reg <= addr_next;
		state_reg <= state_next;
	end
end

always @* begin
	addr_next = addr_reg;
	state_next = state_reg;
   if (addr_next < 3) begin
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
				end
			2'b11: // next
				begin
					state_next = 2'b00;
					addr_next = addr_reg + 1'b1;
				end
		endcase
	end
	else begin
		state_next = 2'b00;
		addr_next = 10'b0;
	end
end


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


endmodule
