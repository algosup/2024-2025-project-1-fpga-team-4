module frogger (
    input wire clk,  // Main clock input
    output wire hsync,  // Horizontal sync signal
    output wire vsync,  // Vertical sync signal
    output wire [2:0] red,  // Red signal (3 bits)
    output wire [2:0] green,  // Green signal (3 bits)
    output wire [2:0] blue  // Blue signal (3 bits)
);

    // Instantiate the VGA controller
    vga_controller vga_ctrl_inst (
        .clk(clk),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );

endmodule