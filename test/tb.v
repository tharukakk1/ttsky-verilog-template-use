`default_nettype none
`timescale 1ns / 1ps

// /* This testbench just instantiates the module and makes some convenient wires
//    that can be driven / tested by the cocotb test.py.
// */
// module tb ();

//   // Dump the signals to a FST file. You can view it with gtkwave or surfer.
//   initial begin
//     $dumpfile("tb.fst");
//     $dumpvars(0, tb);
//     #1;
//   end

//   // Wire up the inputs and outputs:
//   reg clk;
//   reg rst_n;
//   reg ena;
//   reg [7:0] ui_in;
//   reg [7:0] uio_in;
//   wire [7:0] uo_out;
//   wire [7:0] uio_out;
//   wire [7:0] uio_oe;
// `ifdef GL_TEST
//   wire VPWR = 1'b1;
//   wire VGND = 1'b0;
// `endif

//   // Replace tt_um_example with your module name:
//   tt_um_tharukakk1 user_project (

//       // Include power ports for the Gate Level test:
// `ifdef GL_TEST
//       .VPWR(VPWR),
//       .VGND(VGND),
// `endif

//       .ui_in  (ui_in),    // Dedicated inputs
//       .uo_out (uo_out),   // Dedicated outputs
//       .uio_in (uio_in),   // IOs: Input path
//       .uio_out(uio_out),  // IOs: Output path
//       .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
//       .ena    (ena),      // enable - goes high when design is selected
//       .clk    (clk),      // clock
//       .rst_n  (rst_n)     // not reset
//   );

// endmodule

module tb;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg clk;
    reg rst_n;
    reg ena;

    // Instantiate the design
    tt_um_tharukakk1 dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Test variables
    integer i, j;
    reg [8:0] expected;
    integer errors = 0;

    initial begin
        // Initialize inputs
        ui_in = 0;
        uio_in = 0;
        clk = 0;
        rst_n = 1;
        ena = 1;

        $display("Starting Full Adder Testbench...");

        // Exhaustive test for 8-bit addition
        for (i = 0; i < 256; i = i + 16) begin
            for (j = 0; j < 256; j = j + 16) begin
                ui_in = i;
                uio_in = j;
                expected = i + j;
                
                #10; // Wait for combinational logic to settle

                if (uo_out !== expected[7:0] || uio_out[0] !== expected[8]) begin
                    $display("ERROR: %d + %d = %d (Expected %d)", ui_in, uio_in, {uio_out[0], uo_out}, expected);
                    errors = errors + 1;
                end
            end
        end

        // Final Report
        if (errors == 0) begin
            $display("---------------------------------------");
            $display("TEST PASSED: All additions were correct.");
            $display("---------------------------------------");
        end else begin
            $display("---------------------------------------");
            $display("TEST FAILED: %d errors detected.", errors);
            $display("---------------------------------------");
        end
        
        $finish;
    end
    // comment to trigger gh actions
endmodule
