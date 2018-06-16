`timescale 1ns/1ns

module MUX13(sel, a, b, w);
  input sel;
  input[12:0] a, b;
  output[12:0] w;
    
  assign w = (sel == 0) ? a : b;	
endmodule




module MUX16(sel, a, b, w);
  input sel;
  input[15:0] a, b;
  output[15:0] w;
  
  assign w = (sel == 0) ? a : b;	
endmodule
