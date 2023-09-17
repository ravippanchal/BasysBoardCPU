`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 01:47:52 PM
// Design Name: 
// Module Name: Otter__TOP
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


module Otter__TOP(
    input RST,
    input INTR,
    input [31:0]IOBUS_IN,
    input CLK,
    output IOBUS_WR,
    output [31:0]IOBUS_OUT,
    output [31:0]IOBUS_ADDR
    );
    //PC signals
    logic [31:0] jalr_BAG, branch_BAG, jal_BAG,pcOut_Addr1;
    logic PCWrite_FSM, rst_FSM;
    logic [2:0]pcSource_DCDR;
    
    //Memory signals
    logic [31:0] DOUT1_REG,DOUT2_MUX;
    logic rden1_FSM,rden2_FSM,memWE2_FSM;
    
    //Reg signals
    logic regWrite_FSM;
    logic [1:0]rf_wr_sel_DCDR;
    logic [31:0]mux_WD,ALU_OUT,rs1_out,rs2_out;
    logic [31:0]plusfour;
    assign plusfour = pcOut_Addr1 + 4;
    
    //IMGen signals 
    logic [31:0] uType, iType, sType, jType, bType; 
    
    //ALU signals
    logic alu_srcA_FSM;
    logic [1:0]alu_srcB_FSM;
    logic [3:0]alu_fun_FSM;
    logic [31:0] srcA,srcB; 
    
    logic br_eq_DCDR, br_lt_DCDR, br_ltu_DCDR; 
    
    
    
    PC_TOP pc (.pcwrite(PCWrite_FSM),.rst(rst_FSM),.CLK(CLK),.jalr(jalr_BAG),.branch(branch_BAG),.jal(jal_BAG),.pcSource(pcSource_DCDR),.PC_OUT(pcOut_Addr1));
   
    Memory memory (.MEM_CLK(CLK),.MEM_ADDR2(ALU_OUT),.MEM_DIN2(rs2_out),.MEM_ADDR1(pcOut_Addr1[15:2]),.MEM_RDEN1(rden1_FSM),.MEM_RDEN2(rden2_FSM),.MEM_WE2(memWE2_FSM),.MEM_SIZE(DOUT1_REG[13:12]),.MEM_SIGN(DOUT1_REG[14]),.IO_IN(IOBUS_IN),.IO_WR(IOBUS_WR),.MEM_DOUT1(DOUT1_REG),.MEM_DOUT2(DOUT2_MUX));
    
    always_comb
    begin
    case(rf_wr_sel_DCDR)
        2'd0: mux_WD = plusfour;
        2'd1: mux_WD = 32'd0;
        2'd2: mux_WD = DOUT2_MUX;
        2'd3: mux_WD = ALU_OUT;
        default: mux_WD = 32'd0;
        endcase
    end
    
    REG_FILE regfile (.Wd(mux_WD),.en(regWrite_FSM),.adr1(DOUT1_REG[19:15]),.adr2(DOUT1_REG[24:20]),.wa(DOUT1_REG[11:7]),.rs1(rs1_out),.rs2(rs2_out),.clk(CLK));
    assign IOBUS_OUT = rs2_out;
    
    Immediate_Generator immgen (.in(DOUT1_REG[31:7]),.J_type(jType),.B_type(bType),.S_type(sType),.I_type(iType),.U_type(uType));
    
    
    always_comb
    begin
    case(alu_srcA_FSM)
        1'd0: srcA = rs1_out;
        1'd1: srcA = uType;
        default: srcA = 32'd0;
        endcase
    end
    
    always_comb
    begin
    case(alu_srcB_FSM)
        2'd0: srcB = rs2_out;
        2'd1: srcB = iType;
        2'd2: srcB = sType;
        2'd3: srcB = pcOut_Addr1;
        default: srcB = 32'd1;
        endcase
    end
    
    ALU alu (.src_A(srcA),.src_B(srcB),.alu_fun(alu_fun_FSM),.ALU_Out(ALU_OUT));
    assign IOBUS_ADDR = ALU_OUT;
    
    BAC addressGen (.pc_in(pcOut_Addr1),.i_in(iType),.rs1_in(rs1_out),.j_in(jType),.b_in(bType),.jal(jal_BAG),.branch(branch_BAG),.jalr(jalr_BAG));
    
    BCG bcg (.rs1(rs1_out),.rs2(rs2_out),.br_eq(br_eq_DCDR),.br_lt(br_lt_DCDR),.br_ltu(br_ltu_DCDR));
    
    CU_FSM fsm (.clk(CLK),.RST(RST),.opCode7b(DOUT1_REG[6:0]),.opCode3b(DOUT1_REG[14:12]),.regWrite(regWrite_FSM),.memWE2(memWE2_FSM),.memRDEN1(rden1_FSM),.memRDEN2(rden2_FSM),.reset(rst_FSM),.PCWrite(PCWrite_FSM));
    
    CU_DCDR decoder (.opCode(DOUT1_REG[6:0]),.irMid3bit(DOUT1_REG[14:12]),.irLastBit(DOUT1_REG[30]),.br_eq(br_eq_DCDR),.br_lt(br_lt_DCDR),.br_ltu(br_ltu_DCDR),.alu_fun(alu_fun_FSM),.alu_srcA(alu_srcA_FSM),.alu_srcB(alu_srcB_FSM),.pcSource(pcSource_DCDR),.rf_wr_sel(rf_wr_sel_DCDR));
    
    
endmodule
