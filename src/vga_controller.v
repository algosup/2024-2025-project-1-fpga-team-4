module vga_controller (
    input wire clk,
    output wire [2:0] red,
    output wire [2:0] green,
    output wire [2:0] blue,
    output wire hsync,
    output wire vsync
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

    // Set grid width and height to be equal for square cells
    localparam GRID_SIZE = 32;  // Example grid size

    reg [9:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    // Instantiate the square_drawer module
    wire in_square;
    square_drawer square_inst (
        .h_counter(h_counter),
        .v_counter(v_counter),
        .in_square(in_square)
    );

    // Horizontal and vertical sync signals
    assign hsync = (h_counter >= (H_DISPLAY + H_FRONT_PORCH) && h_counter < (H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE));
    assign vsync = (v_counter >= (V_DISPLAY + V_FRONT_PORCH) && v_counter < (V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE));

    // RGB output signals
    assign red = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                 ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 || in_square) ? 3'b111 : 3'b000) : 3'b000;
    assign green = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                   ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 || in_square) ? 3'b111 : 3'b000) : 3'b000;
    assign blue = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                  ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 || in_square) ? 3'b111 : 3'b000) : 3'b000;

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