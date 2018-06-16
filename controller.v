`timescale 1ns/1ns

module controller(clk, rst, pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite,
                aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem, aluOp, opc);

  input clk, rst;
  input[2:0] opc;
  output reg  pcSrc, IorD, memRead, memWrite, IRwrite, pcWrite, pcWriteCond, accSrc, ACCwrite, aluSrcA, aluSrcB, rst_pc, rst_ir, rst_acc, rst_mdr, rst_aluReg, rst_dataMem;
  output reg[2:0] aluOp;

  reg[2:0] state, ns;
  localparam s0=0, s1=1, s2=2, s3=3, s4=4, s5=5;
  
  
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      state <= 4'b0000;
    else
      state <= ns;
  end



  always@(state, posedge clk) begin
    memWrite <= 1'b0;
    pcWriteCond <= 1'b0;
    accSrc <= 1'b0;
    ACCwrite <= 1'b0;
    aluSrcA <= 1'b0;
    aluSrcB <= 1'b0;
    IorD <= 1'b0;
    memRead <= 1'b0;
    IRwrite <= 1'b0;
    pcSrc <= 1'b0;
    aluSrcA <= 1'b0;
    aluSrcB <= 1'b0;
    aluOp <= 3'b000;
    pcWrite <= 1'b0;
    rst_pc <= 1'b0;
    rst_ir <= 1'b0;
    rst_acc <= 1'b0;
    rst_mdr <= 1'b0;
    rst_aluReg <= 1'b0;
    rst_dataMem <= 1'b0;
   
    case(state) 
      s0: begin
        if(rst) begin
          rst_pc <= 1'b1;
          rst_ir <= 1'b1;
          rst_acc <= 1'b1;
          rst_mdr <= 1'b1;
          rst_aluReg <= 1'b1;
          rst_dataMem <= 1'b1;
          ns = s1;
        end
      end
      
      ////////////////////////////////////////////////// IF
      
      s1: begin
        IorD <= 0;
        memRead <= 1;
        IRwrite <= 1;
        pcSrc <= 1;
        aluSrcA <= 0;
        aluSrcB <= 1;
        aluOp <= 3'b000;
        pcWrite <= 1;
        ns = s2;
      end
      
      ////////////////////////////////////////////////// ID
      
      s2: begin
        ns = s3;
      end
      
      ////////////////////////////////////////////////// STA & JMP complete
      
      s3: begin
        if (opc == 3'b000 || opc == 3'b001 || opc == 3'b010 || opc == 3'b011 || opc == 3'b100) begin
          IorD <= 1;
          memRead <= 1;
          ns = s4;
        end
        
        else if (opc == 3'b101) begin // STA
          IorD <= 1;
          memWrite <= 1;
          ns = s1;
        end
        
        else if (opc == 3'b110) begin // JMP
          pcSrc <= 0;
          pcWrite <= 1;
          ns = s1;
        end
        
        else if (opc == 3'b111) begin // JZ
          aluSrcA <= 1;
          aluOp <= 3'b100;
          ns = s4;
        end
      end
      
      //////////////////////////////////////////////////// LDA & JZ complete
      
      s4: begin
        if (opc == 3'b000) begin // ADD
          aluSrcA <= 1;
          aluSrcB <= 0;
          aluOp <= 3'b000;
          ns = s5;
        end
        
        else if (opc == 3'b001) begin // SUB
          aluSrcA <= 1;
          aluSrcB <= 0;
          aluOp <= 3'b001;
          ns = s5;
        end
        
        else if (opc == 3'b010) begin // AND
          aluSrcA <= 1;
          aluSrcB <= 0;
          aluOp <= 3'b010;
          ns = s5;
        end
        
        else if (opc == 3'b011) begin // NOT
          aluSrcB <= 0;
          aluOp <= 3'b011;
          ns = s5;
        end
        
        else if (opc == 3'b100) begin // LDA
          accSrc <= 1;
          ACCwrite <= 1;
          ns = s1;
        end
        
        else if (opc == 3'b111) begin // jz
          pcWriteCond <= 1;
          pcSrc <= 0;
          ns = s1;
        end
      end
      
      //////////////////////////////////////////////////// RT complete

      s5: begin
        if(opc == 3'b000 || opc == 3'b001 || opc == 3'b010 || opc == 3'b011)begin
          accSrc <= 0;
          ACCwrite <= 1;
          ns = s1;
        end
      end
      
    endcase
  end
  
endmodule
