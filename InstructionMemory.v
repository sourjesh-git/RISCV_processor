module InstructionMemory (
    input [15:0] Address,
    output reg [15:0] data_out
);

    reg [7:0] memory_storage [255:0];

    initial begin
        memory_storage[0] = 8'b11100000;
        memory_storage[2] = 8'b01110010;
        memory_storage[3] = 8'b01011001;
        // Initialize other memory locations to zero
        integer i;
        for (i = 1; i < 256; i = i + 1) begin
            if (i != 2 && i != 3)
                memory_storage[i] = 8'b00000000;
        end
    end

    always @(*) begin
        if (Address < 256) begin
            data_out[15:8] = memory_storage[Address];
            data_out[7:0] = memory_storage[Address + 1];
        end else begin
            data_out = 16'b0;
        end
    end

endmodule
