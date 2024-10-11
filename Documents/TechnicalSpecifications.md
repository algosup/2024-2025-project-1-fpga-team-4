# Technical Specifications - Frogger Project

<details>
<summary> Table of contents </summary>

- [Technical Specifications - Frogger Project](#technical-specifications---frogger-project)
  - [1. Introduction](#1-introduction)
  - [2. System Architecture](#2-system-architecture)
  - [3. Modules and Components](#3-modules-and-components)
    - [3.1 VGA Controller](#31-vga-controller)
    - [3.2 Frog Movement Logic](#32-frog-movement-logic)
    - [3.3 Vehicle Movement Logic](#33-vehicle-movement-logic)
    - [3.4 Collision Detection](#34-collision-detection)
    - [3.5 Level Management](#35-level-management)
    - [3.6 Reset Mechanism](#36-reset-mechanism)
  - [4. Sprite and Graphics Management](#4-sprite-and-graphics-management)
  - [5. Timing and Control](#5-timing-and-control)
  - [6. Collision Detection](#6-collision-detection)
    - [Truth table for collision detection](#truth-table-for-collision-detection)
  - [7. Game Mechanisms](#7-game-mechanisms)
    - [Speed table](#speed-table)
    - [Spacing table](#spacing-table)
  - [8. Memory and Storage](#8-memory-and-storage)
  - [9. Input/Output Management](#9-inputoutput-management)
  - [10. Constraints and Limitations](#10-constraints-and-limitations)
  - [11. Testing and Validation](#11-testing-and-validation)
  - [12. Development Stages](#12-development-stages)
  - [13. Developer Setup Guide](#13-developer-setup-guide)
    - [13.1 Prerequisites](#131-prerequisites)
    - [13.2 Setup Instructions](#132-setup-instructions)
      - [macOS setup](#macos-setup)
      - [Windows setup](#windows-setup)
      - [Linux setup](#linux-setup)
    - [13.3 Automated setup script requirements](#133-automated-setup-script-requirements)
  - [14. Future Plans](#14-future-plans)
- [Sources](#sources)
- [Footnotes](#footnotes)

</details>

## 1. Introduction

The purpose of this technical specification is to detail the implementation approach for the Frogger project on the Go Board FPGA. It provides guidance on configuring hardware components, programming software modules, and achieving the gameplay mechanics defined in the functional specifications. This document focuses on the "how" of implementation, including configuration details, algorithms, and memory management strategies to ensure a smooth development process.

For an overview of the game's design, mechanics, and high-level requirements, refer to the [functional Specifications](./FunctionalSpecifications.md).

## 2. System Architecture

The Frogger game is implemented on the Go Board FPGA using Verilog, with key components configured as follows:

- **FPGA configuration**: Uses Block RAM for sprite storage, LUTs for game logic, and Flip-Flops[^2] for timing and state management.

- **Memory management**: Allocates Block RAM for sprite data, game state, and buffers, with dynamic loading and compression to optimize usage.

- **Game logic**: Combines state machines and counters to manage game states, timing, and events.

- **VGA[^5] output**: Outputs a 640x480 display at 60Hz. Configured timing values ensure synchronization and smooth rendering.

- **Input handling**: Processes four debounced directional buttons for frog movement, with a reset[^12] triggered by pressing all buttons simultaneously.

Refer to the [system architecture diagram](./Images/Go_Board_V1.pdf) for an overview.

## 3. Modules and Components

While the game logic uses a 20x15 grid[^6] for movement calculations, the grid itself may not be displayed to the player in the final version, focusing instead on showing only the frog and vehicle sprites[^8].

<img src="./Images/ModuleInteractionDiagram.png" style="height:500px">

### 3.1 VGA Controller
- **Description**: Handles the VGA display, operating at a resolution of 640x480, with 512 color combinations[^14].
- **Grid layout**: Uses a 20x15 grid of cells, where each cell is 32x32 pixels.
- **Sprite memory**: Stores frog and vehicle sprites in Block RAM[^1].
- **Input**: Receives sprite data from Block RAM and control signals for rendering.
- **Output**: Generates VGA signals to render the frog and vehicles on the screen.

<img src="./Images/Grid placement.png" style="height:300px">

### 3.2 Frog Movement Logic
- **Description**: Controls frog movement based on button presses, allowing the frog to navigate the grid.
- **Grid-based movement**: The frog moves one grid space at a time. It initially appears at the bottom center of the grid (X: 11, Y: 15) at the start of each level.
- **Debouncing**: Implements debouncing[^4] to ensure that button presses are registered only once per press.
- **Boundaries**: The frog cannot move outside the 20x15 grid.
- **Input**: Receives debounced button press signals for movement.
- **Output**: Updates the frog's position in grid coordinates and sends control signals to the VGA controller to render the new position.

### 3.3 Vehicle Movement Logic
- **Description**: Manages the movement of various vehicles across the screen.
- **Vehicle directions**: The direction of movement is determined based on the row:
    - **Row 2**: Left to right.
    - **Rows 3-5**: Right to left.
    - **Rows 6-8**: Left to right.
    - **Rows 9-11**: Right to left.
    - **Rows 12-14**: Left to right.
    - **To be updated**
- **Vehicle sizes**:
    - **Car**: Occupies a 1x1 grid cell.
    - **Bus**: Occupies 2x1 grid cells.
    - **Truck**: Occupies 3x1 grid cells.
- **Movement patterns**: Vehicle movements follow predetermined patterns rather than random generation. For more details, refer to the [Functional Specifications](./FunctionalSpecifications.md).
- **Input**: Takes in the current level and speed settings.
- **Output**: Updates the positions of the vehicles on the grid and sends rendering information to the VGA controller.

### 3.4 Collision Detection
- **Description**: Checks for collisions[^7] between the frog and vehicles, or detects when the frog reaches the top row.
- **Collision with vehicles**: If the frog's position matches a vehicle's grid position, the level[^13] is reset.
- **Top row detection**: If the frog reaches the top row, the level is incremented, and difficulty is increased.
- **Input**: Receives the frog's position and the positions of obstacles (vehicles).
- **Output**: Sends collision event signals to trigger level resets or progressions.

### 3.5 Level Management
- **Description**: Manages the game's level progression and associated difficulty adjustments.
- **Level display**: Shows the current level using a 2-digit 7-segment[^10] display.
- **Level completion**: When the frog reaches the top row, it resets to the bottom, the level increments, and the game's difficulty increases.
- **Level reset**: Resets the game to level 1 in the event of a collision or a manual reset.
- **Input**: Receives signals indicating level completion or reset events.
- **Output**: Updates the 7-segment display and adjusts game settings for the new level.

### 3.6 Reset Mechanism
- **Description**: Provides a mechanism for resetting the game state.
- **Global reset**: Pressing all four directional buttons simultaneously triggers a global reset, setting the game back to the starting level, resetting the frog's position, and clearing the screen.
- **Safety checks**: Implements debouncing logic to prevent accidental resets. This ensures that only deliberate simultaneous presses of all four buttons activate the reset.
- **Input**: Detects button presses to initiate the reset.
- **Output**: Resets game state variables, including level, frog position, and vehicle positions.

<img src="./Images/FiniteStateMachine.png" style ="height: 500px">

## 4. Sprite and Graphics Management

- **Memory optimization**: Sprite data is compressed where possible to reduce Block RAM usage. Only active frames are loaded during gameplay to conserve memory.
- **Animation handling**: Animated sprites for the frog and vehicles are cycled through preloaded frames, managed by Flip-Flops and LUTs for smooth transitions.
- **Example Verilog code for Block RAM**:
    ```verilog
    module block_ram(
        input clk,
        input [9:0] address, // 10-bit address
        input [3:0] data_in, // 4-bit data for sprite colors
        input we,            // Write enable signal
        output reg [3:0] data_out // 4-bit data out (color)
    );

        reg [3:0] memory [0:1023]; // 1K Block RAM for sprite storage

        always @(posedge clk) begin
            if (we) begin
                memory[address] <= data_in; // Write to memory
            end else begin
                data_out <= memory[address]; // Read from memory
            end
        end
    endmodule
    ```

## 5. Timing and Control

- **Game clock management**: Uses a central 60Hz clock[^9] signal synchronized with the VGA refresh rate to manage all game events, including movement, collisions, and frame updates.
- **Debouncing**: Implements a 10ms debounce period for input signals to ensure reliable detection without multiple triggers.
- **Event timing**: Counters driven by the clock manage different timing requirements, such as vehicle movement speed and animation frame updates.
- **Real-time constraints**: Ensures smooth gameplay by aligning timing control with the VGA display, using Flip-Flops for consistent event execution.

## 6. Collision Detection

- **Collision rules implementation**: The game detects collisions based on grid alignment. The frog and vehicles are mapped to a 20x15 grid, where each cell is 32x32 pixels. A collision occurs when the frog occupies the same grid cell as a vehicle.

- **Data structures**: Uses a 2D array to represent the game grid, with each cell tracking the presence of vehicles. The frog's position is checked against this array for potential collisions.

- **Spatial partitioning**: To optimize collision detection, spatial partitioning is employed to focus checks on grid sections where vehicles are located, minimizing unnecessary comparisons.

- **Detection algorithm**:
  1. Convert the frog's and vehicles' pixel coordinates to grid coordinates.
  2. Compare the frog's grid position to occupied cells in the 2D array.
  3. If a match is found, register a collision.

- **Handling Multiple Collisions**: In cases where the frog may collide with more than one vehicle simultaneously, the first detected collision is prioritized based on game logic, such as triggering a level reset.

### Truth table for collision detection

| **Frog grid position (X, Y)** | **Vehicle 1 position (X, Y)** | **Vehicle 2 position (X, Y)** | **Collision detected?** |
|-------------------------------|-------------------------------|-------------------------------|-------------------------|
| (5, 3)                        | (5, 3)                        | (7, 2)                        | Yes                     |
| (4, 2)                        | (6, 2)                        | (8, 3)                        | No                      |
| (3, 1)                        | (3, 1)                        | (9, 4)                        | Yes                     |
| (10, 6)                       | (2, 3)                        | (10, 6)                       | Yes                     |
| (7, 2)                        | (5, 3)                        | (6, 2)                        | No                      |

## 7. Game Mechanisms

- **State management**: The game operates using a finite state machine with states for playing, level progression, and game over. Transitions are based on events like reaching the top row, completing the final level, or colliding with a vehicle.

| **Current state** | **Event**                       | **Next state**      | **Action**                              |
|-------------------|---------------------------------|---------------------|----------------------------------------|
| Playing            | Collision detected             | Game Over           | Reset frog position, display "GG"      |
| Playing            | Frog reaches top (Level < 8)   | Level Progression   | Increment level, increase difficulty   |
| Level Progression  | Level reaches 8                | Game Over           | Display "GG" on screen and 7-segment   |
| Game Over          | Reset button pressed           | Playing             | Restart game from level 1              |

- **Level scaling**: The game features 8 levels, with increasing difficulty as the player progresses. Each level adjusts the number of vehicles, their types, and speeds.

### Speed table

| Levels | **Car speed** | **Bus speed** | **Truck speed** |
|--------|---------------|---------------|-----------------|
| 1      | 2 cells/s     | None          | None            |
| 2      | 2.5 cells/s   | None          | None            |
| 3      | 3 cells/s     | 1 cell/s      | None            |
| 4      | 3 cells/s     | 1 cell/s      | None            |
| 5      | 3 cells/s     | 2 cells/s     | 2 cells/s       |
| 6      | 3.5 cells/s   | 2 cells/s     | 2 cells/s       |
| 7      | 3.5 cells/s   | 2.5 cells/s   | 2.5 cells/s     |
| 8      | 4 cells/s     | 2.5 cells/s   | 3 cells/s       |
<!-- | 9      | 4 cells/s     | 3 cells/s     | 3 cells/s       |
| 10     | 4.5 cells/s   | 3.5 cells/s   | 3.5 cells/s     | -->

### Spacing table

| **Levels** | 1   | 2   | 3   | 4   | 5   | 6   | 7    | 8    |
|------------|-----|-----|-----|-----|-----|-----|------|------|
| Car        | 5   | 4-6 | 3-5 | 2-5 | 4-6 | 5   | 5-6  | 5-7  |
| Bus        | -   | 4   | -   | 4   | 4   | 5   | 3-5  | 3-6  |
| Truck      | -   | -   | 3   | -   | 4   | 3-5 | 3-5  | 3-6  |

For more details about the spacing, the [design of the levels is available here](https://docs.google.com/spreadsheets/d/192H_l_FA7qSmk4Z7lmOYOKX7erZ45zHxe5udNauicEI/edit?gid=0#gid=0). It will show you the levels on the grid.

- **Score tracking**: Players earn points by progressing through levels, with each level completed adding 1 level to the score. The score is displayed on a pair of 7-segment displays. When level 8 is reached and completed, the score will stop increasing, and a "GG" (Good Game) message will be shown on the screen and 7-segment displays.

| **Event**                       | **Score Change** |
|---------------------------------|------------------|
| Frog reaches the top of the level | +1             |
| Level 8 completed              | Display "GG"     |
| Collision detected (Game Over)  | No change        |
| Game reset                      | Score reset to 0 |

- **Game progression**: Upon reaching level 8, the game will display "GG" on the VGA screen and the 7-segment display to indicate game completion.

- **Event handling**: Game events such as level completion and collisions trigger state transitions. The state machine prioritizes actions to maintain consistent game flow.

| **Event**                       | **Trigger**                       | **Game action**                           |
|---------------------------------|-----------------------------------|-------------------------------------------|
| Frog reaches top (Levels 1-7)   | Frog at top row                   | Increment level, reset frog, add score    |
| Frog reaches top (Level 8)     | Frog at top row                   | Display "GG" on screen and 7-segment      |
| Collision detected              | Frog position matches vehicle     | Trigger Game Over, reset frog             |
| Reset button pressed            | All directional buttons pressed   | Restart game from level 1                 |

## 8. Memory and Storage

- **FPGA resource utilization**:
  - **Block RAM usage**: Approximately 70% allocated for sprite storage. To manage memory efficiently, use compression techniques like Run-Length Encoding (RLE) for sprites and load only active frames.
  - **Logic elements**: LUTs and Flip-Flops are estimated to utilize 40-60% of the FPGA's logic resources.

- **Memory allocation strategy**:
  - **Sprite storage**: Use Block RAM to store compressed sprite data. Decompress on-the-fly as needed during gameplay to minimize memory consumption.
  - **Game state management**: Allocate memory for storing the game state, including the frog's position, vehicle data, and level status. Use registers for frequently accessed variables to improve performance.
  
- **Memory optimization techniques**:
  - **Double buffering**: Implement double buffering for the VGA controller to reduce flicker and ensure smooth sprite rendering.
  - **Selective loading**: Load sprite frames and data dynamically based on the game state. Avoid loading unused resources to conserve memory.
  - **Data compression**: Apply RLE or other compression algorithms to reduce the size of stored graphics and animation data.

- **Handling memory constraints**:
  - **Prioritize critical data**: Reserve memory for essential game assets like the frog, vehicles, and background. Secondary assets, such as optional animations, should be stored in external memory if available.
  - **Monitor resource usage**: Use FPGA tools to track memory usage during development and adjust resource allocation as needed to prevent overflow.

## 9. Input/Output Management

- **Button inputs**:
  - **Directional buttons**: Four buttons control frog movement (up, down, left, right). Each press moves the frog by one cell (32x32 pixels) on the grid.
  - **Debouncing**: Implement a 10 ms debouncing delay to ensure reliable button detection, preventing multiple triggers from a single press.
  - **Reset functionality**: Triggered by pressing all four directional buttons simultaneously, resetting the game to level 1 and score to zero.

- **Pin mapping**:
  - **Up**: SW1
  - **Down**: SW2
  - **Left**: SW3
  - **Right**: SW4
  - **Reset**: All four switches pressed together

- **VGA output**:
  - **Resolution**: 640x480 with support for 512 colors (3-bit color depth per RGB channel).
  - **Sprite rendering**: Handles real-time sprite rendering for the frog, vehicles, and "GG" display during game completion.
  - **Double buffering**: Utilized to reduce flicker and ensure smooth transitions on the display.

- **7-Segment display**:
  - **Score display**: Shows the player's score by displaying the current level number plus 1 (e.g., Level 3 displays "3").
  - **Game completion indicator**: Displays "GG" on reaching level 8, signaling game completion.

- **Event handling**:
  - **Input mapping**: Button inputs are mapped directly to frog movements and game state changes.
  - **Output synchronization**: Updates to the VGA display and 7-segment display are synchronized with game events to reflect real-time changes.

## 10. Constraints and Limitations

- **Grid size**: The game uses a 20x15 grid, with each cell measuring 32x32 pixels, resulting in a total resolution of 640x480 pixels. Movement is restricted to within these boundaries.

- **Color limitations**: The VGA display supports 512 colors, with a 3-bit depth for each RGB channel, limiting the color range for sprites and backgrounds.

- **Memory constraints**:
  - **Block RAM usage**: With approximately 70% of Block RAM allocated for sprite storage, the available memory must be managed carefully to avoid exceeding capacity.
  - **Compressed assets**: Use compression techniques such as RLE to optimize memory usage, especially for animations and larger sprite data.

- **Input handling limitations**:
  - **Debouncing delay**: The 10 ms debouncing introduces a minor delay between button press and action, which may affect rapid input sequences.
  - **Reset mechanism**: The requirement to press all four buttons simultaneously to reset may not be intuitive for all users.

- **FPGA resource utilization**:
  - **Logic elements**: LUTs and Flip-Flops usage is estimated to be 40-60% of the FPGA's resources. Developers must ensure the implementation remains within these limits to avoid resource overflows.

- **Game state management**:
  - **Score display**: The 7-segment display can only show numerical scores up to 8. Non-numerical indicators like "GG" are limited to simple letters.

- **Performance considerations**:
  - **Frame rate**: The game operates at a fixed refresh rate of 60 Hz. Frame rate drops may occur if resource utilization approaches the FPGA's limits.
  - **Collision detection frequency**: Collision checks are performed at each frame, potentially impacting performance if too many objects are present simultaneously.

## 11. Testing and Validation

- **Simulation**:
  - **FPGA simulation tools**: Use tools like ModelSim or Vivado to simulate individual modules (e.g., frog movement, VGA output) and verify their behavior before integration.
  - **Waveform analysis**: Perform waveform analysis to check timing, signal transitions, and ensure correct operation of game logic.

- **On-board testing**:
  - **Functional tests**: Test gameplay functionality, including frog movement, collision detection, level progression, and VGA output, across all 8 levels.
  - **Stress tests**: Increase the number of vehicles and speed settings to check for performance issues such as frame drops or input lag.
  - **Boundary tests**: Verify that the frog cannot move outside the grid boundaries and that all game resets function as expected.

- **Debugging tools**:
  - **LED indicators**: Use onboard LEDs to display the current game state, such as active level or collision events, for debugging purposes.
  - **UART output**: Implement serial communication via UART to send debug logs and variable values during testing.

- **Validation criteria**:
  - **Gameplay accuracy**: Verify that all game rules are followed correctly, including level completion requirements and score calculation.
  - **Visual output consistency**: Ensure that the VGA display refreshes at a stable 60 Hz, and all sprites render correctly without flickering.
  - **Memory usage checks**: Monitor memory usage during gameplay to confirm that memory constraints are not exceeded.

- **Automated testing**:
  - **Regression testing**: Develop automated tests to check for unintended changes in game behavior after updates.
  - **Continuous integration (CI)**: Use CI tools to run tests automatically on code commits, ensuring that all functionalities remain stable.

- **Full test plan and test cases**:
  - The complete [test plan](./TestPlan.md) and [test cases](./TestCases.md) documents provides detailed descriptions of all tests, including steps, expected results, and success criteria.

## 12. Development Stages

1. **Initial setup**:
   - **Objective**: Set up the development environment, including FPGA tools, repository, and hardware connections.
   - **Tasks**:
     - Configure Apio or other FPGA toolchains.
     - Verify Go Board connections and VGA output.

2. **Basic functionality**:
   - **Objective**: Implement the core game elements to ensure basic gameplay is possible.
   - **Tasks**:
     - Develop and test the basic frog movement on a grid.
     - Display a static background using VGA output.
     - Implement button input handling and debouncing.

3. **Level progression and collision detection**:
   - **Objective**: Add logic for level transitions and detect collisions.
   - **Tasks**:
     - Implement level progression when the frog reaches the top.
     - Add collision detection with vehicles and trigger game over conditions.
     - Update score tracking and level display on the 7-segment display.

4. **Vehicle movement and pattern implementation**:
   - **Objective**: Introduce moving vehicles and adjust their speeds for different levels.
   - **Tasks**:
     - Implement vehicle movement logic and direction control.
     - Adjust vehicle speed and spacing based on the current level.
     - Test for visual accuracy and ensure collisions are detected properly.

5. **Advanced gameplay features**:
   - **Objective**: Add final gameplay features for a complete experience.
   - **Tasks**:
     - Introduce animations for the frog and vehicles.
     - Implement the "GG" display for game completion.
     - Finalize all game rules and visual feedback.

6. **Optimization and memory management**:
   - **Objective**: Ensure efficient resource usage and address any performance issues.
   - **Tasks**:
     - Optimize memory allocation for sprites and animations.
     - Test with different memory compression techniques.
     - Fine-tune game performance to maintain a consistent frame rate.

7. **Testing and debugging**:
   - **Objective**: Conduct comprehensive testing to ensure all functionalities are working correctly.
   - **Tasks**:
     - Perform unit tests, integration tests, and system tests.
     - Utilize debugging tools (LEDs, UART) for error detection.
     - Address any bugs or issues identified during testing.

8. **Final integration and deployment**:
   - **Objective**: Finalize the project for submission and demonstration.
   - **Tasks**:
     - Conduct a final review of code and documentation.
     - Prepare for project presentation and deployment on the Go Board.
     - Perform final testing on the hardware to ensure all features work as expected.

## 13. Developer Setup Guide

### 13.1 Prerequisites

- **Hardware requirements**:
  - Go Board FPGA development board
  - VGA monitor
  - Computer running macOS, Windows, or Linux
- **Software requirements**:
  - Python 3.10 or higher
  - Apio (FPGA toolchain)
  - Git
  - Homebrew (for macOS)

### 13.2 Setup Instructions

#### macOS setup

1. **Accept the Xcode license**.
2. **Install Homebrew** (if not already installed).
3. **Install Git** using Homebrew.
4. **Install Python 3.10 or higher** via Homebrew.
5. **Install Apio** using pip.
6. **Add Apio to the PATH** to ensure it's accessible.
7. **Clone the Frogger Project repository** and navigate to the project directory.
8. **Initialize Apio configuration**.
9. **Upload the game to the Go Board**.

#### Windows setup

1. **Install Python 3.10 or higher** and ensure "Add Python to PATH" is selected.
2. **Install Apio** using pip.
3. **Clone the Frogger Project repository** and navigate to the project directory.
4. **Initialize Apio configuration**.
5. **Upload the game to the Go Board**.

#### Linux setup

1. **Install Python 3.10 or higher**:
   - Use your package manager (e.g., apt, yum) based on the distribution.
2. **Install Git** with the appropriate package manager.
3. **Install Apio** using pip.
4. **Add Apio to the PATH** to ensure it's accessible.
5. **Clone the Frogger Project repository** and navigate to the project directory.
6. **Initialize Apio configuration**.
7. **Upload the game to the Go Board**.

### 13.3 Automated setup script requirements

The setup script is written in **Bash** to support Unix-like environments, including **macOS and Linux**. For **Windows**, a separate script or manual setup is recommended.

The script must:
1. **Verify existing requirements before installation**: 
   - Before attempting to install any software or dependencies, the script should check if the required component is already installed and configured correctly. If it is, the script should skip the installation and proceed to the next step.
   - This approach ensures that the script does not reinstall software unnecessarily and preserves the existing configurations on the developer's system.

2. **Handle each requirement separately**:
   - The script must check for the following components individually:
     - **Python 3.10 or higher**: Verify that the installed version meets the minimum requirement.
     - **Git**: Ensure Git is available in the system.
     - **Apio**: Check if Apio is installed and accessible in the PATH.

3. **Automate the setup process in Bash**:
   - The script should be written in **Bash** to be compatible with **macOS and Linux** environments. 
   - The script can use system package managers like **Homebrew** on macOS, **apt** on Debian-based Linux, or **yum** on Red Hat-based Linux to install the necessary components.
   - For Python packages, the script should use **pip** to handle Apio installation.

4. **Provide feedback to the user**:
   - The script should output informative messages to the user, indicating whether a requirement is already satisfied or if it is being installed. This feedback ensures that users are aware of the setup progress.

## 14. Future Plans
- **Audio integration**: Add simple sound effects, such as a sound when the frog hops, vehicle collisions, and level completions.

- **Vehicle movement patterns**: While the vehicle movements follow predetermined patterns, adding some random variation in the spawn timing or vehicle speed could increase the challenge.

- **Enhanced collision feedback**: Incorporate visual or auditory feedback when collisions occur to enhance player experience. Simple visual effects (like flashing sprites) could be a good start.

- **Dynamic difficulty adjustment**: Beyond simple speed increases, consider adding new obstacles or changing the layout dynamically as levels progress to keep the gameplay engaging.

# Sources
1. [The Go Board - FPGA Development](https://nandland.com/the-go-board/)  
   - A resource for learning about the Go Board FPGA development board, including specifications, tutorials, and project ideas.

2. [Getting Started with FPGA](https://nandland.com/book-getting-started-with-fpga/)  
   - A guide that covers the basics of FPGA programming, including VHDL/Verilog languages, and hardware design principles.

3. [Hardware Sprites in FPGA](https://projectf.io/posts/hardware-sprites/)  
   - Discusses implementing hardware-based sprites on FPGAs, including memory management techniques for sprite rendering.

4. [FPGA Architecture Reference Manual](./Images/Go_Board_V1.pdf)
   - A detailed reference for FPGA architecture, covering different FPGA components, including Block RAM, LUTs, and Flip-Flops. (This might be a physical or digital manual depending on the FPGA you're using.)

# Footnotes

[^1]: Block RAM (BRAM): A dedicated memory block within FPGAs used to store large data, such as sprites for video games.
[^2]: Flip-Flops (FF): Digital circuits used in FPGAs for storing binary data.
[^3]: Look-Up Tables (LUTs): Perform boolean functions within FPGAs.
[^4]: Debouncing: Ensures clean signal generation for button presses.
[^5]: VGA Controller: Manages visual data output to a VGA display.
[^6]: Grid-based Movement: Movement based on a fixed grid structure.
[^7]: Collision Detection: Determines if two game objects occupy the same grid space.
[^8]: Sprite: A 2D image used for game characters or objects.
[^9]: Game Clock: Manages timing for game events.
[^10]: 7-Segment Display: Displays decimal numerals using seven segments.
[^11]: System Architecture: The structured framework defining system components.
[^12]: Reset Mechanism: Clears the game state and returns to initial conditions.
[^13]: Level Management: Tracks player progression through game levels.
[^14]: VGA Palette (3-bit Color): Supports a 512-color palette with 3-bit depth per color channel.
