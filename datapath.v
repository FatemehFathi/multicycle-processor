`timescale 1ns/1ns

module datapath(clk, rst, pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite,
                aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem, aluOp, opc);
                
  input clk, rst, pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite, aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem;
  input[2:0] aluOp;
  output[2:0] opc;
   
   
  wire[15:0] accIn, accOut;
  wire[12:0] pcIn, pcOut;
  wire[15:0] data, irOut;
  wire pcld;
  wire[15:0] SignedExt;
  wire[12:0] adr;
  wire[15:0] aluA, aluB, aluRes;
  wire zero;
  wire[15:0] mdrOut;
  wire[15:0] aluRegOut;
  
  
  
  wire w;
  AND a(zero, pcWriteCond, w);
  OR o(w, pcWrite, pcld);
  
  SignExtend se(pcOut[12:0], SignedExt[15:0]);
  
  PC pc(clk, rst_pc, pcld, pcIn[12:0], pcOut[12:0]);
  IR ir(clk, rst_ir, IRwrite, data[15:0], irOut[15:0]);
  ACC acc(clk, rst_acc, ACCwrite, accIn[15:0], accOut[15:0]);
  MDR mdr(clk, rst_mdr, data[15:0], mdrOut[15:0]);
  aluReg ar(clk, rst_aluReg, aluRes[15:0], aluRegOut[15:0]);
  
  MUX13 m1(pcSrc, irOut[12:0], aluRes[12:0], pcIn[12:0]);
  MUX13 m2(IorD, pcOut[12:0], irOut[12:0], adr[12:0]);
  MUX16 m3(accSrc, aluRegOut[15:0], mdrOut[15:0], accIn[15:0]);
  MUX16 m4(aluSrcA, SignedExt[15:0], accOut[15:0], aluA[15:0]);
  MUX16 m5(aluSrcB, mdrOut[15:0], 16'b1, aluB[15:0]);
  
  ALU alu(aluOp[2:0], aluA[15:0], aluB[15:0], aluRes[15:0], zero);
  
  dataMemory dm(clk, rst_dataMem, memWrite, memRead, adr[12:0], accOut[15:0], data[15:0]);
  
  assign opc[2:0] = irOut[15:13];
  
endmodule
