module car (
    input wire clk,
    input wire clk_enable,       // Clock enable from ClockDivider
    input wire reset,
    input wire [1:0] direction,  // 0 = left to right, 1 = right to left
    input wire [5:0] speed,      // Speed of the car
    output reg [4:0] car_pos,    // Reduced to 5 bits to represent car position as index
    output reg [9:0] car_y,
    input wire [9:0] start_x,    // Initial x position (10 bits)
    input wire [9:0] start_y,    // Initial y position
    input wire [1:0] length      // Length of the car
);

    localparam POSITIONS = 20;  // Number of possible positions on screen (640 / 32)
    localparam STEP_SIZE = 32;   // Step size for each teleportation

    reg [7:0] teleport_counter; // Counter to control teleportation delay

    always @(posedge clk) begin
        if (reset) begin
            car_pos <= start_x / STEP_SIZE;  // Set initial position index
            car_y <= start_y;
            teleport_counter <= 0;  // Reset teleport counter
        end else if (clk_enable) begin
            if (teleport_counter == speed) begin
                teleport_counter <= 0;
                // Teleport movement logic
                if (direction == 0) begin
                    if (car_pos + length < POSITIONS)
                        car_pos <= car_pos + 1;
                    else
                        car_pos <= 0;
                end else begin
                    if (car_pos > 0)
                        car_pos <= car_pos - 1;
                    else
                        car_pos <= POSITIONS - 1;
                end
            end else begin
                teleport_counter <= teleport_counter + 1;
            end
        end
    end

    // Calculate car_x from car_pos
    always @(*) begin
        car_x = car_pos * STEP_SIZE;
    end

endmodule
