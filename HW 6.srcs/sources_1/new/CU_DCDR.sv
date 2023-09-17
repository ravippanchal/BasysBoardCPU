`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 02:45:56 PM
// Design Name: 
// Module Name: CU_DCDR
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


module CU_DCDR(
    input [6:0]opCode,
    input [2:0]irMid3bit,
    input irLastBit,
    input br_eq,
    input br_lt,
    input br_ltu,
    output logic[3:0]alu_fun,
    output logic alu_srcA,
    output logic[1:0]alu_srcB,
    output logic[2:0]pcSource,
    output logic[1:0]rf_wr_sel
    );
    
    always_comb
    begin
    alu_fun = 4'b0000;
    alu_srcA = 1'b0;
    alu_srcB = 2'b00;
    pcSource = 3'b000;
    rf_wr_sel = 2'b00;
    
    case(opCode)
        7'b0110111: begin //lui
            alu_fun = 4'b1001;
            alu_srcA = 1'b1;
            alu_srcB = 2'b00;
            pcSource = 3'b000;
            rf_wr_sel = 2'b11;
            
            end
            
        7'b0010011: begin //I-TYPE
            case(irMid3bit)
                3'b000: begin //addi
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
               3'b001: begin //slli
                    alu_fun = 4'b0001;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
              3'b111: begin //andi
                    alu_fun = 4'b0111;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
              3'b110: begin //ori
                    alu_fun = 4'b0110;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
              3'b010: begin //slti
                    alu_fun = 4'b0010;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
              3'b011: begin //sltiu
                    alu_fun = 4'b0011;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
              3'b101: begin //srli and srai
                    case(irLastBit)
                    1'b0: begin //srli
                        alu_fun = 4'b0101;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b01;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b11;
                        end
                        
                    1'b1: begin //srai
                        alu_fun = 4'b1101;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b01;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b11;
                        end
                        
                    default:begin
                        alu_fun = 4'b0101;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b00;
                        end
                        
                        endcase
                    end
                    
              3'b100: begin //xori
                    alu_fun = 4'b0100;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b01;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
            default:begin
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b00;
                    end
            endcase  
         
        end
        7'b0110011: begin //R-Type
            case(irMid3bit)
                3'b010: begin //SLT
                    alu_fun = 4'b0010;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
               3'b100: begin //XOR
                    alu_fun = 4'b0100;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
               3'b000: begin //add and sub
                    case(irLastBit)
                    1'b0: begin //add
                        alu_fun = 4'b0000;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b11;
                        end
                        
                    1'b1: begin //sub
                        alu_fun = 4'b1000;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b11;
                        end
                        
                    default:begin
                        alu_fun = 4'b0000;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b00;
                        end
                        
                        endcase
                    end
                3'b111: begin //AND
                    alu_fun = 4'b0111;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end 
                    
               3'b110: begin //OR
                    alu_fun = 4'b0110;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end  
                    
               3'b001: begin //SLL
                    alu_fun = 4'b0001;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end   
                    
               3'b011: begin //SLTU
                    alu_fun = 4'b0011;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b11;
                    end
                    
               3'b101: begin //sra and srl
                    case(irLastBit)
                    1'b0: begin //srl
                        alu_fun = 4'b0101;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b11;
                        end
                        
                    1'b1: begin //sra
                        alu_fun = 4'b1101;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b11;
                        end
                        
                    default:begin
                        alu_fun = 4'b0101;
                        alu_srcA = 1'b0;
                        alu_srcB = 2'b00;
                        pcSource = 3'b000;
                        rf_wr_sel = 2'b00;
                        end
                        endcase
                    end 
                    
                default:begin
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b00;
            end
            endcase  
         
        end
        7'b1100011: begin //B-TYPE
            case(irMid3bit)
                3'b000: begin //beq
                    if(br_eq==1'b1)
                        pcSource = 3'b010;
                    else
                        pcSource = 3'b000;
                    end
                    
                3'b101: begin //bge
                    if(br_lt==1'b0)
                        pcSource = 3'b010;
                    else
                        pcSource = 3'b000;
                    end
                    
                3'b111: begin //bgeu
                    if(br_ltu==1'b0)
                        pcSource = 3'b010;
                    else
                        pcSource = 3'b000;
                    end
                    
                3'b100: begin //blt
                    if(br_lt==1'b1)
                        pcSource = 3'b010;
                    else
                        pcSource = 3'b000;
                    end
                    
                3'b110: begin //bltu
                    if(br_ltu==1'b1)
                        pcSource = 3'b010;
                    else
                        pcSource = 3'b000;
                    end
                    
                3'b001: begin //bne
                    if(br_eq==1'b0)
                        pcSource = 3'b010;
                    else
                        pcSource = 3'b000;
                    end
                default: begin
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b00;
                    pcSource = 3'b000;
                    rf_wr_sel = 2'b00;
                    end
                    endcase 
            end
        7'b0100011: begin //S-Type
            case(irMid3bit)
                3'b000: begin //sb
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b10;
                    pcSource = 3'b000;
                    end
                    
                3'b001: begin //sh
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b10;
                    pcSource = 3'b000;
                    end
                    
                3'b010: begin //sw
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b10;
                    pcSource = 3'b000;
                    end
                default: begin
                    alu_fun = 4'b0000;
                    alu_srcA = 1'b0;
                    alu_srcB = 2'b10;
                    pcSource = 3'b000;
                    end
                    endcase
             end
        7'b1101111: begin //Jal
                pcSource = 3'b011;
                rf_wr_sel = 2'b00;    
            end
        7'b1100111: begin //Jalr
                pcSource = 3'b001;
                rf_wr_sel = 2'b00;    
            end
        7'b0010111: begin //auipc
                alu_fun = 4'b0000;
                alu_srcA = 1'b1;
                alu_srcB = 2'b11;
                pcSource = 3'b000;
                rf_wr_sel = 2'b11;   
            end
        7'b0000011: begin //loads
                alu_fun = 4'b0000;
                alu_srcA = 1'b0;
                alu_srcB = 2'b01;
                pcSource = 3'b000;
                rf_wr_sel = 2'b10;   
            end
            
            
        default: begin
            alu_fun = 4'b0000;
            alu_srcA = 1'b0;
            alu_srcB = 2'b00;
            pcSource = 3'b000;
            rf_wr_sel = 2'b00;
            end
        endcase
        
    end
endmodule
