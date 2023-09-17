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


module ALU(
    input [31:0]src_A,
    input [31:0]src_B,
    input [3:0]alu_fun,
    output logic[31:0]ALU_Out
    );
    
    
    always_comb
    begin
        case(alu_fun)
        4'd0: ALU_Out = $signed(src_A) + $signed(src_B);
        4'd1: ALU_Out = src_A << src_B[4:0];
        4'd2: ALU_Out = $signed(src_A) < $signed(src_B);
        4'd3: ALU_Out = src_A < src_B;
        4'd4: ALU_Out = src_A ^ src_B;
        4'd5: ALU_Out = src_A >> src_B[4:0];
        4'd6: ALU_Out = src_A | src_B;
        4'd7: ALU_Out = src_A & src_B;  
        4'd8: ALU_Out = $signed(src_A) - $signed(src_B); 
        4'd9: ALU_Out = src_A; 
        4'd13: ALU_Out = $signed(src_A) >>> src_B[4:0];
        4'd10: ALU_Out = 32'd0;
        4'd11: ALU_Out = 32'd0;
        4'd12: ALU_Out = 32'd0;
        4'd14: ALU_Out = 32'd0;
        4'd15: ALU_Out = 32'd0;
          
        
        default: ALU_Out = 32'd0;
        endcase 
    end
endmodule
