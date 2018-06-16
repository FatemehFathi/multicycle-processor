`timescale 1ns/1ns

module aluReg(clk, rst, dataIn, dataOut);
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





module aluReg_TB();
  reg clock;
  reg[15:0] data_in;
  wire[15:0] data_out;
  
  aluReg alu_reg(clock, data_in, data_out);
  
  initial begin
    #10 clock = 0;
    #30 clock = ~clock;
    data_in = 16'b0000000000000000; //clk = posedge
    #20 data_in = 16'b0001111100000000;
    
    #30 clock = ~clock;
    data_in = 16'b1111110000111111; //clk = negedge
    
    #30 clock = ~clock;
    #30 clock = ~clock;
    data_in = 16'b0001111111111111; //clk = posedge
  end
    
endmodule