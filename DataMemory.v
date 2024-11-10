module DataMemory (
    input [15:0] Address,         // 16-bit address
    input [15:0] data_write,      // 16-bit data input for write operations
    output reg [15:0] data_out,   // 16-bit data output
    input clock,                  // clock signal
    input MeM_W,                  // memory write enable
    input MeM_R                   // memory read enable
);

    // Define memory storage array (64 x 8 bits)
    reg [7:0] memory_storage [0:63];

    // Initialize memory with some values, others default to 0
    initial begin
        memory_storage[0] = 8'b00000000;
        memory_storage[1] = 8'b00000010;
        // Initialize remaining memory cells to 0
        integer i;
        for (i = 2; i < 64; i = i + 1) begin
            memory_storage[i] = 8'b00000000;
        end
    end

    // Memory write process (on clock edge)
    always @(posedge clock) begin
        if (MeM_W == 1'b1) begin
            // Write high byte
            memory_storage[Address] <= data_write[15:8];
            // Write low byte
            memory_storage[Address + 1] <= data_write[7:0];
        end
    end

    // Memory read process (combinational)
    always @(*) begin
        if (MeM_R == 1'b1) begin
            if (Address < 63) begin
                // Read high byte
                data_out[15:8] = memory_storage[Address];
                // Read low byte
                data_out[7:0] = memory_storage[Address + 1];
            end else begin
                // Address out of bounds, return zero
                data_out = 16'b0;
            end
        end
    end

endmodule
