module MUX_2 (
    input S,
    input [1:0] A,
    output Y
);

    wire Sc, Z0, Z1;

    // Component instances
    assign Sc = ~S;           // Inverter
    assign Z0 = Sc & A[0];    // AND gate
    assign Z1 = S & A[1];     // AND gate
    assign Y = Z1 | Z0;       // OR gate

endmodule
