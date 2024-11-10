module Reg_File (
    input [2:0] Address_Read1,
    input [2:0] Address_Read2,
    input [2:0] Address_Write,
    input [15:0] data_Write,
    input [15:0] PC_data_input,
    output reg [15:0] PC_data_output,
    input clk,
    input reset,
    input RF_Write,
    input PC_Write,
    output reg [15:0] data_Read1,
    output reg [15:0] data_Read2
);

    reg [15:0] R0 = 16'b0000000000000000;
    reg [15:0] R1 = 16'b0000000000000000;
    reg [15:0] R2 = 16'b0000000000000000;
    reg [15:0] R3 = 16'b0000000000000000;
    reg [15:0] R4 = 16'b0000000000000000;
    reg [15:0] R5 = 16'b0000000000000000;
    reg [15:0] R6 = 16'b0000000000000000;
    reg [15:0] R7 = 16'b0000000000000000;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            R0 <= 16'b0000000000000010;
            R1 <= 16'b0000000000000100;
            R2 <= 16'b0000000000000111;
            R3 <= 16'b0000000000001000;
            R4 <= 16'b0000000000001001;
            R5 <= 16'b0000000000001100;
            R6 <= 16'b0000000000001101;
            R7 <= 16'b0000000000000101;
        end else begin
            if (PC_Write) begin
                R0 <= PC_data_input;
            end

            if (RF_Write) begin
                case (Address_Write)
                    3'b001: R1 <= data_Write;
                    3'b010: R2 <= data_Write;
                    3'b011: R3 <= data_Write;
                    3'b100: R4 <= data_Write;
                    3'b101: R5 <= data_Write;
                    3'b110: R6 <= data_Write;
                    3'b111: R7 <= data_Write;
                    default: ; // Do nothing
                endcase
            end
        end
    end

    always @(*) begin
        case (Address_Read1)
            3'b000: data_Read1 = R0;
            3'b001: data_Read1 = R1;
            3'b010: data_Read1 = R2;
            3'b011: data_Read1 = R3;
            3'b100: data_Read1 = R4;
            3'b101: data_Read1 = R5;
            3'b110: data_Read1 = R6;
            3'b111: data_Read1 = R7;
            default: data_Read1 = 16'b0; // Default case to avoid latch
        endcase
    end

    always @(*) begin
        case (Address_Read2)
            3'b000: data_Read2 = R0;
            3'b001: data_Read2 = R1;
            3'b010: data_Read2 = R2;
            3'b011: data_Read2 = R3;
            3'b100: data_Read2 = R4;
            3'b101: data_Read2 = R5;
            3'b110: data_Read2 = R6;
            3'b111: data_Read2 = R7;
            default: data_Read2 = 16'b0; // Default case to avoid latch
        endcase
    end

    always @(*) begin
        PC_data_output = R0;
    end

endmodule
