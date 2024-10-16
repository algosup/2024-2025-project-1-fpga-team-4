module frog (
    input wire clk,
    input wire reset,
    input wire switch1, // Move up
    input wire switch2, // Move left
    input wire switch3, // Move right
    input wire switch4, // Move down
    output reg [9:0] frog_x,
    output reg [9:0] frog_y,
    output reg [1:0] frog_direction // 2-bit signal to represent direction: 00 - Up, 01 - Left, 10 - Right, 11 - Down
);

    // Debounced switch signals
    wire switch1_clean;
    wire switch2_clean;
    wire switch3_clean;
    wire switch4_clean;

    // Instantiate debouncers for each switch
    debounce_switch db1 (.clk(clk), .i_Switch(switch1), .o_Switch(switch1_clean));
    debounce_switch db2 (.clk(clk), .i_Switch(switch2), .o_Switch(switch2_clean));
    debounce_switch db3 (.clk(clk), .i_Switch(switch3), .o_Switch(switch3_clean));
    debounce_switch db4 (.clk(clk), .i_Switch(switch4), .o_Switch(switch4_clean));

    // Registers to store the previous state of the switch (for edge detection)
    reg switch1_prev, switch2_prev, switch3_prev, switch4_prev;

    // Initial position of the frog (center of the bottom row)
    initial begin
        frog_x = 320;  // Center (aligned to grid)
        frog_y = 448;  // Bottom row
        frog_direction = 2'b00; // Initial direction set to Up
    end

    // Movement logic with edge detection
    always @(posedge clk) begin
        if (reset) begin
            // Reset to the center of the bottom row
            frog_x <= 320;
            frog_y <= 448;
            frog_direction <= 2'b00; // Reset direction to Up
            // Reset previous switch states
            switch1_prev <= switch1_clean;
            switch2_prev <= switch2_clean;
            switch3_prev <= switch3_clean;
            switch4_prev <= switch4_clean;
        end else begin
            // Detect rising edge (press) for each switch
            if (switch3_clean && !switch3_prev && frog_y >= 32) begin
                frog_y <= frog_y - 32; // Move left (Switch 3)
                frog_direction <= 2'b00; // Set direction to Left
            end
            if (switch1_clean && !switch1_prev && frog_y <= 447) begin
                frog_y <= frog_y + 32; // Move up (Switch 1)
                frog_direction <= 2'b11; // Set direction to Up
            end
            if (switch4_clean && !switch4_prev && frog_x >= 32) begin
                frog_x <= frog_x - 32; // Move right (Switch 4)
                frog_direction <= 2'b01; // Set direction to Right
            end
            if (switch2_clean && !switch2_prev && frog_x <= 607) begin
                frog_x <= frog_x + 32; // Move down (Switch 2)
                frog_direction <= 2'b10; // Set direction to Down
            end

            // Update previous switch states
            switch1_prev <= switch1_clean;
            switch2_prev <= switch2_clean;
            switch3_prev <= switch3_clean;
            switch4_prev <= switch4_clean;
        end
    end

endmodule