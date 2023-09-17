`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2023 02:13:32 PM
// Design Name: 
// Module Name: Immediate Generator
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


module Immediate_Generator(
    input [24:0]in,
    output [31:0]J_type,
    output [31:0]B_type,
    output [31:0]S_type,
    output [31:0]I_type,
    output [31:0]U_type
    );
    
    assign I_type = {{21{in[24]}},in[23:18],in[17:13]};
    assign J_type = {{12{in[24]}},in[12:5],in[13],in[23:14],1'b0};
    assign B_type = {{20{in[24]}},in[0],in[23:18],in[4:1],1'b0};
    assign U_type = {in[24:5],{12{1'b0}}};
    assign S_type = {{21{in[24]}},in[23:18],in[4:0]};
endmodule
