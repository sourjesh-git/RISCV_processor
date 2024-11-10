module Register128bit (
    input wire Clk,
    input wire Reset,
    input wire [127:0] data_in,
    input wire Stallbar,
    output reg [127:0] data_out,
    output reg valid_bit
);

    // D Flip-Flop Declaration
    module D_FlipFlop (
        input wire Clk,
        input wire Reset,
        input wire input,
        input wire enable,
        output reg output
    );
        always @(posedge Clk or posedge Reset) begin
            if (Reset) begin
                output <= 1'b0; // Reset output to 0
            end else if (!enable) begin
                output <= input; // Capture input on clock edge if enabled
            end
        end
    endmodule

    // Instantiate D Flip-Flops for each bit
    genvar i;
    generate
        for (i = 0; i < 128; i = i + 1) begin : DFF_LOOP
            D_FlipFlop fx (
                .Clk(Clk),
                .Reset(Reset),
                .input(data_in[i]),
                .enable(Stallbar),
                .output(data_out[i])
            );
        end
    endgenerate

    // Calculate valid_bit
    always @(*) begin
        valid_bit = |data_in; // Use bitwise OR reduction operator
    end

endmodule
