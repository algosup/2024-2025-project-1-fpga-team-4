module clock_divider (
    input wire clk,       // Input clock signal
    input wire reset,     // Reset signal
    input wire [15:0] divide_by, // Division factor for the clock
    output reg clk_out    // Output divided clock signal
);

    reg [15:0] counter = 0;

    // Clock division logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter >= (divide_by - 1)) begin
                counter <= 0;
                clk_out <= ~clk_out; // Toggle output clock
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
