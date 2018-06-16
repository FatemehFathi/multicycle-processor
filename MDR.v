`timescale 1ns/1ns

module MDR(clk, rst, dataIn, dataOut);
  input clk, rst;
  input[15:0] dataIn;
  output reg[15:0] dataOut;
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      dataOut <= 16'b0000000000000000;
    else
      dataOut <= dataIn;
  end
endmodule
