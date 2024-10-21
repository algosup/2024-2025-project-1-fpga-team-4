# Team 4 Frogger<sup><a href="#4">[4]</a></sup> Test plan

## Table-of-Contents
- [Test Plan](#test-plan)
  - [1. Introduction](#1-Introduction)
    - [1.1 Overview](#.1-Overview)
    - [1.2 Targeted audience](#.2-Targeted-audience)
      - [1.2.1 Old players](#.2.1-Old-players)
      - [1.2.2 New players](#.2.2-New-players)
      - [1.2.3 Hardcore gamers](#.2.3-Hardcore-gamers)
  - [2. Glossary](#2-Glossary)
  - [3. Testing](#3-testing)
    - [3.1 Scope](#.1-Scope)
    - [3.2 Testing strategy](#.2-Testing-strategy)
      - [3.2.1 Basic fuctionnalities/smoke test](#.2.1-Basic-fuctionnalities/smoke-test)
      - [3.2.2 Game mechanics](#2.2-Game-mechanics)
  - [4. Testing environment](#4-Testing-environment)
    - [4.1 Hardware](#.1-Hardware)
    - [4.2 Software](#.2-Softwaere)
    - [4.3 Simulation](#.3-Simulation)
  - [5. Test Deliverables](#5-test-deliverables)
    - [5.1 Test-cases](#.1-test-cases)
    - [5.2 Bug-reports](#.2-Bug-reports)

1. ***Introduction***
\
    1.1 **Overview**
    This test plan is for the recreation of the Frogger<sup><a href="#4">[4]</a></sup> game coded on the *Nandland Go Board*<sup><a href="#1">[1]</a></sup>  by team 4 using Verilog<sup><a href="#3">[3]</a></sup>. It will detail the tests done to ensure that the game runs as expected.
\
    1.2 **Targeted audience**
    Depending on what audience our game is targeting, it has to respond to different needs
\
    1.2.1 **Old Players**
    The most likely people to play a Frogger<sup><a href="#4">[4]</a></sup> recreation are people who played it in their childhood, or hardcore gamers who started with Frogger<sup><a href="#4">[4]</a></sup>. They are looking for a game that plays well, the closer the game is to the original the better.
\
    1.2.2 **New Players**
    Maybe the old players will want their children to experience what they did all those years ago, or these new players simply want to see what video games were like back in the day. No matter the reason, new players need a simple and working game.
\
    1.2.3 **Hardcore Gamers**
    These can be speedruners or challenge runners but for these guys need the game to have no latency and no problems with collisions. They also need to be able to mash buttons without the game crashing.
\
    1.3 **Criteria**
    Before the game is shipped, several checks need to be fulfilled:
\
    1.3.1 **Priority Coverage**
    All the tests with a priority of 3 need to be validated before the game is shipped as they are the most important features
\
    1.3.2 **Documentation review**
    All relevant documents: test plan, test cases, technical specifications, functional specifications, user manual and the readme must be completed and reviewed.
    These documents must be free of spelling mistakes 
    


2. ***Glossary***

    | Term | Definition | Source |
    | ---- | ---------- | ------ |
    | <a id="1">[1]</a> **Nandland Go Board** | An FPGA<sup><a href="#2">[2]</a></sup> board made by Russel Merrick. It has many peripherals and was created to help people learn and understand FPGA's<sup><a href="#1">[2]</a></sup> and their programming languages easier.| [Nandland](https://nandland.com/the-go-board/) |
    | <a id="2">[2]</a> **FPGA** | A Field-programmable gate array (FPGA) Is a type of internal circuit that can be reprogrammed after manufacturing. | [Wikipedia](https://en.wikipedia.org/wiki/Field-programmable_gate_array) |
    | <a id="3">[3]</a> **Verilog** | A programming language used for hardware to model electronic systems,  | [Wikipedia](https://en.wikipedia.org/wiki/Verilog) |
    | <a id="4">[4]</a> **Frogger** | Frogger is an old game where a frog has to cross the road while avoiding the cars | [Wikipedia](https://en.wikipedia.org/wiki/Frogger) |
    | <a id="5">[5]</a> **GitHub** | A web-based version control and collaboration platform for software developers. | [Wikipedia](https://en.wikipedia.org/wiki/GitHub) |
    | <a id="6">[6]</a> **Visual Studio Code** | A free source-code editor made by Microsoft for Windows, Linux, and macOS. | [Wikipedia](https://en.wikipedia.org/wiki/Visual_Studio_Code) |
    | <a id="7">[7]</a> **Smoke test** | A smoke test is a test which checks basic functionalities | [Wikipedia](https://en.wikipedia.org/wiki/Smoke_testing_(software)) |

3. ***Testing***
\
    3.1 **Scope**
    The tests performed will be mostly focused on the gameplay as it is the most important part of the project, a game can be the most beautiful thing ever created, if it's unplayable, its worthless. Features such as sprites and animations will be tested last as they are not instrumental to the project.
\
    3.2 **Testing strategy**
    Due to the fact that frogger<sup><a href="#4">[4]</a></sup> is rather simple, we will test the game manually as there will not be too many features we need to test, thus it will not be too time consuming. We will start by running a smoke test<sup><a href="#7">[7]</a></sup> to check basic functionnalities. When it is successful, we will do more in depth tests to see if the rest of the game works as intended.
\
    3.2.1 **Basic fuctionnalities/smoke<sup><a href="#7">[7]</a></sup> test**
    - **Go-Board/screen detection** The Go-Board should detect and be able to interact with the screen
    - **Game Start** The game should launch
    - **Game Reset** The game should be able to close when prompted
    - **Go-Board input detection** The Go-Board should be able to detect if we are clicking it's buttons
    - **Frog Spawn** Every time a level starts, the frog should spawn in the bottom middle of the screen. Every time a level ends, the frog should despawn.
    - **Cars Spawn** Every time a level starts, some cars should spawn as indicated in the Functional specifications. Every time a level ends, cars should despawn.
\
    3.2.2 **Game mechanics**
    - **Frog Movement** Every time a button is pressed on the *Nanland Go Board*, the frog should move in the corresponding direction.
    - **Car Movement** Cars are supposed to move horizontally from one side of the screen to the other.
    - **Frog/Car Collisions** The frog needs to "die" if hit by a car, this death will result in a reset of the level counter and difficulty curve.
    - **Frog/Goal Collision** The level needs to end if the frog touches the goal. In that case, the level counter should be increased by one, the frog should be placed back at it's starting point and the new level will be harder
    - **Number of Cars** there can be no more than 16 cars in total
    - **Car Specifications** The cars can go at differents speeds and can be of different sizes.
    - **Level Counter Behavior** The level counter should increase by one every time the frog reaches the top of the screen. It should also go back down to zero if the player dies
    - **Level Counter Maximum** Once the player wins level 8, the screen and the display on the *Nanland Go Board* should show "GG". After any input from the player, the game should be reset to level 00. 



4. ***Test Environnment***
    4.1 **Hardware**
        Everything will be tested using the *Nanland Go-Board* and an Acer 24.5" monitor.
\
    4.2 **Software**
        We will be using Visual Studio Code<sup><a href="#6">[6]</a></sup> with a Verilog<sup><a href="#3">[3]</a></sup> extension to code and test. Everything will be documented on github<sup><a href="#5">[5]</a></sup>.
\
    4.3 **Simulation**
        To test the code, we will need to run simulations, we will be using: [EDA Playground](https://edaplayground.com)

5. ***Test deliverables***

    5.1 **Test-cases**
        Every test will be recorded in the [TestCases.md](TestCases.md). document. Each test will have a name, a description, an expected behavior and the steps necessary for the testing.
        Except for the first test case in which the way to start the game is detailed, we will assume that, for the rests of the tests, the game is already started unless the opposite is specified.
\
    5.2 **Bug reports**
        If a bug or something similar is detected during testing a bug report will be written and sent to the software developpers. They will then work on fixing the bug.
