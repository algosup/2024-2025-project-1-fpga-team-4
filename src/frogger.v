module frogger (
    input wire clk,
    output wire led,
    input wire led,
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
    wire [9:0] frog_x2;
    wire [9:0] frog_y2;
    wire death_collision;
    wire win_collision;
    wire reset;


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

        // Instantiate the frog module
    test_frog frog_test (
        .clk(clk),
        .reset(reset),
        .switch1(switch1),
        .switch2(switch2),
        .switch3(switch3),
        .switch4(switch4),
        .frog_x(frog_x2),
        .frog_y(frog_y2)
    );

    // Instantiate the VGA controller and pass the frog's position
    vga_controller vga_instance (
        .clk(clk),
        .led(led),
        .frog_x(frog_x),    // Pass frog's horizontal position
        .frog_y(frog_y),    // Pass frog's vertical position
        .frog_x2(frog_x2),
        .frog_y2(frog_y2),
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync)
    );

    collisions test_collision (
        .frog_x(frog_x),
        .frog_y(frog_y),
        .frog_x2(frog_x2),
        .frog_y2(frog_y2),
        .death_collision(death_collision),
        .win_collision(win_collision)
    );

    assign reset=(death_collision | win_collision | (switch1 && switch2 && switch3 && switch4));


endmodule
