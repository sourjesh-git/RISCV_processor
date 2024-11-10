module ALU2 (
    input [15:0] A,  // 16-bit input A
    input [15:0] B,  // 16-bit input B
    output [15:0] C  // 16-bit output C
);

    // Function to perform 16-bit addition with carry
    function [15:0] Add;
        input [15:0] A, B;  // 16-bit inputs A and B
        reg carry;          // 1-bit carry
        reg [15:0] sum;     // 16-bit sum
        integer i;          // loop index
    begin
        carry = 0;          // Initialize carry to 0
        sum = 16'b0;        // Initialize sum to 0
        for (i = 0; i < 16; i = i + 1) begin
            sum[i] = A[i] ^ B[i] ^ carry;  // Compute sum bit by bit
            carry = (A[i] & B[i]) | ((A[i] ^ B[i]) & carry);  // Update carry
        end
        Add = sum;          // Return the computed sum
    end
    endfunction

    // Assign the result of the Add function to output C
    assign C = Add(A, B);

endmodule
