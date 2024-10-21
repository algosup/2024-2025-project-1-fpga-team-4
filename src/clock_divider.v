module ClockDivider #(
    parameter DIVIDING_FACTOR = 23'd2500000
)(
    input wire i_Clk,
    output reg clk_enable
);
    reg [22:0] counter = 0;
    always @(posedge i_Clk) begin
        if (counter == DIVIDING_FACTOR) begin
            counter <= 0;
            clk_enable <= 1;
        end else begin
            counter <= counter + 1;
            clk_enable <= 0;
        end
    end
endmodule
