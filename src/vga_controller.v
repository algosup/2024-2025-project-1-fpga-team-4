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

        reg [64:0] sprite_mem [0:31];

        // Initial block to hardcode the sprite into memory, this sprite is in 64' and every two bits correspond to 1 pixel, that way we can have up to 4 colors, if we make it 96' every three bits will correspond to a pixel, thus giving us 9 colors, this is how we will apply color to the sprites
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

        always @(posedge clk) begin
            if (in_frog) begin
                // Extract the pixel from the sprite memory (1 bit per pixel)
                sprite_pixel <= sprite_mem[sprite_y][sprite_offset +: 2];
            end else begin
                sprite_pixel <= 2'b00;
            end
        end

        reg [2:0] color_r, color_g, color_b;

        color_picker frog(
            .sprite_pixel(sprite_pixel),
            .color_r(color_r),
            .color_g(color_g),
            .color_b(color_b),
        );
        
        // RGB output signals
        assign red = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                    ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0) ? 3'b111 : (sprite_pixel) ? color_r : 3'b000) : 3'b000;
        assign green = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                    ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0 ) ? 3'b111 : (sprite_pixel) ? color_g : 3'd000) : 3'b000;
        assign blue = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                    ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0) ? 3'b111 : (sprite_pixel) ? color_b : 3'b000) : 3'b000;

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
