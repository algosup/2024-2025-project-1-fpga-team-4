module vga_controller (
    input wire clk,
    input wire [9:0] frog_x,  // Frog's horizontal position
    input wire [9:0] frog_y,  // Frog's vertical position
    input wire [1:0] frog_direction, // Frog's direction
    input wire [9:0] car_x_0,  // Car positions
    input wire [9:0] car_y_0,
    input wire [9:0] car_x_1,
    input wire [9:0] car_y_1,
    input wire [9:0] car_x_2,
    input wire [9:0] car_y_2,
    input wire [9:0] car_x_3,
    input wire [9:0] car_y_3,
    input wire [9:0] car_x_4,
    input wire [9:0] car_y_4,
    input wire [9:0] car_x_5,
    input wire [9:0] car_y_5,
    input wire [9:0] car_x_6,
    input wire [9:0] car_y_6,
    input wire [9:0] car_x_7,
    input wire [9:0] car_y_7,
    input wire [9:0] car_x_8,  
    input wire [9:0] car_y_8,
    input wire [9:0] car_x_9,
    input wire [9:0] car_y_9,
    input wire [9:0] car_x_10,
    input wire [9:0] car_y_10,
    input wire [3:0] current_level, // Current game level
    output reg [2:0] red,    // VGA red output
    output reg [2:0] green,  // VGA green output
    output reg [2:0] blue,   // VGA blue output
    output wire hsync,        // VGA horizontal sync
    output wire vsync         // VGA vertical sync
);

    localparam H_DISPLAY = 640;
    localparam V_DISPLAY = 480;
    localparam CAR_SIZE = 32;
    localparam FROG_SIZE = 32;
    localparam GRID_WIDTH = 32;
    localparam GRID_HEIGHT = 32;

    reg [9:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    // Horizontal and vertical sync signals
    assign hsync = (h_counter >= (H_DISPLAY + 16) && h_counter < (H_DISPLAY + 16 + 96));
    assign vsync = (v_counter >= (V_DISPLAY + 10) && v_counter < (V_DISPLAY + 10 + 2));

    // Instantiate frog sprite renderer
    wire [2:0] bg_r, bg_g, bg_b;

    wire [5:0] frog_pixel_data;
    wire [4:0] sprite_x = (h_counter - frog_x) % GRID_WIDTH;
    wire [4:0] sprite_y = (v_counter - frog_y) % GRID_HEIGHT;


    FrogSpriteBram frog_bram_inst (
        .clk(clk),
        .sprite_x(sprite_x),
        .sprite_y(sprite_y),
        .direction(frog_direction), // Pass the frog's direction
        .pixel_data(frog_pixel_data)
    );
    
    // Instantiate car sprite BRAM renderers
    wire [5:0] blue_car_pixel_data;
    wire [5:0] orange_car_pixel_data;

    BlueCarSpriteBram blue_car_bram (
        .clk(clk),
        .sprite_x(h_counter[4:0]),
        .sprite_y(v_counter[4:0]),
        .pixel_data(blue_car_pixel_data)
    );

    OrangeCarSpriteBram orange_car_bram (
        .clk(clk),
        .sprite_x(h_counter[4:0]),
        .sprite_y(v_counter[4:0]),
        .pixel_data(orange_car_pixel_data)
    );

    Background bg_inst (
        .clk(clk),
        .h_count(h_counter),
        .v_count(v_counter),
        .bg_r(bg_r),
        .bg_g(bg_g),
        .bg_b(bg_b)
    );

    // Horizontal and vertical counters
    always @(posedge clk) begin
        if (h_counter == H_DISPLAY + 16 + 96 + 48 - 1) begin
            h_counter <= 0;
            if (v_counter == V_DISPLAY + 10 + 2 + 33 - 1) begin
                v_counter <= 0;
            end else begin
                v_counter <= v_counter + 1;
            end
        end else begin
            h_counter <= h_counter + 1;
        end
    end

    // Display logic
    always @(*) begin
        // Default to background
        red = bg_r;
        green = bg_g;
        blue = bg_b;

        // Draw frog sprite 
            if ((h_counter >= frog_x) && (h_counter < (frog_x + FROG_SIZE)) &&
                (v_counter >= frog_y) && (v_counter < (frog_y + FROG_SIZE)) && 
                frog_pixel_data != 6'b000000) begin
                red = {frog_pixel_data[5:4], 1'b0};  // Red
                green = {frog_pixel_data[3:2], 1'b0};  // Green
                blue = {frog_pixel_data[1:0], 1'b0};  // Blue
            end
        // Draw car sprites (from car BRAM)
        else if (((h_counter >= car_x_1 && h_counter < car_x_1 + CAR_SIZE) && (v_counter >= car_y_1 && v_counter < car_y_1 + CAR_SIZE)) ||
                 ((h_counter >= car_x_3 && h_counter < car_x_3 + CAR_SIZE) && (v_counter >= car_y_3 && v_counter < car_y_3 + CAR_SIZE)) ||
                 ((h_counter >= car_x_5 && h_counter < car_x_5 + CAR_SIZE) && (v_counter >= car_y_5 && v_counter < car_y_5 + CAR_SIZE)) ||
                 ((h_counter >= car_x_7 && h_counter < car_x_7 + CAR_SIZE) && (v_counter >= car_y_7 && v_counter < car_y_7 + CAR_SIZE)) ||
                 ((h_counter >= car_x_9 && h_counter < car_x_9 + CAR_SIZE) && (v_counter >= car_y_9 && v_counter < car_y_9 + CAR_SIZE)) ||
                 ((h_counter >= car_x_10 && h_counter < car_x_10 + CAR_SIZE) && (v_counter >= car_y_10 && v_counter < car_y_10 + CAR_SIZE))) begin
            if (blue_car_pixel_data != 6'b000000) begin
                red = {blue_car_pixel_data[5:4], 1'b0};
                green = {blue_car_pixel_data[3:2], 1'b0};
                blue = {blue_car_pixel_data[1:0], 1'b0};
            end
        end else if (((h_counter >= car_x_0 && h_counter < car_x_0 + CAR_SIZE) && (v_counter >= car_y_0 && v_counter < car_y_0 + CAR_SIZE)) ||
                 ((h_counter >= car_x_2 && h_counter < car_x_2 + CAR_SIZE) && (v_counter >= car_y_2 && v_counter < car_y_2 + CAR_SIZE)) ||
                 ((h_counter >= car_x_4 && h_counter < car_x_4 + CAR_SIZE) && (v_counter >= car_y_4 && v_counter < car_y_4 + CAR_SIZE)) ||
                 ((h_counter >= car_x_6 && h_counter < car_x_6 + CAR_SIZE) && (v_counter >= car_y_6 && v_counter < car_y_6 + CAR_SIZE)) ||
                 ((h_counter >= car_x_8 && h_counter < car_x_8 + CAR_SIZE) && (v_counter >= car_y_8 && v_counter < car_y_8 + CAR_SIZE))) begin
            if (orange_car_pixel_data != 6'b000000) begin
                red = {orange_car_pixel_data[5:4], 1'b0};
                green = {orange_car_pixel_data[3:2], 1'b0};
                blue = {orange_car_pixel_data[1:0], 1'b0};
            end
        end
    end

endmodule
