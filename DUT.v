module DUT (
    input [7:0] input_vector,     // 8-bit input vector
    output [5:0] output_vector    // 6-bit output vector
);

    // Instantiate ALU_1 module with a parameter for operand width
    ALU_1 #(.operand_width(4)) add_instance (
        .A(input_vector[7:4]),   // Map upper 4 bits of input_vector to A
        .B(input_vector[3:0]),   // Map lower 4 bits of input_vector to B
        .Op(output_vector)       // Map output Op to output_vector
    );

endmodule
