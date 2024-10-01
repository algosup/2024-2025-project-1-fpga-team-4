module vga_controller (
    input wire clk,
    input wire [9:0] frog_x,  // Frog's horizontal position
    input wire [9:0] frog_y,  // Frog's vertical position
    output wire [2:0] red,    // VGA red output
    output wire [2:0] green,  // VGA green output
    output wire [2:0] blue,   // VGA blue output
    output wire hsync,        // VGA horizontal sync
    output wire vsync         // VGA vertical sync
);

    // VGA parameters for 640x480 resolution
    localparam H_DISPLAY = 640;
    localparam H_FRONT_PORCH = 16;
    localparam H_SYNC_PULSE = 96;
    localparam H_BACK_PORCH = 48;
    localparam H_TOTAL = H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

    localparam V_DISPLAY = 480;
    localparam V_FRONT_PORCH = 10;
    localparam V_SYNC_PULSE = 2;
    localparam V_BACK_PORCH = 33; 
    localparam V_TOTAL = V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

    localparam GRID_SIZE = 32;
    localparam FROG_SIZE = 32;  // Assuming frog occupies one grid square (32x32)

    reg [9:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    // Horizontal and vertical sync signals
    assign hsync = (h_counter >= (H_DISPLAY + H_FRONT_PORCH) && h_counter < (H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE));
    assign vsync = (v_counter >= (V_DISPLAY + V_FRONT_PORCH) && v_counter < (V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE));

    // Check if the current pixel is within the frog's position
    wire in_frog;
    assign in_frog = (h_counter >= frog_x && h_counter < frog_x + FROG_SIZE) &&
                     (v_counter >= frog_y && v_counter < frog_y + FROG_SIZE);

    // RGB output signals
    assign red = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                 ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 || in_frog) ? 3'b111 : 3'b000) : 3'b000;
    assign green = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                   ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 || in_frog) ? 3'b111 : 3'b000) : 3'b000;
    assign blue = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                  ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 || in_frog) ? 3'b111 : 3'b000) : 3'b000;

    // Horizontal counter
    always @(posedge clk) begin
        if (h_counter == H_TOTAL - 1) begin
            h_counter <= 0;
            if (v_counter == V_TOTAL - 1) begin
                v_counter <= 0;
            end else begin
                v_counter <= v_counter + 1;
            end
        end else begin
            h_counter <= h_counter + 1;
        end
    end

endmodule
