module TopLevel (
    output [4:0] state_out
    // Connect to Krypton pins or other relevant pins here
);

    // Constant parameters
    localparam number_of_inputs = 8;   // # input bits to your design
    localparam number_of_outputs = 6;  // # output bits from your design

    // Internal signals
    wire [7:0] reg_data;
    wire [number_of_inputs-1:0] data, dut_input;
    wire [number_of_outputs-1:0] dut_output, datau;
    wire cdr, sdr, udr, e1dr, e2dr, tck, tms, jsdr, jsir;
    reg io = 1'b0;

    // Alternate input and output every cycle
    always @(posedge tck) begin
        if (udr == 1'b1) begin
            io <= ~io;  // 1 = output, 0 = input
        end
    end

    // Read data from or write data to internal scan chain depending on io
    always @(posedge tck) begin
        // Shift input
        if (sdr == 1'b1 && udr == 1'b0 && io == 1'b0) begin
            if (number_of_inputs > 1) begin
                data <= {reg_data[0], data[number_of_inputs-1:1]};
            end else begin
                data[0] <= reg_data[0];
            end
        end

        // Shift output
        if (sdr == 1'b1 && udr == 1'b0 && io == 1'b1) begin
            if (number_of_outputs > 1) begin
                datau <= {1'b0, datau[number_of_outputs-1:1]};
            end else begin
                datau <= 1'b0;
            end
        end

        // Capture input
        if (udr == 1'b1 && sdr == 1'b0 && io == 1'b0) begin
            dut_input <= data;
        end

        // Capture output
        if (cdr == 1'b1 && sdr == 1'b0 && io == 1'b1) begin
            datau <= dut_output;
        end
    end

    // Instantiate v_jtag component
    v_jtag u0 (
        .virtual_jtag_tdi                (reg_data[0]),
        .virtual_jtag_tdo                (datau[0]),
        .virtual_jtag_ir_in              (reg_data[7]),
        .virtual_jtag_ir_out             (),
        .virtual_jtag_virtual_state_cdr  (cdr),
        .virtual_jtag_virtual_state_sdr  (sdr),
        .virtual_jtag_virtual_state_e1dr (e1dr),
        .virtual_jtag_virtual_state_pdr  (),
        .virtual_jtag_virtual_state_e2dr (e2dr),
        .virtual_jtag_virtual_state_udr  (udr),
        .virtual_jtag_virtual_state_cir  (),
        .virtual_jtag_virtual_state_uir  (),
        .virtual_jtag_tms                (tms),
        .virtual_jtag_jtag_state_tlr     (),
        .virtual_jtag_jtag_state_rti     (),
        .virtual_jtag_jtag_state_sdrs    (),
        .virtual_jtag_jtag_state_cdr     (),
        .virtual_jtag_jtag_state_sdr     (),
        .virtual_jtag_jtag_state_e1dr    (jsdr),
        .virtual_jtag_jtag_state_pdr     (),
        .virtual_jtag_jtag_state_e2dr    (),
        .virtual_jtag_jtag_state_udr     (),
        .virtual_jtag_jtag_state_sirs    (),
        .virtual_jtag_jtag_state_cir     (),
        .virtual_jtag_jtag_state_sir     (),
        .virtual_jtag_jtag_state_e1ir    (jsir),
        .virtual_jtag_jtag_state_pir     (),
        .virtual_jtag_jtag_state_e2ir    (),
        .virtual_jtag_jtag_state_uir     (),
        .tck_clk                         (tck)
    );

    // Instantiate DUT component and connect signals
    DUT dut_instance (
        .input_vector(dut_input),
        .output_vector(dut_output)
    );

    // Output state for confirming correct design in Krypton
    assign state_out = {jsdr, cdr, sdr, udr, dut_output[number_of_outputs-1]};

endmodule
