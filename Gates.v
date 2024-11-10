// INVERTER
module INVERTER (
    input A,
    output Y
);
    assign Y = ~A;
endmodule

// AND_2
module AND_2 (
    input A,
    input B,
    output Y
);
    assign Y = A & B;
endmodule

// NAND_2
module NAND_2 (
    input A,
    input B,
    output Y
);
    assign Y = ~(A & B);
endmodule

// OR_2
module OR_2 (
    input A,
    input B,
    output Y
);
    assign Y = A | B;
endmodule

// NOR_2
module NOR_2 (
    input A,
    input B,
    output Y
);
    assign Y = ~(A | B);
endmodule

// XOR_2
module XOR_2 (
    input A,
    input B,
    output Y
);
    assign Y = A ^ B;
endmodule

// XNOR_2
module XNOR_2 (
    input A,
    input B,
    output Y
);
    assign Y = ~(A ^ B);
endmodule

// HALF_ADDER
module HALF_ADDER (
    input A,
    input B,
    output S,
    output C
);
    assign S = A ^ B;  // Sum
    assign C = A & B;  // Carry
endmodule
