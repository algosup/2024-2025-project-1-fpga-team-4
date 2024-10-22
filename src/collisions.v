module collisions (
    input wire [9:0] frog_x,
    input wire [9:0] frog_y,
    input wire [3:0] current_level, // Current game level
    input wire [9:0] car_x_0,
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
    output wire death_collision,
    output wire win_collision
);  

    localparam tile_size = 32;

    // Function to calculate overlap
    function overlap;
        input [9:0] frog_x, frog_y;
        input [9:0] car_x, car_y;
        begin
            overlap = (((frog_x >= car_x) && (frog_x < (car_x + tile_size))) ||
                       (((frog_x - tile_size) >= car_x) && ((frog_x + tile_size) < (car_x + tile_size)))) &&
                      ((frog_y >= car_y) && (frog_y < (car_y + tile_size)));
        end
    endfunction

    // Collision detection for each car based on current level
    wire [10:0] overlaps;
    assign overlaps[0] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_0, car_y_0) : 1'b0;
    assign overlaps[1] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_1, car_y_1) : 1'b0;
    assign overlaps[2] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_2, car_y_2) : 1'b0;
    assign overlaps[3] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_3, car_y_3) : 1'b0;
    assign overlaps[4] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_4, car_y_4) : 1'b0;
    assign overlaps[5] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_5, car_y_5) : 1'b0;
    assign overlaps[6] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_6, car_y_6) : 1'b0;
    assign overlaps[7] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_7, car_y_7) : 1'b0;
    assign overlaps[8] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_8, car_y_8) : 1'b0;
    assign overlaps[9] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_9, car_y_9) : 1'b0;
    assign overlaps[10] = (current_level > 0) ? overlap(frog_x, frog_y, car_x_10, car_y_10) : 1'b0;
    

    wire overlap_top = (frog_y == 0);

    assign death_collision = |overlaps;  // If any overlap is true, death_collision is true
    assign win_collision = overlap_top;

endmodule
