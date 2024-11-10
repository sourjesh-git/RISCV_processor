module MUX_4 (
    input [1:0] S,
    input [3:0] A,
    output Y
);

    wire [1:0] Z;

    // Component instances of MUX_2 logic
    MUX_2 MUX1 (.S(S[0]), .A(A[3:2]), .Y(Z[1]));
    MUX_2 MUX2 (.S(S[0]), .A(A[1:0]), .Y(Z[0]));
    MUX_2 MUX3 (.S(S[1]), .A(Z), .Y(Y));

endmodule

// Definition of MUX_2 module
module MUX_2 (
    input S,
    input [1:0] A,
    output Y
);

    assign Y = (S) ? A[1] : A[0];

endmodule
