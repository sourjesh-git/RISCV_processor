module Reg_16BIT (
    input reset,
    input clk,
    input [15:0] data_in,
    output reg [15:0] data_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 16'b0000000000000000;
        end
        else begin
            data_out <= data_in;
        end
    end

endmodule
