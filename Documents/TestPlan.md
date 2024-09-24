# Team 4 Frogger Test plan
This test plan is for the recreation of the Frogger game coded on the *Nandland Go Board*  by team 4 using Verilog. We will test to make sure that the game runs as expected thanks to this testing.

1. ***Glossary***

    | Term | Definition | Source |
    | ---- | ---------- | ------ |
    | **Nandland Go Board** | A FPGA board made by Russel Merrick. It has many peripherals and was created to help people learn and understand FPGA's and their programming languages easier.| [Nandland](https://nandland.com/the-go-board/) |
    | **FPGA** | A Field-programmable gate array (FPGA) Is a type of internal circuit that can be reprogrammed after manufacturing. | [Wikipedia](https://en.wikipedia.org/wiki/Field-programmable_gate_array) |
    | **Verilog** | A programming language used for hardware to model electronic systems,  | [Wikipedia](https://en.wikipedia.org/wiki/Verilog) |
    | **Frogger** | Frogger is an old game where a frog has to cross the road while avoiding the cars | [Wikipedia](https://en.wikipedia.org/wiki/Frogger) |
    | After that is stuff I copy pasted so is subject to change | I'm not sure all of them will be useful| [Source](https://www.youtube.com/watch?v=uKeKuaJ4nlw) |
    | **GitHub** | A web-based version control and collaboration platform for software developers. | [Wikipedia](https://en.wikipedia.org/wiki/GitHub) |
    | **GitHub Actions** | A CI/CD tool that allows us to run tests automatically after various actions on the repository and avoid errors on the dev or main branch. | [GitHub](https://docs.github.com/en/actions) |
    | **GitHub Issues** | A tool that allows us to create and manage issues and assign them to team members. | [GitHub](https://docs.github.com/en/issues) |
    | **Visual Studio Code** | A free source-code editor made by Microsoft for Windows, Linux, and macOS. | [Wikipedia](https://en.wikipedia.org/wiki/Visual_Studio_Code) |
2. ***Testing***
    **Testing strategy**
    Due to the fact that frogger is rather simple, we will test the game manually as there will not be too many features we need to test, thus it will not be too time consuming. We will start by running a smoke test to check basic functionnalities. When it is successful, we will do more in depth tests to see if the rest of the game works as intended.

    **Basic fuctionnalities/smoke test**
    - **Go-Board/screen detection** The Go-Board should detect and be able to interact with the screen
    - **Game Start** The game should launch
    - **Game Exit** The game should be able to close when prompted
    - **Go-Board input detection** The Go-Board should be able to detect if we are clicking it's buttons
    - **Frog Spawn** Every time a level starts, the frog should spawn in the bottom middle of the screen. Every time a level ends, the frog should despawn.
    - **Cars Spawn** Every time a level starts, some cars should randomly spawn in the center of the screen, facing sideways. There should be at most one per lane and not every lane should be filled. Every time a level ends, cars should despawn.

    **Game mechanics tests**
    - **Frog Movement** Every time a button is pressed on the *Nanland Go Board*, the frog should move in the corresponding direction.
    - **Car Movement** Cars are supposed to move horizontally from one side of the screen to the other.
    - **Frog/Car Collisions** The frog needs to "die" if hit by a car, this death will result in a reset of the level counter and eventual difficulty curve.
    - **Frog/Goal Collision** The level needs to end if the frog touches the goal. In that case, the level counter should be increased by one, the frog should be placed back at it's starting point and the new level could be made harder
    - **Number of Cars** there can only be one car per lane
    - **Car Specifications** The cars can go at differents speeds and can be of different sizes, they could become faster or bigger in later levels.
    - **Level Counter Behavior** The level counter should increase by one every time the frog reaches the top of the screen. It should also go back down to zero if the player dies
    - **Level Counter Maximum** Once the player wins level 99, the screen and the display on the *Nanland Go Board* should show "GG". After any input from the player, the game should be reset to level 00.
    - *From here on out it's unsure if these features will be added*
    - **Pause button pressed** When the pause button is pressed, the cars should stop moving, the positions need to be retained, any eventual music should stopped and the movement buttons should be disabled. If the game was already paused, the cars should start moving again, the music should resume and the movement buttons should function again. 

3. ***Test deliverables***
    1. **test-cases**
        Every test will be recorded in the Test-Cases.md documents. Each test will have a name, a description, an expected behavior and the steps necessary for the testing.
    2. **Bug reports**
        If a bug or something similar is detected during testing a bug report will be written and sent to the software developpers. We will then work on fixing the bug.
    3. **
