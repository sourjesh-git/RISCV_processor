module ALU1(
    input [15:0] A, B,
    input [3:0] Oper,
    output Z,
    output R,
    output [15:0] C
);

    reg [15:0] DATA1_temp;
    reg R1;

    // Function to add two 16-bit numbers
    function [15:0] Add;
        input [15:0] A, B;
        reg carry;
        integer i;
        begin
            carry = 0;
            Add = 16'b0;
            for (i = 0; i < 16; i = i + 1) begin
                Add[i] = A[i] ^ B[i] ^ carry;
                carry = (A[i] & B[i]) | ((A[i] ^ B[i]) & carry);
            end
        end
    endfunction

    // Function to subtract two 16-bit numbers
    function [15:0] Sub;
        input [15:0] A, B;
        reg borrow;
        integer i;
        begin
            borrow = 0;
            Sub = 16'b0;
            for (i = 0; i < 16; i = i + 1) begin
                Sub[i] = A[i] ^ B[i] ^ borrow;
                borrow = ((~A[i]) & B[i]) | (((~A[i]) | B[i]) & borrow);
            end
        end
    endfunction

    // Function to perform bitwise NAND
    function [15:0] bit_NAND;
        input [15:0] A, B;
        integer i;
        begin
            bit_NAND = 16'b0;
            for (i = 0; i < 16; i = i + 1) begin
                bit_NAND[i] = ~(A[i] & B[i]);
            end
        end
    endfunction

    // Function to calculate carry after subtraction
    function SubCARRY;
        input [15:0] A, B;
        reg borrow;
        reg [15:0] diff;
        integer i;
        begin
            borrow = 0;
            diff = 16'b0;
            for (i = 0; i < 16; i = i + 1) begin
                diff[i] = A[i] ^ B[i] ^ borrow;
                borrow = ((~A[i]) & B[i]) | (((~A[i]) | B[i]) & borrow);
            end
            SubCARRY = borrow;
        end
    endfunction

    // Main logic based on 'Oper' input
    always @(*) begin
        case (Oper)
            4'b1100: begin
                DATA1_temp = Add(A, B);
                R1 = 0;
            end
            4'b1101: begin
                DATA1_temp = Add(A, B);
                R1 = 0;
            end
            4'b1000: begin
                DATA1_temp = Sub(A, B);
                R1 = SubCARRY(A, B);
            end
            4'b1001: begin
                DATA1_temp = Sub(A, B);
                R1 = SubCARRY(A, B);
            end
            4'b1010: begin
                DATA1_temp = Sub(A, B);
                R1 = SubCARRY(A, B);
            end
            4'b0010: begin
                DATA1_temp = bit_NAND(A, B);
                R1 = 0;
            end
            default: begin
                DATA1_temp = 16'b0;
                R1 = 0;
            end
        endcase
    end

    // Set outputs
    assign Z = ~(DATA1_temp[0] | DATA1_temp[1] | DATA1_temp[2] | DATA1_temp[3] |
                 DATA1_temp[4] | DATA1_temp[5] | DATA1_temp[6] | DATA1_temp[7] |
                 DATA1_temp[8] | DATA1_temp[9] | DATA1_temp[10] | DATA1_temp[11] |
                 DATA1_temp[12] | DATA1_temp[13] | DATA1_temp[14] | DATA1_temp[15]);
    assign C = DATA1_temp;
    assign R = R1;

endmodule
