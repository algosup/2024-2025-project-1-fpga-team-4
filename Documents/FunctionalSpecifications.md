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

</details>

---

## I. Project Overview

The goal of the project is to remake the old retro game "Frogger" using a Go Board from Nandland.

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
The player starts the game with 5 frogs, so five lives. When the frog dies, the player loses on of his five lives and when the lives counter drops to zero the score resets and the game restarts.

#### Score
When the player reaches the top of the screen, his score is updated and a point is added to it. 

The player's goal is to reach the maximum score of 99 points without dying. After reaching the maximum score the game stops and the letters "GG" are displayed on the board.

---