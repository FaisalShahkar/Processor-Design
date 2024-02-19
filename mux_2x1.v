module mux_2x1(
  input wire [32-1:0] a,
  input wire [32-1:0] b,
  input wire        sel,
  output wire [32-1:0] y
              );
	assign y = sel ? b : a; //If sel is 1, output y is assigned the value of input b. If sel is 0, output y is assigned the value of input a.

endmodule
