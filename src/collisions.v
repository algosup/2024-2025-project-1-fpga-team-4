module collisions (
    input wire [9:0] frog_x,
    input wire [9:0] frog_y,
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
    output wire death_collision,
    output wire win_collision
);  

localparam tile_size=32;

// Collision detection for each car
wire overlap_0 = (((frog_x >= car_x_0) && (frog_x < (car_x_0 + tile_size))) || (((frog_x + tile_size) >= car_x_0) && ((frog_x + tile_size) < (car_x_0 + tile_size)))) && ((frog_y >= car_y_0) && (frog_y < (car_y_0 + tile_size)));
wire overlap_1 = (((frog_x >= car_x_1) && (frog_x < (car_x_1 + tile_size))) || (((frog_x + tile_size) >= car_x_1) && ((frog_x + tile_size) < (car_x_1 + tile_size)))) && ((frog_y >= car_y_1) && (frog_y < (car_y_1 + tile_size)));
wire overlap_2 = (((frog_x >= car_x_2) && (frog_x < (car_x_2 + tile_size))) || (((frog_x + tile_size) >= car_x_2) && ((frog_x + tile_size) < (car_x_2 + tile_size)))) && ((frog_y >= car_y_2) && (frog_y < (car_y_2 + tile_size)));
wire overlap_3 = (((frog_x >= car_x_3) && (frog_x < (car_x_3 + tile_size))) || (((frog_x + tile_size) >= car_x_3) && ((frog_x + tile_size) < (car_x_3 + tile_size)))) && ((frog_y >= car_y_3) && (frog_y < (car_y_3 + tile_size)));
wire overlap_4 = (((frog_x >= car_x_4) && (frog_x < (car_x_4 + tile_size))) || (((frog_x + tile_size) >= car_x_4) && ((frog_x + tile_size) < (car_x_4 + tile_size)))) && ((frog_y >= car_y_4) && (frog_y < (car_y_4 + tile_size)));
wire overlap_5 = (((frog_x >= car_x_5) && (frog_x < (car_x_5 + tile_size))) || (((frog_x + tile_size) >= car_x_5) && ((frog_x + tile_size) < (car_x_5 + tile_size)))) && ((frog_y >= car_y_5) && (frog_y < (car_y_5 + tile_size)));
wire overlap_6 = (((frog_x >= car_x_6) && (frog_x < (car_x_6 + tile_size))) || (((frog_x + tile_size) >= car_x_6) && ((frog_x + tile_size) < (car_x_6 + tile_size)))) && ((frog_y >= car_y_6) && (frog_y < (car_y_6 + tile_size)));
wire overlap_7 = (((frog_x >= car_x_7) && (frog_x < (car_x_7 + tile_size))) || (((frog_x + tile_size) >= car_x_7) && ((frog_x + tile_size) < (car_x_7 + tile_size)))) && ((frog_y >= car_y_7) && (frog_y < (car_y_7 + tile_size)));

wire overlap_top = (frog_y == 0);

assign death_collision = overlap_0 || overlap_1 || overlap_2 || overlap_3 || overlap_4 || overlap_5 || overlap_6 || overlap_7;
assign win_collision = overlap_top;

endmodule