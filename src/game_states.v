module game_states (
    input wire clk,
    input wire reset, // External reset signal
    input wire level_complete, // Signal indicating level completion
    input wire game_over_signal, // Signal indicating game over
    input wire win_signal, // Signal indicating game win
    input wire switch1,
    input wire switch2, 
    input wire switch3, 
    input wire switch4, 
    output reg [3:0] current_level, // Current level (0 to 8)
    output reg [1:0] current_state
);

    // Define game states
    localparam RESET = 2'b00;
    localparam LEVEL_INCREMENT = 2'b01;
    localparam GAME_OVER = 2'b10;
    localparam WINNING_SCREEN = 2'b11;

    // Initialize the current state to RESET and current level to 0
    initial begin
        current_state = RESET;
        current_level = 0;
    end

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset || (switch1 && switch2 && switch3 && switch4)) begin
            current_state <= RESET;
            current_level <= 0;
        end else begin
            case (current_state)
                RESET: begin
                    // Reset logic here
                    current_state <= LEVEL_INCREMENT;
                end
                LEVEL_INCREMENT: begin
                    // Level increment logic here
                    if (level_complete) begin
                        if (current_level < 8) begin
                            current_level <= current_level + 1;
                        end
                        current_state <= WINNING_SCREEN;
                    end else if (game_over_signal) begin
                        current_state <= GAME_OVER;
                    end
                end
                GAME_OVER: begin
                    // Game over logic here
                    if (reset || (switch1 && switch2 && switch3 && switch4)) begin
                        current_state <= RESET;
                        current_level <= 0;
                    end
                end
                WINNING_SCREEN: begin
                    // Winning screen logic here
                    if (reset || (switch1 && switch2 && switch3 && switch4)) begin
                        current_state <= RESET;
                    end
                end
            endcase
        end
    end

endmodule