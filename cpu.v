`timescale 1ns/1ns

module cpu(clk, rst);
  input clk, rst;
  wire pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite, aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem;
  wire[2:0] opc;
  wire[2:0] aluOp;
  
  datapath dp(clk, rst, pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite,
                aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem, aluOp, opc); 
                        
  controller cu(clk, rst, pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite,
                aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem, aluOp, opc);
                 
endmodule






module cpu_TB();
  reg clock, reset;
  
  cpu c(clock, reset);
    
  initial begin
    repeat(100)#800 clock = ~clock;
  end
  
  initial begin
    clock = 0; reset = 0;
    #400 reset = 1;
    #400 reset = 0;
  end

  
endmodule
