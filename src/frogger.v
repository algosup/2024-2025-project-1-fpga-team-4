module frogger (
    input wire clk,
    input wire switch1,   // Move up
    input wire switch2,   // Move down
    input wire switch3,   // Move left
    input wire switch4,   // Move right
    output wire [6:0] o_Segment2,
    output wire [6:0] o_Segment1,
    output wire [2:0] red,
    output wire [2:0] green,
    output wire [2:0] blue,
    output wire hsync,
    output wire vsync
);

    reg [3:0] current_level = 0;
    wire [9:0] frog_x;
    wire [9:0] frog_y;
    wire [1:0] frog_direction;
    wire death_collision;
    wire win_collision;
    wire win;
    wire reset = death_collision | win_collision;

    // Define car position signals
    wire [9:0] car_x_0, car_y_0;
    wire [9:0] car_x_1, car_y_1;
    wire [9:0] car_x_2, car_y_2;
    wire [9:0] car_x_3, car_y_3;
    wire [9:0] car_x_4, car_y_4;
    wire [9:0] car_x_5, car_y_5;
    wire [9:0] car_x_6, car_y_6;
    wire [9:0] car_x_7, car_y_7;
    wire [9:0] car_x_8, car_y_8;

    // Instantiate the frog movement controller
    frog frog_instance (
        .clk(clk),
        .reset(reset),
        .switch1(switch1),
        .switch2(switch2),
        .switch3(switch3),
        .switch4(switch4),
        .frog_x(frog_x),
        .frog_y(frog_y),
        .frog_direction(frog_direction)
    );

    // Instantiate the VGA controller
    vga_controller vga_inst (
        .clk(clk),
        .frog_x(frog_x),      // Pass frog's horizontal position
        .frog_y(frog_y),      // Pass frog's vertical position
        .frog_direction(frog_direction),
        .car_x_0(car_x_0),
        .car_y_0(car_y_0),
        .car_x_1(car_x_1),
        .car_y_1(car_y_1),
        .car_x_2(car_x_2),
        .car_y_2(car_y_2),
        .car_x_3(car_x_3),
        .car_y_3(car_y_3),
        .car_x_4(car_x_4),
        .car_y_4(car_y_4),
        .car_x_5(car_x_5),
        .car_y_5(car_y_5),
        .car_x_6(car_x_6),
        .car_y_6(car_y_6),
        .car_x_7(car_x_7),
        .car_y_7(car_y_7),
        .current_level(current_level),
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync)
    );

    // Instantiate collisions module
    collisions test_collision (
        .frog_x(frog_x),
        .frog_y(frog_y),
        .car_x_0(car_x_0),
        .car_y_0(car_y_0),
        .car_x_1(car_x_1),
        .car_y_1(car_y_1),
        .car_x_2(car_x_2),
        .car_y_2(car_y_2),
        .car_x_3(car_x_3),
        .car_y_3(car_y_3),
        .car_x_4(car_x_4),
        .car_y_4(car_y_4),
        .car_x_5(car_x_5),
        .car_y_5(car_y_5),
        .car_x_6(car_x_6),
        .car_y_6(car_y_6),
        .car_x_7(car_x_7),
        .car_y_7(car_y_7),
        .current_level(current_level),
        .death_collision(death_collision),
        .win_collision(win_collision)
    );

    // Instantiate cars explicitly
    car car_0 (
        .clk(clk),
        .reset(reset),
        .direction(0),
        .car_x(car_x_0),
        .car_y(car_y_0),
        .start_x(0),
        .start_y(352),
        .speed(6),
        .length(1)
    );
    car car_1 (
        .clk(clk),
        .reset(reset),
        .direction(1),
        .car_x(car_x_1),
        .car_y(car_y_1),
        .start_x(0),
        .start_y(320),
        .speed(5),
        .length(2)
    );
    car car_2 (
        .clk(clk),
        .reset(reset),
        .direction(0),
        .car_x(car_x_2),
        .car_y(car_y_2),
        .start_x(0),
        .start_y(288),
        .speed(5),
        .length(3)
    );
    car car_3 (
        .clk(clk),
        .reset(reset),
        .direction(1),
        .car_x(car_x_3),
        .car_y(car_y_3),
        .start_x(0),
        .start_y(220),
        .speed(4),
        .length(1)
    );
    car car_4 (
        .clk(clk),
        .reset(reset),
        .direction(0),
        .car_x(car_x_4),
        .car_y(car_y_4),
        .start_x(0),
        .start_y(192),
        .speed(4),
        .length(2)
    );
    car car_5 (
        .clk(clk),
        .reset(reset),
        .direction(1),
        .car_x(car_x_5),
        .car_y(car_y_5),
        .start_x(0),
        .start_y(96),
        .speed(3),
        .length(3)
    );
    car car_6 (
        .clk(clk),
        .reset(reset),
        .direction(0),
        .car_x(car_x_6),
        .car_y(car_y_6),
        .start_x(0),
        .start_y(64),
        .speed(3),
        .length(1)
    );
    car car_7 (
        .clk(clk),
        .reset(reset),
        .direction(1),
        .car_x(car_x_7),
        .car_y(car_y_7),
        .start_x(0),
        .start_y(32),
        .speed(2),
        .length(2)
    );

    // Increment level on win
    always @(posedge clk) begin
        if (win) begin
            current_level <= (current_level < 8) ? (current_level + 1) : 0;
        end
        if (death_collision) begin
            current_level <= 0;
        end
    end

    display_numbers first_number(
        .current(current_level),
        .o_Segment(o_Segment2)
    );

    assign o_Segment1 = (current_level < 8) ? 7'b1111111 : 7'b1000010;
    assign win = (win_collision);

endmodule
