`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 01:05:42 PM
// Design Name: 
// Module Name: PC_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_TOP(
    input pcwrite,
    input rst,
    input CLK,
    input [31:0]jalr,
    input [31:0]branch,
    input [31:0]jal,
    input [2:0]pcSource,
    output [31:0] PC_OUT

    );
    logic [31:0]muxOut_pcIn;
    logic [31:0]plusFour;
    
    MUX mux (.In0(plusFour),.In1(jalr),.In2(branch),.In3(jal),.In4(mtvec),.In5(mepe),.MUX_Sel(pcSource),.MUX_Out(muxOut_pcIn));
    ProgramCounter pc (.CLK(CLK),.PC_IN(muxOut_pcIn),.PCWRITE(pcwrite),.RST(rst),.PC_OUT(PC_OUT));
    assign plusFour = PC_OUT + 4;
    
endmodule
