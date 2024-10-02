module car (
    input wire clk,
    input wire reset,
    input wire direction,     // 0 = left to right, 1 = right to left
    output reg [9:0] car_x,
    output reg [9:0] car_y,
    input wire [9:0] start_x, // Initial x position
    input wire [9:0] start_y  // Initial y position
);

    localparam H_DISPLAY = 640;
    reg [19:0] speed_counter = 0;
    wire move_clk;

    assign move_clk = (speed_counter == 500000);  // Adjust for speed

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            car_x <= start_x;
        end else begin
            if (speed_counter == 500000) begin
                speed_counter <= 0;
                if (direction == 0) begin
                    if (car_x < H_DISPLAY)
                        car_x <= car_x + 1;
                    else
                        car_x <= 0;
                end else begin
                    if (car_x > 0)
                        car_x <= car_x - 1;
                    else
                        car_x <= H_DISPLAY;
                end
            end else begin
                speed_counter <= speed_counter + 1;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            car_y <= start_y;
        end
    end

endmodule
