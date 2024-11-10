module MUX_8 (
    input [2:0] S,
    input [7:0] A,
    output Y
);

    wire [3:0] Z;
    wire [1:0] V;

    // Component instances of MUX_2 logic
    MUX_2 MUX1 (.S(S[0]), .A(A[7:6]), .Y(Z[3]));
    MUX_2 MUX2 (.S(S[0]), .A(A[5:4]), .Y(Z[2]));
    MUX_2 MUX3 (.S(S[0]), .A(A[3:2]), .Y(Z[1]));
    MUX_2 MUX4 (.S(S[0]), .A(A[1:0]), .Y(Z[0]));
    MUX_2 MUX5 (.S(S[1]), .A(Z[3:2]), .Y(V[1]));
    MUX_2 MUX6 (.S(S[1]), .A(Z[1:0]), .Y(V[0]));
    MUX_2 MUX7 (.S(S[2]), .A(V), .Y(Y));

endmodule

// Definition of MUX_2 module
module MUX_2 (
    input S,
    input [1:0] A,
    output Y
);

    assign Y = (S) ? A[1] : A[0];

endmodule
