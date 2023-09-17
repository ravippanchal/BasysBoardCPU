`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 02:45:56 PM
// Design Name: 
// Module Name: CU_FSM
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


module CU_FSM(
    input clk,
    input RST,
    input [6:0]opCode7b,
    input [2:0]opCode3b,
    output logic regWrite,
    output logic memWE2,
    output logic memRDEN1,
    output logic memRDEN2,
    output logic reset,
    output logic PCWrite
    );
    
    typedef enum{ST_INIT,ST_FETCH,ST_EXEC,writeBack}STATES;
    STATES NS,PS;
    
     always_ff@(posedge clk)
        begin
        if(RST==1'b1)
            PS<=ST_INIT;
        else
            PS<=NS;
        end
    always_comb
    begin
    regWrite = 1'b0;
    memWE2 = 1'b0;
    memRDEN1 = 1'b0;
    memRDEN2 = 1'b0;
    reset = 1'b0;
    PCWrite = 1'b0;
    case(PS)
    ST_INIT: 
        begin
        reset = 1'b1;
        NS = ST_FETCH;
        end
        
    ST_FETCH:
        begin
        reset = 1'b0;
        memRDEN1 = 1'b1;
        memRDEN2 = 1'b0;
        memWE2 = 1'b0;
        PCWrite = 1'b0;
        regWrite = 1'b0;
        NS = ST_EXEC;
        end

    ST_EXEC:
        
        begin
        case(opCode7b)
            7'b0110111: begin //U-type
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
                end
           7'b0010011: begin //I-TYPE
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
                end
           7'b0110011: begin //R-TYPE
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
                end
                
          7'b1100011: begin //B-TYPE
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b0;
                NS = ST_FETCH;
                end
                
          7'b1100111: begin //jalr
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
                end
                
          7'b0010111: begin //auipc
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
                end
                
          7'b1101111: begin //jal
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
                end
                
          7'b0100011: begin //store
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b0;
                memWE2 = 1'b1;
                NS = ST_FETCH;
                end
                
          7'b0000011: begin //load
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b0;
                regWrite = 1'b0;
                memRDEN2 = 1'b1;
                NS=writeBack;
                end
                
         default: begin
                reset = 1'b0;
                memRDEN1 = 1'b0;
                PCWrite = 1'b1;
                regWrite = 1'b0;
                NS = ST_FETCH;
                end
                
        
        endcase
        
        end 
        
    writeBack: begin
        memRDEN2 = 1'b0;
        PCWrite = 1'b1;
        regWrite = 1'b1;
        NS=ST_FETCH;
    end       
    
    default:
    NS=ST_INIT;
    
    endcase
    end
    
    
    
endmodule
