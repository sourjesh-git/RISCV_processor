module IITB_CPU_Pipeline (
    input Clk,
    input Reset
);

// ALU1 component definition
module ALU1 (
    input [15:0] A,
    input [15:0] B,
    input [3:0] Oper,
    output Z,
    output R,
    output [15:0] C
);
endmodule

// ALU2 component definition
module ALU2 (
    input [15:0] A,
    input [15:0] B,
    output [15:0] C
);
endmodule

// ALU3 component definition
module ALU3 (
    input [15:0] A,
    input [15:0] B,
    input C,
    output Z,
    output R,
    output [15:0] D
);
endmodule

// Register128bit component definition
module Register128bit (
    input Clk,
    input Reset,
    input [127:0] data_in,
    input Stallbar,
    output [127:0] data_out,
    output valid_bit
);
endmodule

// Reg_File component definition
module Reg_File (
    input [2:0] Address_Read1,
    input [2:0] Address_Read2,
    input [2:0] Address_Write,
    input [15:0] data_Write,
    input [15:0] PC_data_input,
    output [15:0] PC_data_output,
    input Clk,
    input Reset,
    input RF_Write,
    input PC_Write,
    output [15:0] data_Read1,
    output [15:0] data_Read2
);
endmodule

// three_bit_sync_up component definition
module three_bit_sync_up (
    input clk,
    input reset,
    output [2:0] Count,
    output [2:0] CountBar,
    input enable
);
endmodule

// InstructionMemory component definition
module InstructionMemory (
    input [15:0] Address,
    output [15:0] data_out
);
endmodule

// DataMemory component definition
module DataMemory (
    input [15:0] Address,
    input [15:0] data_write,
    output [15:0] data_out
);
endmodule

// Internal signal declarations
wire [15:0] PC_out, data_Read1, data_Read2, ALU1_out, ALU2_out, ALU3_out, instruction;
wire Z_ALU1, R_ALU1, Z_ALU3, R_ALU3;

// Instantiate Register File
Reg_File rf_inst (
    .Address_Read1(Address_Read1),
    .Address_Read2(Address_Read2),
    .Address_Write(Address_Write),
    .data_Write(data_Write),
    .PC_data_input(PC_data_input),
    .PC_data_output(PC_out),
    .Clk(Clk),
    .Reset(Reset),
    .RF_Write(RF_Write),
    .PC_Write(PC_Write),
    .data_Read1(data_Read1),
    .data_Read2(data_Read2)
);

// Instantiate ALU1
ALU1 alu1_inst (
    .A(data_Read1),
    .B(data_Read2),
    .Oper(Oper1),
    .Z(Z_ALU1),
    .R(R_ALU1),
    .C(ALU1_out)
);

// Instantiate ALU2
ALU2 alu2_inst (
    .A(data_Read1),
    .B(data_Read2),
    .C(ALU2_out)
);

// Instantiate ALU3
ALU3 alu3_inst (
    .A(data_Read1),
    .B(data_Read2),
    .C(carry_in),
    .Z(Z_ALU3),
    .R(R_ALU3),
    .D(ALU3_out)
);

// Instantiate Instruction Memory
InstructionMemory inst_mem_inst (
    .Address(PC_out),
    .data_out(instruction)
);

// Instantiate Data Memory
DataMemory data_mem_inst (
    .Address(data_mem_address),
    .data_write(data_mem_write_data),
    .data_out(data_mem_read_data)
);

// Additional pipeline registers and control logic would be connected here based on the VHDL architecture

endmodule
