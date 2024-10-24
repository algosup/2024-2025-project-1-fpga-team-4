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

    localparam FROG_SIZE = 32;  // Further reduce the frog size to 8x8

    // Frog sprite memory (8x8 binary sprite)
    reg [7:0] frog_sprite[0:7];

    // Initialize the frog sprite (binary representation)
    initial begin
        frog_sprite[0]  = 8'b11111111;
        frog_sprite[1]  = 8'b11111111;
        frog_sprite[2]  = 8'b11111111;
        frog_sprite[3]  = 8'b11111111;
        frog_sprite[4]  = 8'b11111111;
        frog_sprite[5]  = 8'b11111111;
        frog_sprite[6]  = 8'b11111111;
        frog_sprite[7]  = 8'b11111111;
        frog_sprite[8]  = 8'b11111111; 
        frog_sprite[9]  = 8'b11111111;
        frog_sprite[10] = 8'b11111111;
        frog_sprite[11] = 8'b11111111;
        frog_sprite[12] = 8'b11111111;
        frog_sprite[13] = 8'b11111111;
        frog_sprite[14] = 8'b11111111;
        frog_sprite[15] = 8'b11111111;
        frog_sprite[16] = 8'b11111111;
        frog_sprite[17] = 8'b11111111;
        frog_sprite[18] = 8'b11111111;
        frog_sprite[19] = 8'b11111111;
        frog_sprite[20] = 8'b11111111;
        frog_sprite[21] = 8'b11111111;
        frog_sprite[22] = 8'b11111111;
        frog_sprite[23] = 8'b11111111;
        frog_sprite[24] = 8'b11111111;
        frog_sprite[25] = 8'b11111111;
        frog_sprite[26] = 8'b11111111;
        frog_sprite[27] = 8'b11111111;
        frog_sprite[28] = 8'b11111111;
        frog_sprite[29] = 8'b11111111;
        frog_sprite[30] = 8'b11111111;
        frog_sprite[31] = 8'b11111111;

    end

    // Check if the current pixel is within the frog's position
    assign in_frog = (h_counter >= frog_x && h_counter < frog_x + FROG_SIZE) &&
                     (v_counter >= frog_y && v_counter < frog_y + FROG_SIZE);

    // Calculate the pixel offset within the frog sprite
    wire [2:0] sprite_x = h_counter - frog_x;  // 3-bit for 8x8 sprite
    wire [2:0] sprite_y = v_counter - frog_y;

    // Set color based on sprite pixel value
    always @(*) begin
        if (in_frog) begin
            if (frog_sprite[sprite_y][sprite_x] == 1'b1) begin
                color_r <= 3'b111;  // Green frog
                color_g <= 3'b111;
                color_b <= 3'b111;
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
