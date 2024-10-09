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
    localparam FROG_SIZE = 32;

    // Memory to store frog sprite data
    reg [64:0] sprite_mem [0:31];

    // Initial block to hardcode the sprite into memory
        initial begin
            sprite_mem[0]  = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[1]  = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[2]  = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[3]  = 64'b0000000000000000010101010100000000000000000000000000000000000000;
            sprite_mem[4]  = 64'b0000000000000001010000000001010000000000000000000000000000000000;
            sprite_mem[5]  = 64'b0000000000000010010101010100100000000000000000000000000000000000;
            sprite_mem[6]  = 64'b0000000100000100010101010100010000000000000000000000000000000000;
            sprite_mem[7]  = 64'b0000000100001000000100000000010000000000000000000000000000000000;
            sprite_mem[8]  = 64'b0000000100000000000001000000010000000000000000000000000000000000;
            sprite_mem[9]  = 64'b0000000010010000000001000000010000000000000000000000000000000000;
            sprite_mem[10] = 64'b0000000111010000000001000000100000000000000000000000000000000000;
            sprite_mem[11] = 64'b0000000000010000000001111111100000000000000000000000000000000000;
            sprite_mem[12] = 64'b0000000001010000000001000000000000000000000000000000000000000000;
            sprite_mem[13] = 64'b0000000001010000000001000000000000000000000000000000000000000000;
            sprite_mem[14] = 64'b0000000000010000000001000000000000000000000000000000000000000000;
            sprite_mem[15] = 64'b0000000000001000000001000000000000000000000000000000000000000000;
            sprite_mem[16] = 64'b0000000000001100000011000000000000000000000000000000000000000000;
            sprite_mem[17] = 64'b0000000000000110000110000000000000000000000000000000000000000000;
            sprite_mem[18] = 64'b0000000000000111111110000000000000000000000000000000000000000000;
            sprite_mem[19] = 64'b0000000000000010001100000000000000000000000000000000000000000000;
            sprite_mem[20] = 64'b0000000000000010001000000000000000000000000000000000000000000000;
            sprite_mem[21] = 64'b0000000000000100001000000000000000000000000000000000000000000000;
            sprite_mem[22] = 64'b0000110000001000001000000000000000000000000000000000000000000000;
            sprite_mem[23] = 64'b0000011100000100001000000000000000000000000000000000000000000000;
            sprite_mem[24] = 64'b0000000011111110010000000111000000000000000000000000000000000000;
            sprite_mem[25] = 64'b0000000000000000011111111000000000000000000000000000000000000000;
            sprite_mem[26] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[27] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[28] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[29] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[30] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            sprite_mem[31] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        end
    // Check if the current pixel is within the frog's position
    wire in_frog;
    assign in_frog = (h_counter >= frog_x && h_counter < frog_x + FROG_SIZE) &&
                     (v_counter >= frog_y && v_counter < frog_y + FROG_SIZE);

    // Calculate the pixel offset within the frog sprite
    wire [4:0] sprite_x = h_counter - frog_x;
    wire [4:0] sprite_y = v_counter - frog_y;
    wire [5:0] sprite_offset = sprite_x * 2;
    reg [1:0] sprite_pixel;

    // Update sprite pixel on clock edge
    always @(posedge clk) begin
        if (in_frog) begin
            sprite_pixel <= sprite_mem[sprite_y][sprite_offset +: 2];
        end else begin
            sprite_pixel <= 2'b00;
        end
    end

    // Set color based on sprite pixel value
    always @(*) begin
        case (sprite_pixel)
            2'b00: begin
                color_r <= 3'b000;
                color_g <= 3'b000;
                color_b <= 3'b000;
            end
            2'b01: begin
                color_r <= 3'b111;
                color_g <= 3'b000;
                color_b <= 3'b111;
            end
            2'b10: begin
                color_r <= 3'b111;
                color_g <= 3'b111;
                color_b <= 3'b111;
            end
            2'b11: begin
                color_r <= 3'b000;
                color_g <= 3'b111;
                color_b <= 3'b000;
            end
        endcase
    end

endmodule
