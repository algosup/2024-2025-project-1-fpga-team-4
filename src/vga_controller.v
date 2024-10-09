module vga_controller (
    input wire clk,
    input wire [9:0] frog_x,  // Frog's horizontal position
    input wire [9:0] frog_y,  // Frog's vertical position
    input wire [9:0] car_x1,  // Car positions
    input wire [9:0] car_y1,
    input wire [9:0] car_x2,
    input wire [9:0] car_y2,
    input wire [9:0] car_x3,
    input wire [9:0] car_y3,
    input wire [9:0] car_x4,
    input wire [9:0] car_y4,
    input wire [9:0] car_x5,
    input wire [9:0] car_y5,
    input wire [9:0] car_x6,
    input wire [9:0] car_y6,
    input wire [9:0] car_x7,
    input wire [9:0] car_y7,
    input wire [9:0] car_x8,
    input wire [9:0] car_y8,
    input wire [9:0] car_x9,
    input wire [9:0] car_y9,
    input wire [9:0] car_x10,
    input wire [9:0] car_y10,
    output reg [2:0] red,    // VGA red output
    output reg [2:0] green,  // VGA green output
    output reg [2:0] blue,   // VGA blue output
    output wire hsync,        // VGA horizontal sync
    output wire vsync         // VGA vertical sync
);

    localparam H_DISPLAY = 640;
    localparam V_DISPLAY = 480;
    localparam GRID_SIZE = 32;
    localparam CAR_SIZE = 32;

    reg [9:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    // Horizontal and vertical sync signals
    assign hsync = (h_counter >= (H_DISPLAY + 16) && h_counter < (H_DISPLAY + 16 + 96));
    assign vsync = (v_counter >= (V_DISPLAY + 10) && v_counter < (V_DISPLAY + 10 + 2));

    // Instantiate frog sprite renderer
    wire frog_in_sprite;
    wire [2:0] frog_r, frog_g, frog_b;

    frog_renderer frog_sprite_inst (
        .clk(clk),
        .h_counter(h_counter),
        .v_counter(v_counter),
        .frog_x(frog_x),
        .frog_y(frog_y),
        .in_frog(frog_in_sprite),
        .color_r(frog_r),
        .color_g(frog_g),
        .color_b(frog_b)
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
        red = 3'b000;
        green = 3'b000;
        blue = 3'b000;

        // Draw grid
        if (h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0) begin
            red = 3'b100;
            green = 3'b100;
            blue = 3'b100;
        end

        // Draw frog sprite (from frog_renderer module)
        if (frog_in_sprite) begin
            red = frog_r;
            green = frog_g;
            blue = frog_b;
        end

        // Draw cars
        if ((h_counter >= car_x1 && h_counter < car_x1 + CAR_SIZE) && (v_counter >= car_y1 && v_counter < car_y1 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x2 && h_counter < car_x2 + CAR_SIZE) && (v_counter >= car_y2 && v_counter < car_y2 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x3 && h_counter < car_x3 + CAR_SIZE) && (v_counter >= car_y3 && v_counter < car_y3 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x4 && h_counter < car_x4 + CAR_SIZE) && (v_counter >= car_y4 && v_counter < car_y4 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x5 && h_counter < car_x5 + CAR_SIZE) && (v_counter >= car_y5 && v_counter < car_y5 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x6 && h_counter < car_x6 + CAR_SIZE) && (v_counter >= car_y6 && v_counter < car_y6 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x7 && h_counter < car_x7 + CAR_SIZE) && (v_counter >= car_y7 && v_counter < car_y7 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x8 && h_counter < car_x8 + CAR_SIZE) && (v_counter >= car_y8 && v_counter < car_y8 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x9 && h_counter < car_x9 + CAR_SIZE) && (v_counter >= car_y9 && v_counter < car_y9 + CAR_SIZE)) begin
            red = 3'b111;
        end
        if ((h_counter >= car_x10 && h_counter < car_x10 + CAR_SIZE) && (v_counter >= car_y10 && v_counter < car_y10 + CAR_SIZE)) begin
            red = 3'b111;
        end
    end

endmodule