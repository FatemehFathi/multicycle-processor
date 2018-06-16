`timescale 1ns/1ns

module ALU(aluOp, a, b, w, zero);
  input[2:0] aluOp;
  input[15:0] a, b;
  output reg[15:0] w;
  output reg zero;
  
  always@(*) begin
    zero = 0;
    case(aluOp)
      000: begin w = a + b; end
      001: begin w = a - b; end
      010: begin w = a & b; end
      011: begin w = ~b; end
      100: begin 
        if(a == 0) zero = 1;
        else zero = 0;
      end
    endcase
  end
endmodule







module alu_TB();
  reg[2:0] alu_op;
  reg[15:0] aa, bb;
  wire[15:0] ww;
  wire zer0;
  
  ALU alu(alu_op, aa, bb, ww, zer0);
  
  initial begin
    #20 alu_op = 3'b000;
    aa = 16'b0000000000000000;
    bb = 16'b1111111111111111;
    
    #20 alu_op = 3'b001;
    
    #20 alu_op = 3'b011;
  end
  
endmodule
