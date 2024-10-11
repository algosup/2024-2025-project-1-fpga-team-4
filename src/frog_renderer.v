module frog_renderer (
    input wire clk,
    input wire [9:0] h_counter,  // Current horizontal pixel position
    input wire [9:0] v_counter,  // Current vertical pixel position
    input wire [9:0] frog_x,     // Frog's horizontal position
    input wire [9:0] frog_y,     // Frog's vertical position
    output reg in_frog,
    output reg [2:0] color_r,    // Output red color
    output reg [2:0] color_g,    // Output green color
    output reg [2:0] color_b     // Output blue color
);

    localparam FROG_SIZE = 32;  // Frog size is 32x32 pixels

    // Frog sprite memory (32x32 binary sprite)
    reg [31:0] frog_sprite[0:31];

    // Initialize the frog sprite (binary representation)
    initial begin
        frog_sprite[0]  = 32'b01111000000000000000000000011110;
        frog_sprite[1]  = 32'b01111000000000000000000000011110;
        frog_sprite[2]  = 32'b11111000000000000000000000011111;
        frog_sprite[3]  = 32'b11111000000000000000000000011111;
        frog_sprite[4]  = 32'b01111000111111111111111100011110;
        frog_sprite[5]  = 32'b01111000100011111111000100011110;
        frog_sprite[6]  = 32'b01111000100011111111000100011110;
        frog_sprite[7]  = 32'b01111000111111111111111100011110;
        frog_sprite[8]  = 32'b01111000111111111111111100011110;
        frog_sprite[9]  = 32'b01111000111111111111111100011110;
        frog_sprite[10] = 32'b01111111111111111111111111111110;
        frog_sprite[11] = 32'b01111111111111111111111111111110;
        frog_sprite[12] = 32'b00000000111111111111111100000000;
        frog_sprite[13] = 32'b00000000111111111111111100000000;
        frog_sprite[14] = 32'b00000000111111111111111100000000;
        frog_sprite[15] = 32'b00000000111111111111111100000000;
        frog_sprite[16] = 32'b00000000111111111111111100000000;
        frog_sprite[17] = 32'b00000000111111111111111100000000;
        frog_sprite[18] = 32'b00000000111111111111111100000000;
        frog_sprite[19] = 32'b00000000111111111111111100000000;
        frog_sprite[20] = 32'b00000000111111111111111100000000;
        frog_sprite[21] = 32'b01111111111111111111111111111110;
        frog_sprite[22] = 32'b01111111111111111111111111111110;
        frog_sprite[23] = 32'b01111000111111111111111100011110;
        frog_sprite[24] = 32'b01111000111111111111111100011110;
        frog_sprite[25] = 32'b01111000111111111111111100011110;
        frog_sprite[26] = 32'b01111000000000000000000000011110;
        frog_sprite[27] = 32'b01111000000000000000000000011110;
        frog_sprite[28] = 32'b11111000000000000000000000011111;
        frog_sprite[29] = 32'b11111000000000000000000000011111;
        frog_sprite[30] = 32'b01111000000000000000000000011110;
        frog_sprite[31] = 32'b01111000000000000000000000011110;
    end

    // Check if the current pixel is within the frog's position
    assign in_frog = (h_counter >= frog_x && h_counter < frog_x + FROG_SIZE) &&
                     (v_counter >= frog_y && v_counter < frog_y + FROG_SIZE);

    // Calculate the pixel offset within the frog sprite
    wire [4:0] sprite_x = h_counter - frog_x;  // 5-bit for 32x32 sprite
    wire [4:0] sprite_y = v_counter - frog_y;

    // Set color based on sprite pixel value
    always @(*) begin
        if (in_frog) begin
            if (frog_sprite[sprite_y][sprite_x] == 1'b1) begin
                color_r <= 3'b000;  // Green frog
                color_g <= 3'b111;
                color_b <= 3'b000;
            end else begin
                color_r <= 3'b000;  // Black background
                color_g <= 3'b000;
                color_b <= 3'b000;
            end
        end else begin
            color_r <= 3'b000;
            color_g <= 3'b000;
            color_b <= 3'b000;
        end
    end

endmodule