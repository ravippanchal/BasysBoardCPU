`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 03:17:35 PM
// Design Name: 
// Module Name: BAC
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


module BAC(
    input [31:0]pc_in,
    input [31:0]i_in,
    input [31:0]rs1_in,
    input [31:0]j_in,
    input [31:0]b_in,
    output logic [31:0]jal,
    output logic[31:0]branch,
    output logic [31:0]jalr
    );
    
    
    assign jal = pc_in + $signed(j_in);
    assign branch = pc_in + $signed(b_in);
    assign jalr = $signed(i_in) + $signed(rs1_in);
    
endmodule
