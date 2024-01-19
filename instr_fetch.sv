// Code your design here
module instr_fetch( input wire clk,
                    input wire reset,
                    input wire enable,
                    output wire [31:0] instruction);
  wire [31:0] next_pc;
  wire [31:0] current_pc;
  register pc_reg ( .clk(clk), .reset(reset), .enable(enable), .data_in(next_pc), .data_out(current_pc));
  instr_mem im( .clk(clk), .base_address(current_pc), .data_out(instruction));
  assign next_pc = current_pc + 4;
                   
endmodule
