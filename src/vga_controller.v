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

        reg [31:0] sprite_mem [0:31];

        // Initial block to hardcode the sprite into memory
        initial begin
            // Hardcoded 32x32 sprite data (each row is 32 bits wide, 1-bit per pixel)
            sprite_mem[0]  = 32'b00000000000000000000000000000000;
            sprite_mem[1]  = 32'b00000000000000000000000000000000;
            sprite_mem[2]  = 32'b00000000000000000000000000000000;
            sprite_mem[3]  = 32'b00000000000000011100000000000000;
            sprite_mem[4]  = 32'b00000000000000110100000000000000;
            sprite_mem[5]  = 32'b00000000000001100110000000000000;
            sprite_mem[6]  = 32'b00000010000011000011000000000100;
            sprite_mem[7]  = 32'b00000010000110000001100000000100;
            sprite_mem[8]  = 32'b00000010000100000000110000000100;
            sprite_mem[9]  = 32'b00000001001000000000010000000100;
            sprite_mem[10] = 32'b00000001111000000000010000001000;
            sprite_mem[11] = 32'b00000000001000000000011111111000;
            sprite_mem[12] = 32'b00000000011000000000010000000000;
            sprite_mem[13] = 32'b00000000011000000000010000000000;
            sprite_mem[14] = 32'b00000000001000000000010000000000;
            sprite_mem[15] = 32'b00000000000100000000010000000000;
            sprite_mem[16] = 32'b00000000000110000000110000000000;
            sprite_mem[17] = 32'b00000000000011000001100000000000;
            sprite_mem[18] = 32'b00000000000011111111000000000000;
            sprite_mem[19] = 32'b00000000000010000011000000000000;
            sprite_mem[20] = 32'b00000000000010000010000000000000;
            sprite_mem[21] = 32'b00000000000011000010000000000000;
            sprite_mem[22] = 32'b00001100000010000010000000000000;
            sprite_mem[23] = 32'b00000111000001000010000000000000;
            sprite_mem[24] = 32'b00000000111111100100000001110000;
            sprite_mem[25] = 32'b00000000000000000111111110000000;
            sprite_mem[26] = 32'b00000000000000000000000000000000;
            sprite_mem[27] = 32'b00000000000000000000000000000000;
            sprite_mem[28] = 32'b00000000000000000000000000000000;
            sprite_mem[29] = 32'b00000000000000000000000000000000;
            sprite_mem[30] = 32'b00000000000000000000000000000000;
            sprite_mem[31] = 32'b00000000000000000000000000000000;
        end

        // Check if the current pixel is within the frog's position
        wire in_frog;
        assign in_frog = (h_counter >= frog_x && h_counter < frog_x + FROG_SIZE) &&
                        (v_counter >= frog_y && v_counter < frog_y + FROG_SIZE);

        // Calculate the pixel offset within the frog sprite
        wire [4:0] sprite_x = h_counter - frog_x;
        wire [4:0] sprite_y = v_counter - frog_y;
        reg sprite_pixel;

        always @(posedge clk) begin
            if (in_frog) begin
                // Extract the pixel from the sprite memory (1 bit per pixel)
                sprite_pixel <= sprite_mem[sprite_y][sprite_x];
            end else begin
                sprite_pixel <= 0;
            end
        end
        
        // RGB output signals
        assign red = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                    ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0) ? 3'b111 : 3'b000) : 3'b000;
        assign green = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                    ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0) ? 3'b111 : (sprite_pixel)? 3'd111 : 3'b000) : 3'b000;
        assign blue = (h_counter < H_DISPLAY && v_counter < V_DISPLAY) ? 
                    ((h_counter % GRID_SIZE == 0 || v_counter % GRID_SIZE == 0) ? 3'b111 : 3'b000) : 3'b000;

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
