module frogger (
    input wire clk,
    input wire reset,
    input wire switch1,  // Move up
    input wire switch2,  // Move down
    input wire switch3,  // Move left
    input wire switch4,  // Move right
    output wire [2:0] red,    // VGA red output
    output wire [2:0] green,  // VGA green output
    output wire [2:0] blue,   // VGA blue output
    output wire hsync,        // VGA horizontal sync
    output wire vsync         // VGA vertical sync
);

    // Internal registers for frog's position
    wire [9:0] frog_x;
    wire [9:0] frog_y;

    // Instantiate the frog module
    frog frog_instance (
        .clk(clk),
        .reset(reset),
        .switch1(switch1),
        .switch2(switch2),
        .switch3(switch3),
        .switch4(switch4),
        .frog_x(frog_x),
        .frog_y(frog_y)
    );

    // Instantiate the VGA controller and pass the frog's position
    vga_controller vga_instance (
        .clk(clk),
        .frog_x(frog_x),    // Pass frog's horizontal position
        .frog_y(frog_y),    // Pass frog's vertical position
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync)
    );

endmodule
