`timescale 1ns/1ns

module PC(clk, rst, PCwrite, dataIn, dataOut);
  input clk, rst, PCwrite;
  input[12:0] dataIn;
  output reg[12:0] dataOut;
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      dataOut <= 16'b0000000000000000;
    if(PCwrite)
      dataOut <= dataIn;
  end
endmodule
