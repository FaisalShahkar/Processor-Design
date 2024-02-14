module register(
  input wire clk,
  input wire reset,
  input wire enable,
  input wire [31:0] data_in,
  output wire [31:0] data_out
);

  reg [31:0] out;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out <= 32'b0;
    end
    else begin
      if (~enable) begin
        out <= out;
      end
      else begin
        out <= data_in;
      end
    end
  end

  assign data_out = out;

endmodule;
