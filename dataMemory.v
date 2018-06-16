`timescale 1ns/1ns

module dataMemory(input clk, rst, memWrite, memRead, input[12:0] adr, input[15:0] writeData, output[15:0] data); 
  reg[15:0] datamem[0:1023];
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      $readmemb("data.dat", datamem);
    else if(memWrite)
      datamem[adr] <= writeData[15:0];
  end
  
  assign data = (memRead) ? {datamem[adr]} : data; 
endmodule






module dataMemory_TB();
  
  reg clk, rst, memRead, memWrite;
  reg[12:0] addr;
  reg[15:0] writeData;
  wire[15:0] data;
  
  dataMemory data_memory(clk, rst, memWrite, memRead, addr, writeData, data);
  
  initial  begin
    clk = 1;
    rst = 1;
    #100 clk = 0;
    #100 clk = 1;
    memWrite = 1;
    writeData = 16'b0000000000001111;
    addr = 13'b0000000000000;
    
    #100 memRead = 1;
    #200 $stop;
  end
 endmodule

