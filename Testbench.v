`timescale 1ns/1ps

module Testbench;

  // Parameter definitions
  parameter number_of_inputs  = 8;  // # input bits to your design.
  parameter number_of_outputs = 6;  // # output bits from your design.

  // DUT port declaration
  reg [number_of_inputs-1:0] input_vector;
  wire [number_of_outputs-1:0] output_vector;

  // Instantiate the DUT
  DUT dut_instance (
      .input_vector(input_vector),
      .output_vector(output_vector)
  );

  // File handling
  integer infile, outfile;
  reg [number_of_inputs-1:0] input_vector_var;
  reg [number_of_outputs-1:0] output_vector_var;
  reg [number_of_outputs-1:0] output_mask_var;

  // Line count for error reporting
  integer line_count;
  reg err_flag;

  initial begin
    err_flag = 0;
    line_count = 0;

    // Open files
    infile = $fopen("TRACEFILE.txt", "r");
    outfile = $fopen("outputs.txt", "w");

    // Check if the file opened successfully
    if (infile == 0) begin
      $display("Error opening TRACEFILE.txt");
      $finish;
    end

    // Main simulation loop
    while (!$feof(infile)) begin
      // Increment line count
      line_count = line_count + 1;

      // Read input vector, output vector, and output mask from the file
      $fscanf(infile, "%b %b %b\n", input_vector_var, output_vector_var, output_mask_var);
      
      // Apply input
      input_vector = input_vector_var;

      // Wait for circuit to settle
      #10;

      // Check output
      if ((output_vector & output_mask_var) != (output_vector_var & output_mask_var)) begin
        $fwrite(outfile, "ERROR: line %0d\n", line_count);
        err_flag = 1;
      end

      // Write inputs and outputs to the output file
      $fwrite(outfile, "%b %b\n", input_vector, output_vector);
      
      // Advance time by 4 ns
      #4;
    end

    // Close the files
    $fclose(infile);
    $fclose(outfile);

    // Final report
    if (err_flag) begin
      $display("FAILURE, some tests failed.");
      $finish;
    end else begin
      $display("SUCCESS, all tests passed.");
      $finish;
    end
  end

endmodule
