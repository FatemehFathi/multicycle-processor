`timescale 1ns/1ns

module IR(clk, rst, IRwrite, dataIn, dataOut);
  input clk, rst, IRwrite;
  input[15:0] dataIn;
  output reg[15:0] dataOut;
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      dataOut <= 16'b0000000000000000;
    if(IRwrite)
      dataOut <= dataIn;
  end
endmodule
