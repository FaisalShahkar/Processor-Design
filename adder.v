module adder(
  input wire [32-1:0]	a,
  input wire [32-1:0]	b,
  output wire [32-1:0] y
);

	assign y = a + b;

endmodule
