# Functional Specifications | Team 4

<details>
<summary>Table of Contents</summary>

- [Functional Specifications | Team 4](#functional-specifications--team-4)
    - [I. Project Overview](#i-project-overview)
        - [Stakeholders](#stakeholders)
        - [What is Frogger](#what-is-frogger)
        - [How to play](#how-to-play)
    - [II. Game Mechanics](#ii-game-mechanics)
        - [Controls Mechanics](#controls-mechanics)
        - [Map and Cars Mechanics](#map-and-cars-mechanics)
            - [1. Bottom Half - The Road](#bottom-half---the-road)
            - [2. Top Half - The River](#top-half---the-river)
        - [Life system](#life-system)
        - [Score](#score)
    - [III. Designs/Graphic charter](#iii-designsgraphic-charter)
    - [IV. Use Cases](#iv-use-cases)
    - [V. Project scope](#v-project-scope)
    - [VI. Test Plan](#vi-test-plan)
    - [VII. Success Criteria](#vii-success-criteria)
    - [VIII. Legal Stuff](#viii-legal-stuff)
    - [IX. Glossary](#ix-glossary)
</details>

---

## I. Project Overview

The goal of the project is to remake the old retro game "Frogger" using a Go Board [^1] from Nandland.

#### Stakeholders

| Stakeholder                             | Role & Tasks             |
|-----------------------------------------|--------------------------|
|ALGOSUP                                  | Client                   |
|Jason	GROSSO	                          |Project Manager           |
|Mathis	PASCUCCI	                      |Program Manager           |
|Clémentine	CUREL	                      |Technical Lead            |
|Guillaume	DERAMCHI	                  |Software Engineer 1       |
|Victor	LEROY	                          |Software Engineer 2       |
|Emilien	CHINSY	                      |Quality Assurance         |
|Ian	LAURENT	                          |Technical Writer          |

#### What is Frogger

Frogger is a 1981 arcade game, developed by Konami and published by Sega, which was really popular at its time and was said to be "one of the greatest video game ever made"

#### How to play

The goal of the game is to direct five frogs to their homes by dodging traffic on a road.
The frogs start at the buttom of the screen and the player must guide the frog at the top of the screen, across the opposite lanes of traffic without getting killed by cars.

---
## II. Game Mechanics

#### Controls Mechanics
The player controls are four different buttons that are used to navigate the frog, each button causes the frog to hop once in that direction, switch 1 = up, switch 2 = down, switch 3 = left and switch 4 = right. 

On the bottom of the screen the player must guide the frog between opposing lanes of trucks, cars, and other vehicles, to avoid dying.

#### Map and Cars Mechanics 

The map of the Frogger game is divided into two main horizontal sections:

1. ##### Bottom Half - The Road:

    - The bottom part serves as the starting area for the player.
    - This section of the map represents a busy highway filled with multiple lanes of moving vehicles.
    - Vehicles include different types of cars and trucks of varying speeds and sizes. They move horizontally from left to right or right to left across the screen.
   
2. ##### Top Half - The River:



#### Life system
The player starts the game with 5 frogs, so five lives. When the frog dies, the player loses one of his five lives and when the lives counter drops to zero the score resets and the game restarts.

#### Score
When the player reaches the top of the screen, his score is updated and a point is added to it. 

The player's goal is to reach the maximum score of 99 points without dying. After reaching the maximum score the game stops and the letters "GG" are displayed on the board.

---

## III. Designs/Graphic charter

---

## IV. Use Cases

| Use Case Number | Name | Description | Actor(s) | Pre-Conditions | Flow of Events | Post-Conditions | Exit Criteria | Notes & Issues |
|---|---|---|---|---|---|---|---|---|
| N°1 | Start Game | The player starts the game | Player, Game System | The game is installed and launched | -Player presses "Start".<br>-The game system initializes the level.<br>-The frog appears at the starting position at the bottom of the screen.<br>-Game system begins movement of obstacles (cars, logs, etc.) | The player can control the frog; obstacles are in motion.|
| N°2 | Navigating through the road | The player interact with the game environment | Player, Game System | The game has started, and the player is controlling the frog | -The player presses the switch on the GO-Board to move the frog.<br>-The game system moves the frog in the indicated direction.<br>-The game system checks for collisions between the frog and moving cars/trucks. | The frog moves as directed by player inputs. |
| N°3 | Finishing a Level | Completing game's objectives | Player, Game System | The player successfully navigates the frog across both the road and the river | -The frog reaches the top of the screen. | The player's score is updated and the frog's postion is reset at the starting position. |
| N°4 | Dying | The player's charachter loses a life | Player, Game System | The frog has collided with an obstacle or fallen into water | -The frog collides with an obstacle.<br>-The game system detects the collision.<br>-The frog dies, and the game system deducts a life from the player's remaining lives.<br>-The frog respawns at the starting position. | The frog loses a life, and the player either respawns or the game ends. |
| N°5 | Win the Game | The player successfully reaches the score of 99 | Player, Game System | The player as reached the last level | -The player guides the frog to the end in the last level.<br>-The game system display the letters "GG" on the Go-Board. | The player wins the game and sees a victory screen? |
| N°6 | Game Over | Ending the game after losing all lives | Player, Game System | The player has no remaining lives | -The game system checks the player's remaining lives.<br>-When the last life is lost, the game transitions to a "Game Over" screen.<br>-The game displays the final score and a prompt to restart or quit the game? | The game ends, and the player sees the final score and game over message?

---

## V. Project scope

| In Scope |
|---|
|Delivering a clone of Frogger in Verilog[^2]|
|Go Board must be used to control the frog and display the score
|The game must have at least a win and a lose condition
|
|



| Out of Scope |
|---|
|
|
|


## VI. Test Plan
Anything relative to this project's tests can be found in [this document](./TestPlan.md).

---

## VII. Success Criteria
- The game display every element without any kind of stuttering
- The player can control the character without latency between the player action and game's reaction using the Go Board
- The player can progress amongst levels the same way as the original game
- The game does not return errors on launch
- The game does not crashes
- The player can loose and win if conditions are met.

---

## VIII. Legal Stuff

---

## IX. Glossary
[^1]: Go-Board: FPGA Development Board For Beginners.
[^2]: Verilog: A hardware description language (HDL) used to model electronic systems.


