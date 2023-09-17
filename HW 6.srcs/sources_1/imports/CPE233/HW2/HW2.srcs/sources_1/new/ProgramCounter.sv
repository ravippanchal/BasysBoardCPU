`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 01:05:42 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
    input CLK,
    input [31:0]PC_IN,
    input PCWRITE,
    input RST,
    output logic [31:0]PC_OUT

    );
    
    always_ff@(posedge CLK)
    begin
    if(RST)
        PC_OUT<=32'h0;
    else if(PCWRITE)
        PC_OUT<=PC_IN;
    end
endmodule
