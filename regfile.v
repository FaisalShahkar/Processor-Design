module regfile (
  input wire [3:0] readAddr1, // First read address
  input wire [3:0] readAddr2, // Second read address
  input wire [3:0] writeAddr, // Write address
  input wire [31:0] writeData, // Data to be written
  input wire regwe, // Write enable signal

  output reg [31:0] readData1, // Output data from the first read address
  output reg [31:0] readData2 // Output data from the second read address
);
  reg [31:0] registers [0:15]; // 16 registers

  // Read data from the specified registers
  always @* begin
    readData1 = (readAddr1 == 0) ? 32'b0 : registers[readAddr1];
    readData2 = (readAddr2 == 0) ? 32'b0 : registers[readAddr2];
  end

  // Write data to the specified register if write enable is asserted
  always @(posedge we or writeAddr) begin
    if (writeAddr != 0 && we) // Ignore writes to register 0
      registers[writeAddr] <= writeData;
  end
endmodule
