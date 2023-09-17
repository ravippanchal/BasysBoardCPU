`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 02:44:02 PM
// Design Name: 
// Module Name: BCG
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


module BCG(
    input [31:0]rs1,
    input [31:0]rs2,
    output logic br_eq,
    output logic br_lt,
    output logic br_ltu
    );
    
    always_comb
    begin
        if($signed(rs1)<$signed(rs2))
            br_lt = 1'b1;
        else
            br_lt = 1'b0;
            
        if($signed(rs1)==$signed(rs2))
            br_eq = 1'b1;
        else
            br_eq = 1'b0;
            
        if(rs1<rs2)
            br_ltu = 1'b1;
        else
            br_ltu = 1'b0;
    end
endmodule
