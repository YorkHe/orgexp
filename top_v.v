`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:37:33 07/01/2016
// Design Name:   orgexp
// Module Name:   H:/System_Group/org_fin/top_v.v
// Project Name:  org_fin
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: orgexp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_v;

	// Inputs
	reg clk_100mhz;
	reg [3:0] BTN;
	reg [7:0] SW;

	// Outputs
	wire [3:0] AN;
	wire [7:0] SEGMENT;
	wire [7:0] LED;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire h_sync;
	wire v_sync;

	// Instantiate the Unit Under Test (UUT)
	orgexp uut (
		.clk_100mhz(clk_100mhz), 
		.BTN(BTN), 
		.SW(SW), 
		.AN(AN), 
		.SEGMENT(SEGMENT), 
		.LED(LED), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.h_sync(h_sync), 
		.v_sync(v_sync)
	);

	initial begin
		// Initialize Inputs
		clk_100mhz = 0;
		BTN = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        forever #100 clk_100mhz = ~clk_100mhz;

	end
      
endmodule

