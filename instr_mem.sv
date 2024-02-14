module instr_mem(input wire clk,
                   input wire reset,
                   input wire  [31:0] base_address,  
                   output wire [31:0] data_out);
  
  reg [7:0] imem [79:0]; // 32*20 instruction memory size
  reg [31:0] out;
  $readmemh("instructions.txt",imem);
  always@(posedge clk)
    begin
      out = {imem[base_address+3].imem[base_address+2].imem[base_address+1].imem[base_address]};
    end
  assign data_out = out;
  
  
  
endmodule
