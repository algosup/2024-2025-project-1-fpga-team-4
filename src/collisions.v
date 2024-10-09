module collisions (
    input wire [9:0] frog_x,
    input wire [9:0] frog_y,
    input wire [9:0] frog_x2,
    input wire [9:0] frog_y2,
    output wire death_collision,
    output wire win_collision
);  

localparam frog_size=32;

wire overlap_x = (frog_x<frog_x2+frog_size) && (frog_x2<frog_x+frog_size);
wire overlap_y = (frog_y<frog_y2+1) && (frog_y2<frog_y+1);
wire overlap_top= (frog_y<1);

assign death_collision = (overlap_x && overlap_y);

assign win_collision = overlap_top;

endmodule