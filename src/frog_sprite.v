module color_picker(
    input [1:0] sprite_pixel,
    output reg [2:0] color_r,
    output reg [2:0] color_g,
    output reg [2:0] color_b,
);

    always @(*) begin
        case (sprite_pixel)
            2'b00: begin  // Black (for wheels)
                color_r <= 3'b000;
                color_g <= 3'b000;
                color_b <= 3'b000;
            end
            2'b01: begin  // Pink (for car body)
                color_r <= 3'b111;
                color_g <= 3'b000;
                color_b <= 3'b111;
            end
            2'b10: begin  // White (for highlights)
                color_r <= 3'b111;
                color_g <= 3'b111;
                color_b <= 3'b111;
            end
            2'b11: begin  // Unused or another color
                color_r <= 3'b000;
                color_g <= 3'b111;
                color_b <= 3'b000;
            end
        endcase
    end
endmodule