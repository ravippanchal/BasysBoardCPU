`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2023 08:49:07 PM
// Design Name: 
// Module Name: Otter_TB
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


module Otter_TB();

    logic RST;
    logic [31:0]IOBUS_IN;
    logic CLK;
    logic IOBUS_WR;
    logic [31:0]IOBUS_OUT;
    logic [31:0]IOBUS_ADDR;
    
    Otter__TOP UUT (.RST(RST),.IOBUS_IN(IOBUS_IN),.CLK(CLK),.IOBUS_WR(IOBUS_WR),.IOBUS_OUT(IOBUS_OUT),.IOBUS_ADDR(IOBUS_ADDR));
    
    always
    begin
    #10 CLK = ~CLK;
    end
    
    always begin
    
    #60 RST = 1'b0;
        IOBUS_IN = 32'h2;
        end
        
    initial begin
        CLK = 1'b0;
        end
        
endmodule
