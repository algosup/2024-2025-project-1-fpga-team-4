module collisions (
    input wire [9:0] frog_x,
    input wire [9:0] frog_y,
    input wire [9:0] car_x1,
    input wire [9:0] car_y1,
    output wire death_collision,
    output wire win_collision
);  

localparam tile_size=32;

wire overlap_x = ((frog_x>=car_x1) && (frog_x<(car_x1+tile_size)) || (frog_x+tile_size>=car_x1) && (frog_x+tile_size<(car_x1+tile_size)));
wire overlap_y = ((frog_y>=car_y1) && (frog_y<(car_y1+tile_size)) || (frog_y+tile_size>=car_y1) && (frog_y+tile_size<(car_y1+tile_size)));
wire overlap_top= (frog_y==0);

assign death_collision = (overlap_x && overlap_y);

assign win_collision = overlap_top;

endmodule