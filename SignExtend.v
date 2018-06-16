`timescale 1ns/1ns

module SignExtend(dataIn, dataOut);
  input[12:0] dataIn;
  output [15:0] dataOut;
  assign dataOut = $signed(dataIn);
endmodule
