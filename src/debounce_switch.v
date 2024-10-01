module debounce_switch (
    input wire clk,
    input wire i_Switch,
    output reg o_Switch
);
    reg [19:0] counter = 0;
    reg state = 0;

    always @(posedge clk) begin
        if (i_Switch == state) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 1000000) begin  // Example debounce delay
                state <= i_Switch;
                counter <= 0;
            end
        end
    end

    assign o_Switch = state;
endmodule
