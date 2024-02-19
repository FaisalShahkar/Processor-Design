module datapath(clk, reset, regWE, 
                rs2sel, regsel, PCsel, 
                ALUControl,  Instr,
                 dmemrs2); 
  input clk, reset;

    input regWE;
    input rs2sel;
    input [1:0] regsel;
    input [3:0] ALUControl;
    input [31:0] Instr;
    output [31:0] dmemrs2, ALUout; 

    wire [31:0]     PC_next;
    wire [31:0]     readData1, readData2, writeAddr;
    wire [31:0]     muxrs2;
    wire [31:0]     ALUResults;
    wire [31:0]     pcplus4;

   
  regfile regFILE (
        .readAddr1(Instr[19:15]),
        .readAddr2(Instr[24:20]),
        .writeAddr(writeAddr),
        .writeData(Instr[11:7]),
        .we(regWE),
        .clk(clk),
        .reset(reset),
        .readData1(readData1),
        .readData2(readData2));
  assign dmemrs2 = rdout2;
  
  mux_2x1 MUXrs2 (
        .a(readData2), 
        .b(ExtImm), 
        .sel(rs2sel), 
        .y(muxrs2));
  
  adder plus4 (
        .a(4), 
        .b(pc_next), 
        .y(pcplus4));
  
  alu32 alu (
        .a(readData1), 
        .b(muxrs2), 
        .ALUControl(ALUControl), 
        .result(ALUResults));
  assign ALUout = ALUResults;
  mux_2x1 regmux (
        .a(read_data), 
        .b(ALUResults), 
        .sel(regsel), 
        .y(writeData));
