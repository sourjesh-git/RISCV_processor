module D_FlipFlop (
    input Clk,           // Clock signal
    input Reset,         // Reset signal
    input D,             // Data input (input in VHDL)
    input enable,        // Enable signal
    output reg Q         // Output (buffer in VHDL, but in Verilog, just use reg type for output)
);

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            Q <= 1'b0;      // Asynchronous reset to 0
        end else if (enable) begin
            Q <= D;         // Load input into the flip-flop when enable is high
        end
    end

endmodule
