`timescale 1ns / 1ps

module vga_controller(
		input clock_25mhz,
		input reset,
		input [7:0] vram_data_out,
		output [2:0] red,
		output [2:0] green,
		output [1:0] blue,
		output reg h_sync,
		output reg v_sync,
		output reg inside_video,
		output [9:0] x_position,
		output [8:0] y_position,
		output [14:0] vram_addr
		);

	// SYNC, BPORCH, VIDEO, FPORCH.
	localparam H_SYNC = 96;
	localparam H_BPORCH = 144;
	localparam H_FPORCH = 784;
	localparam H_TOTAL = 800;
	localparam V_SYNC = 2;
	localparam V_BPORCH = 35;
	localparam V_FPORCH = 488;
	localparam V_TOTAL = 525;

	reg [9:0] h_counter = 0;
	reg [9:0] v_counter = 0;
	reg v_enable = 0;

	assign red = (inside_video)?vram_data_out[7:5]:3'b000;
	assign green = (inside_video)?vram_data_out[4:2]:3'b000;
	assign blue = (inside_video)?vram_data_out[1:0]:2'b00;

	assign vram_addr = (y_position / 4 ) * (160) + (x_position / 4);


	always @(posedge clock_25mhz or posedge reset) begin
		if (reset) begin
			h_counter <= 0;
		end else if (h_counter == H_TOTAL - 1) begin
			h_counter <= 0;
			v_enable <= 1;
		end else begin
			h_counter <= h_counter + 1'b1;
			v_enable <= 0;
		end
	end

	always @(*) begin
		if (h_counter < H_SYNC) begin
			h_sync = 0;
		end else begin
			h_sync = 1;
		end
	end

	always @(posedge clock_25mhz or posedge reset) begin
		if (reset) begin
			v_counter <= 0;
		end else if (v_enable) begin
			if (v_counter == V_TOTAL - 1) begin
				v_counter <= 0;
			end else begin
				v_counter <= v_counter + 1'b1;
			end
		end
	end

	always @(*) begin
		if (v_counter < V_SYNC) begin
			v_sync = 0;
		end else begin
			v_sync = 1;
		end
	end

	always @(*) begin
		if ((h_counter >= H_BPORCH) && (h_counter < H_FPORCH) && (v_counter >= V_BPORCH) && (v_counter < V_FPORCH)) begin
			inside_video = 1;
		end else begin
			inside_video = 0;
		end
	end

	assign x_position = (h_counter >= H_BPORCH)? h_counter - H_BPORCH : 0;
	assign y_position = (v_counter >= V_BPORCH)? v_counter - V_BPORCH : 0;

endmodule
