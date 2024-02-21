module datapath(clk, reset, regwe, dmemwe 
                rs2sel, regsel, PCsel, 
                ALUControl,  Instr
               ); 
  input clk, reset;

    input dmemwe, regwe;
    input rs2sel;
    input [1:0] regsel;
    input [3:0] ALUControl;
    input [31:0] Instr; 

    wire [31:0]     PC_next;
    wire [31:0]     readData1, readData2,read_data, writData;
    wire [31:0]     muxrs2, ExtImm;
    wire [31:0]     ALUResults;
    wire [31:0]     pcplus4;

  adder plus4 (
        .a(4), 
        .b(pc_next), 
        .y(pcplus4));
  
  mux_2x1 MUXrs2 (
        .a(readData2), 
        .b(ExtImm), 
        .sel(rs2sel), 
        .y(muxrs2));
  
  mux_2x1 regmux (
        .a(read_data), 
        .b(ALUResults), 
        .sel(regsel), 
        .y(writeData));
  
  alu32 alu (
        .a(readData1), 
        .b(muxrs2), 
        .ALUControl(ALUControl), 
        .result(ALUResults));
  
  extend imm_extend(
    .imm(instr[31:20]),
    .ExtImm(ExtImm));
    
  
  regfile regFILE (
        .readAddr1(Instr[19:15]),
        .readAddr2(Instr[24:20]),
        .writeAddr(Instr[11:7]),
        .writeData(writeData),
    .regwe(regwe),
        .clk(clk),
        .reset(reset),
        .readData1(readData1),
        .readData2(readData2));

  
  datamem data_memory(
    .clk(clk),
    .dmemwe(dmemwe),
    .address(ALUResults),
    .write_data(readData2),
    .read_data(read_data));
  
  instr_mem instruction_memory(
    .clk(clk),
    .reset(reset),
    .base_address(pcplus4),
    .data_out(instr));
  
  decoder decode_unit(
    .instruction(instr),
    .opcode(instr[6:0])
    .rd(Instr[11:7]),
    .rs1(Instr[19:15]),
    .rs2(Instr[24:20]),
    .funct3(instr[14:12]),
    .funct7(instr[25:31]),
    .imm(instr[31:20]));
