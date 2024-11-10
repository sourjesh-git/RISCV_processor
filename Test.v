module Test (
    input wire clk,
    input wire reset,
    output wire [2:0] Values
);

    // D Flip-Flop Declaration
    module d_ff (
        input wire D,
        input wire clk,
        input wire preset,
        input wire reset,
        input wire E,
        output reg Q,
        output reg Qbar
    );
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                Q <= 1'b0;
                Qbar <= 1'b1; // Assuming Qbar is complementary to Q
            end else if (E) begin
                Q <= D;
                Qbar <= ~D; // Qbar is the inverted value of D
            end
        end
    endmodule

    // Three-bit Synchronous Up Counter Declaration
    module three_bit_sync_up (
        input wire clk,
        input wire reset,
        output reg [2:0] Count,
        output reg [2:0] CountBar,
        input wire enable
    );
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                Count <= 3'b000;
                CountBar <= 3'b111;
            end else if (enable) begin
                Count <= Count + 1;
                CountBar <= ~Count; // CountBar is the inverted Count
            end
        end
    endmodule

    // Internal signals
    wire [2:0] Num;
    wire [2:0] NumBar;

    // Instantiate three_bit_sync_up counter
    three_bit_sync_up TBSU (
        .clk(clk),
        .reset(reset),
        .Count(Num),
        .CountBar(NumBar),
        .enable(1'b1)
    );

    // Instantiate D Flip-Flops
    d_ff DFF1 (
        .D(Num[2]),
        .clk(clk),
        .preset(1'b0),
        .reset(reset),
        .E(1'b1),
        .Q(Values[2]),
        .Qbar(V[0]) // Assuming V is a reg, not declared here
    );

    d_ff DFF2 (
        .D(Num[1]),
        .clk(clk),
        .preset(1'b0),
        .reset(reset),
        .E(1'b1),
        .Q(Values[1]),
        .Qbar(V[1]) // Assuming V is a reg, not declared here
    );

    d_ff DFF3 (
        .D(Num[0]),
        .clk(clk),
        .preset(1'b0),
        .reset(reset),
        .E(1'b1),
        .Q(Values[0]),
        .Qbar(V[2]) // Assuming V is a reg, not declared here
    );

endmodule
