`timescale 1ns/1ns

module ACC(clk, rst, ACCwrite, dataIn, dataOut);
  input clk, rst, ACCwrite;
  input[15:0] dataIn;
  output reg[15:0] dataOut;
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      dataOut <= 16'b0000000000000000;
    else if(ACCwrite)
      dataOut <= dataIn;
  end
endmodule








module acc_TB();
  reg clock, accWrite;
  reg[15:0] data_in;
  wire[15:0] data_out;
  
  ACC acc(clock, accWrite, data_in, data_out);
  
  initial begin
    #10 clock = 0;
    #30 clock = ~clock;
    accWrite = 1;
    data_in = 16'b0000000000000000; //clk = posedge, write = 1
    #20 data_in = 16'b0001111100000000;
    
    #30 clock = ~clock;
    #30 clock = ~clock;
    data_in = 16'b0001111111111111; //clk = posedge, write = 1
    
    #30 clock = ~clock;
    #30 clock = ~clock;
    accWrite = 0;
    data_in = 16'b1111111111111111; //clk = posedge, write = 0
    
    #30 clock = ~clock;
    accWrite = 1;
    data_in = 16'b1111110000111111; //clk = negedge, write = 1
  end
    
endmodule
