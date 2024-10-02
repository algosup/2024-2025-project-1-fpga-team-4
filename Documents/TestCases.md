# Team 4 Frogger Test Cases
This document logs every test that should and will be done to ensure that the game functions as intended.

## Priority
Test priorities are differenciated as such:
| Number | Priority |
| --- | --- |
| 1 | Low (If we can't test it on time, it's fine) |
| 2| Medium (Important but not critical) |
| 3| High (Critical, Should be tested ASAP) |

(From here on out, *Nanland Go Board* will be shortened to *board* or *the board*)

## Tests

#### Start the game

| Number | One |
| --- | --- |
| Test Description | Verify that the game starts and that the screen show the game |
| Requirement(s) | Everything is unplugged |
| Step(s) for testing | 1. Plug in *the Board*, 2. Plug in and switch the screen on, 3. Plug *the Board* to the screen, 4. Execute the code with *the Board*,  |
| Expected Test Result | The game starts |
| Test Priority | 3 |
| Tested? | no |

#### Stop the game

| Number | Two |
| --- | --- |
| Test Description | Verify that the game stops and that the screens goes black |
| Requirement(s) | The game is started |
| Step(s) | 1. Press all four buttons at the same time |
| Expected Result | The game stops |
| Priority | 3 |
| Tested? | no |

#### Start of level spawn

| Number | Three |
| --- | --- |
| Test Description | Verify that cars and the frog spawn as intended at the start of a level |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Wait|
| Expected Result | The frog spawns in the bottom middle of the screen, a couple of cars spawn on the road in the middle of the screen |
| Priority | 3 |
| Tested? | no |

#### Frog moves up

| Number | Four |
| --- | --- |
| Test Description | Verify that the frog moves up when the up button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the up button |
| Expected Result | The frog moves up |
| Priority | 3 |
| Tested? | no |

#### Frog moves down

| Number | Five |
| --- | --- |
| Test Description | Verify that the frog moves down when the down button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the down button |
| Expected Result | The frog moves down |
| Priority | 3 |
| Tested? | no |

#### Frog moves left

| Number | Six |
| --- | --- |
| Test Description | Verify that the frog moves to the left when the left button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the left button |
| Expected Result | The frog moves to the left |
| Priority | 3 |
| Tested? | no |

#### Frog moves right

| Number | Seven |
| --- | --- |
| Test Description | Verify that the frog moves to the right when the right button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the right button |
| Expected Result | The frog moves to the right |
| Priority | 3 |
| Tested? | no |

#### Frog dies to a car

| Number | Eight |
| --- | --- |
| Test Description | Verify that the frog "dies" when hit by a car|
| Requirement(s) | The game is started |
| Step(s) | 1. Get hit by a car |
| Expected Result |  The frog should be placed back at the start  |
| Priority | 3 |
| Tested? | no |

#### Frog edgemap collision.

| Number | Nine |
| --- | --- |
| Test Description | Verify that the frog cannot move past the edges of the screen|
| Requirement(s) | The game is started |
| Step(s) | 1. Move the frog to one of the edges of the screen, 2. Try to go past the wall|
| Expected Result | The Frog is stopped by the edge of the screen |
| Priority | 3 |
| Tested? | no |

#### Victory
| Number | Ten |
| --- | --- |
| Test Description | Verify that when the frog gets to the top of the screen, the level ends |
| Requirement(s) | The game is started |
| Step(s) | 1. Successfully bring the frog to the top of the screen without getting hit by a car |
| Expected Result | everything despawns, the frog spawns at the bottom middle of the screen and a couple of cars spawn along the roads in the center of the screen. |
| Priority | 3 |
| Tested? | no |

#### Level Counter Incrementation
| Number | Eleven |
| --- | --- |
| Test Description | Verify that the level counter increments when it should |
| Requirement(s) | The game is started |
| Step(s) | 1. Successfully bring the frog to the top of the screen without getting hit by a car |
| Expected Result | The level counter increments itself |
| Priority | 2 |
| Tested? | no |

#### Level Counter Reset
| Number | Twelve |
| --- | --- |
| Test Description | Verify that the level counter resets when it should |
| Requirement(s) | The game is started |
| Step(s) | 1. Get hit by a car|
| Expected Result | The level counter resets back to 01 |
| Priority | 1 |
| Tested? | no |

#### Car movement
| Number | Thirteen |
| --- | --- |
| Test Description | Verify that cars move as intended |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Wait |
| Expected Result | The Cars should be moving from horizontally across the screen|
| Priority | 3 |
| Tested? | no |

#### Car despawn
| Number | Fourteen |
| --- | --- |
| Test Description | Verify that cars can despawn |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Wait |
| Expected Result | Cars should despawn once they reach the edge of the screen|
| Priority | 3 |
| Tested? | no |

#### Car replacement
| Number | Fifteen |
| --- | --- |
| Test Description | Verify that new cars appear after the first ones leave |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Wait |
| Expected Result | Cars should appear on a lane soon after the old one despawns|
| Priority | 3 |
| Tested? | no |

#### Frog move only one tile
| Number | Sixteen |
| --- | --- |
| Test Description | Verify that the frog only moves one square per button press |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Hold a movement button |
| Expected Result | The frog should move one tile and stay idle |
| Priority | 3 |
| Tested? | no |
