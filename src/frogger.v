module frogger (
    input wire clk,
    input wire switch1,   // Move up
    input wire switch2,   // Move down
    input wire switch3,   // Move left
    input wire switch4,   // Move right
    output wire [6:0] o_Segment2,
    output wire [2:0] red,
    output wire [2:0] green,
    output wire [2:0] blue,
    output wire hsync,
    output wire vsync
);

    reg [6:0] current_level = 0;

    wire [9:0] frog_x;
    wire [9:0] frog_y;
    wire death_collision;
    wire win_collision;
    wire reset;
    wire win;

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
    wire [9:0] car_x1, car_y1;

    vga_controller vga_inst (
        .clk(clk),
        .frog_x(frog_x),      // Pass frog's horizontal position
        .frog_y(frog_y),      // Pass frog's vertical position
        .car_x1(car_x1),      // Car positions
        .car_y1(car_y1),
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync)
    );

    collisions test_collision (
        .frog_x(frog_x),
        .frog_y(frog_y),
        .car_x1(car_x1),
        .car_y1(car_y1),
        .death_collision(death_collision),
        .win_collision(win_collision)
    );

    always @(posedge win)begin
        current_level <= current_level + 1;
        if (current_level > 8)begin
            current_level <= 0;
        end
    end

    display_numbers first_number(
        .current(current_level),
        .o_Segment(o_Segment2));

    assign win=(win_collision);
    assign reset=(death_collision | win_collision | (switch1 && switch2 && switch3 && switch4));

    car car1 (.clk(clk), .reset(reset), .direction(0), .car_x(car_x1), .car_y(car_y1), .start_x(0), .start_y(96));
endmodule
