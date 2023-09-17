`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 01:13:39 PM
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(
    input [31:0]Wd,
    input en,
    input [4:0]adr1,
    input [4:0]adr2,
    input [4:0]wa,
    output logic [31:0]rs1,
    output logic [31:0]rs2,
    input clk
    );
    
    logic[31:0]ram[0:31];
    initial begin
    int i = 0;
    for(i=0;i<32;i++)begin
        ram[i] = 0;
    end
    end
    assign rs1 = ram[adr1];
    assign rs2 = ram[adr2];
    always_ff@(posedge clk)
    begin
    if(en&(wa!=0))
    begin
        ram[wa]<=Wd;
    end
    else
    begin
    end
    end
        
    
    
endmodule
