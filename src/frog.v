module square_drawer (
    input wire [9:0] h_counter,
    input wire [9:0] v_counter,
    output wire in_square
);

    // Define the grid size and the number of squares
    localparam GRID_SIZE = 32;  // Example grid size (both width and height)
    localparam GRID_ROWS = 15;  // Number of rows in the grid
    localparam GRID_COLS = 20;  // Number of columns in the grid

    // 2D array to store the positions of the squares
    reg grid [0:GRID_ROWS-1][0:GRID_COLS-1];

    // Declare loop variables
    integer i, j;

    initial begin
        // Initialize the grid with squares at specific positions
        for (i = 0; i < GRID_ROWS; i = i + 1) begin
            for (j = 0; j < GRID_COLS; j = j + 1) begin
                grid[i][j] = 0;  // Initialize all positions to 0 (no square)
            end
        end
        // Set specific positions to 1 (square)
        grid[14][10] = 1;  // Adjusted to fit within the grid bounds
    end

    // Calculate the current grid position based on the counters
    wire [9:0] grid_x = h_counter / GRID_SIZE;
    wire [9:0] grid_y = v_counter / GRID_SIZE;

    // Check if the current pixel is within a square
    assign in_square = (grid_x < GRID_COLS && grid_y < GRID_ROWS) ? grid[grid_y][grid_x] : 0;

endmodule