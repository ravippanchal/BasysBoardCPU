`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 04:39:36 PM
// Design Name: 
// Module Name: MUX
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


module MUX(
    input [31:0]In0,
    input [31:0]In1,
    input [31:0]In2,
    input [31:0]In3,
    input [31:0]In4,
    input [31:0]In5,
    input [2:0]MUX_Sel,
    output logic[31:0]MUX_Out
    );
    
    
    always_comb
    begin
        case(MUX_Sel)
        3'd0: MUX_Out = In0;
        3'd1: MUX_Out = In1;
        3'd2: MUX_Out = In2;
        3'd3: MUX_Out = In3;
        3'd4: MUX_Out = In4;
        3'd5: MUX_Out = In5;
        3'd6: MUX_Out = 32'd0;
        3'd7: MUX_Out = 32'd0;  
        default: MUX_Out = 32'd0;
        endcase 
    end
endmodule
