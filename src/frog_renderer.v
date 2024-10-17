module frog_renderer (
    input wire clk,
    input wire [9:0] h_counter,  // Current horizontal pixel position
    input wire [9:0] v_counter,  // Current vertical pixel position
    input wire [9:0] frog_x,     // Frog's horizontal position
    input wire [9:0] frog_y,     // Frog's vertical position
    input wire [1:0] direction,  // Frog's direction
    output reg in_frog,
    output reg [2:0] color_r,    // Output red color
    output reg [2:0] color_g,    // Output green color
    output reg [2:0] color_b     // Output blue color
);

    localparam FROG_SIZE = 32;  // Frog size is 32x32 pixels

    // Frog sprite memory stored in block RAM
    (* ram_style = "block" *) reg [31:0] icestorm_ram [0:127];

    // Initialize the frog sprites (binary representation for each direction)
    initial begin
        // Load sprite data into block RAM
        $readmemh("frog_sprites.hex", icestorm_ram);
    end

    // Registers to hold sprite data output
    reg [31:0] sprite_data;
    wire [6:0] sprite_index;

    // Calculate the pixel offset within the frog sprite
    wire [4:0] sprite_x = h_counter - frog_x;
    wire [4:0] sprite_y = v_counter - frog_y;
    assign sprite_index = (direction * 32) + sprite_y;  // Adjust index based on direction

    // Read sprite data from block RAM synchronously
    always @(posedge clk) begin
        sprite_data <= icestorm_ram[sprite_index];
    end

    // Check if the current pixel is within the frog's position
    always @(*) begin
        in_frog = (h_counter >= frog_x && h_counter < frog_x + FROG_SIZE) &&
                  (v_counter >= frog_y && v_counter < frog_y + FROG_SIZE);
    end

    // Set color based on sprite pixel value
    always @(*) begin
        if (in_frog) begin
            if (sprite_data[sprite_x] == 1'b1) begin
                color_r = 3'b000;  // Green frog
                color_g = 3'b111;
                color_b = 3'b000;
            end else begin
                color_r = 3'b000;  // Black background
                color_g = 3'b000;
                color_b = 3'b000;
            end
        end else begin
            color_r = 3'b000;
            color_g = 3'b000;
            color_b = 3'b000;
        end
    end

endmodule