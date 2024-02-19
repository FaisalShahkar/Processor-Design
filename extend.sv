module extend(
    input wire [11:0] input_data,
    output reg [31:0] output_data
);

    always @* begin
        if (input_data[11] == 1'b0) begin
            output_data = {input_data, {20{1'b0}}}; // Fill remaining bits with 0s
        end else begin
            output_data = {input_data, {20{1'b1}}}; // Fill remaining bits with 1s
        end
    end

endmodule
