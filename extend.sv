module extend(
    input wire [11:0] imm,
    output reg [31:0] ExtImm
);

    always @* begin
        if ( imm[11] == 1'b0) begin
            ExtImm = { imm, {20{1'b0}}}; // Fill remaining bits with 0s
        end else begin
            ExtImm = { imm, {20{1'b1}}}; // Fill remaining bits with 1s
        end
    end

endmodule
