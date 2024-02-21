module Single_Cycle_RV32I(clk, reset, instr, dmemwe, dmemAdrs, dmemDataRead, dmemDataStore);
    input wire          clk, reset;
    input wire [31:0]   instr;
    output wire         dmemwe;

    wire [3:0]          ALUControl;
    wire                regsel;
    wire                regwe, rs2sel;      

    datapath datapath_single_cycle (
            .clk(clk), 
            .reset(reset), 
            .regwe(regwe),
            .dmemwe(dmemwe),
            .rs2sel(rs2sel), 
            .regsel(regsel), 
            .ALUControl(ALUControl), 
            .Instr(instr)); 

    control_logic Single_Cycle_Control (
            .clk(clk),
            .reset(reset),
            .instr(instr),  
            .ALUControl(ALUControl), 
            .regsel(regsel),  
            .dmemwe(dmemWe), 
            .regwe(regwe), 
            .rs2sel(rs2sel));



endmodule
