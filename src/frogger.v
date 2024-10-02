module frogger (
    input wire clk,
    input wire reset,
    input wire switch1,   // Move up
    input wire switch2,   // Move down
    input wire switch3,   // Move left
    input wire switch4,   // Move right
    output wire [2:0] red,
    output wire [2:0] green,
    output wire [2:0] blue,
    output wire hsync,
    output wire vsync
);

    wire [9:0] frog_x;
    wire [9:0] frog_y;

    // Instantiate the frog movement controller
    frog frog_inst (
        .clk(clk),
        .reset(reset),
        .switch1(switch1),
        .switch2(switch2),
        .switch3(switch3),
        .switch4(switch4),
        .frog_x(frog_x),
        .frog_y(frog_y)
    );

    // Instantiate the VGA controller
    wire [9:0] car_x1, car_y1, car_x2, car_y2, car_x3, car_y3, car_x4, car_y4, car_x5, car_y5;
    wire [9:0] car_x6, car_y6, car_x7, car_y7, car_x8, car_y8, car_x9, car_y9, car_x10, car_y10;

    vga_controller vga_inst (
        .clk(clk),
        .frog_x(frog_x),      // Pass frog's horizontal position
        .frog_y(frog_y),      // Pass frog's vertical position
        .car_x1(car_x1),      // Car positions
        .car_y1(car_y1),
        .car_x2(car_x2),
        .car_y2(car_y2),
        .car_x3(car_x3),
        .car_y3(car_y3),
        .car_x4(car_x4),
        .car_y4(car_y4),
        .car_x5(car_x5),
        .car_y5(car_y5),
        .car_x6(car_x6),
        .car_y6(car_y6),
        .car_x7(car_x7),
        .car_y7(car_y7),
        .car_x8(car_x8),
        .car_y8(car_y8),
        .car_x9(car_x9),
        .car_y9(car_y9),
        .car_x10(car_x10),
        .car_y10(car_y10),
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync)
    );

    // Instantiate 10 cars with different initial positions and directions
    car car1 (.clk(clk), .reset(reset), .direction(0), .car_x(car_x1), .car_y(car_y1), .start_x(0), .start_y(96));
    car car2 (.clk(clk), .reset(reset), .direction(1), .car_x(car_x2), .car_y(car_y2), .start_x(640), .start_y(128));
    car car3 (.clk(clk), .reset(reset), .direction(0), .car_x(car_x3), .car_y(car_y3), .start_x(0), .start_y(160));
    car car4 (.clk(clk), .reset(reset), .direction(1), .car_x(car_x4), .car_y(car_y4), .start_x(640), .start_y(192));
    car car5 (.clk(clk), .reset(reset), .direction(0), .car_x(car_x5), .car_y(car_y5), .start_x(0), .start_y(224));
    car car6 (.clk(clk), .reset(reset), .direction(1), .car_x(car_x6), .car_y(car_y6), .start_x(640), .start_y(256));
    car car7 (.clk(clk), .reset(reset), .direction(0), .car_x(car_x7), .car_y(car_y7), .start_x(0), .start_y(288));
    car car8 (.clk(clk), .reset(reset), .direction(1), .car_x(car_x8), .car_y(car_y8), .start_x(640), .start_y(320));
    car car9 (.clk(clk), .reset(reset), .direction(0), .car_x(car_x9), .car_y(car_y9), .start_x(0), .start_y(352));
    car car10 (.clk(clk), .reset(reset), .direction(1), .car_x(car_x10), .car_y(car_y10), .start_x(640), .start_y(384));

endmodule
