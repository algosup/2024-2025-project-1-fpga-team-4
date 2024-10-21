module debounce_switch (
    input wire clk,
    input wire i_Switch,
    output reg o_Switch
);
    parameter COUNTER_WIDTH = 16;  // Reduced width to save memory
    parameter DEBOUNCE_DELAY = 50000; // Adjusted debounce delay for new counter width
    reg [COUNTER_WIDTH-1:0] counter = 0;
    reg state = 0;

    always @(posedge clk) begin
        if (i_Switch == state) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == DEBOUNCE_DELAY) begin  
                state <= i_Switch;
                counter <= 0;
            end
        end
        o_Switch <= state;
    end
endmodule
