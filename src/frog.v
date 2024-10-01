module frog (
    input wire clk,
    input wire reset,
    input wire switch1, // Move up
    input wire switch2, // Move left
    input wire switch3, // Move right
    input wire switch4, // Move down
    output reg [9:0] frog_x,
    output reg [9:0] frog_y
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
    end

    // Movement logic with edge detection
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to the center of the bottom row
            frog_x <= 320;
            frog_y <= 448;
            // Reset previous switch states
            switch1_prev <= 0;
            switch2_prev <= 0;
            switch3_prev <= 0;
            switch4_prev <= 0;
        end else begin
            // Detect rising edge (press) for each switch
            if (switch2_clean && !switch2_prev && frog_x >= 32) 
                frog_x <= frog_x - 32; // Move left
            if (switch3_clean && !switch3_prev && frog_x <= (640 - 32)) 
                frog_x <= frog_x + 32; // Move right
            if (switch1_clean && !switch1_prev && frog_y >= 32) 
                frog_y <= frog_y - 32; // Move up
            if (switch4_clean && !switch4_prev && frog_y <= (480 - 32)) 
                frog_y <= frog_y + 32; // Move down

            // Update previous switch states
            switch1_prev <= switch1_clean;
            switch2_prev <= switch2_clean;
            switch3_prev <= switch3_clean;
            switch4_prev <= switch4_clean;
        end
    end

endmodule
