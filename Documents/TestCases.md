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
| Expected Test Result | The game system initializes the first level. The frog appears at the starting position at the bottom of the screen. The level counter is set to 1 |
| Test Priority | 3 |
| Tested? | yes |

#### Stop the game

| Number | Two |
| --- | --- |
| Test Description | Verify that the game stops and that the screens goes black |
| Requirement(s) | The game is started |
| Step(s) | 1. Press all four buttons at the same time |
| Expected Result | The game system initializes the first level. The frog appears at the starting position at the bottom of the screen. |
| Priority | 3 |
| Tested? | no |

#### Frog moves up

| Number | Three |
| --- | --- |
| Test Description | Verify that the frog moves up when the up button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the up button |
| Expected Result | The frog moves up |
| Priority | 3 |
| Tested? | yes |

#### Frog moves down

| Number | Four |
| --- | --- |
| Test Description | Verify that the frog moves down when the down button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the down button |
| Expected Result | The frog moves down |
| Priority | 3 |
| Tested? | yes |

#### Frog moves left

| Number | Five |
| --- | --- |
| Test Description | Verify that the frog moves to the left when the left button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the left button |
| Expected Result | The frog moves to the left |
| Priority | 3 |
| Tested? | yes |

#### Frog moves right

| Number | Six |
| --- | --- |
| Test Description | Verify that the frog moves to the right when the right button is pressed |
| Requirement(s) | The game is started |
| Step(s) | 1. Press the right button |
| Expected Result | The frog moves to the right |
| Priority | 3 |
| Tested? | yes |

#### Frog dies to a car

| Number | Seven |
| --- | --- |
| Test Description | Verify that the frog "dies" when hit by a car|
| Requirement(s) | The game is started |
| Step(s) | 1. Get hit by a car |
| Expected Result | The game system initializes the first level. The frog appears at the starting position at the bottom of the screen. |
| Priority | 3 |
| Tested? | no |

#### Frog edgemap collision.

| Number | Eight |
| --- | --- |
| Test Description | Verify that the frog cannot move past the edges of the screen|
| Requirement(s) | The game is started |
| Step(s) | 1. Move the frog to the bottom, left or right edge of the screen, 2. Try to go past the wall|
| Expected Result | The Frog is stopped by the edge of the screen and doesn't move |
| Priority | 3 |
| Tested? | yes |

#### Victory
| Number | Nine |
| --- | --- |
| Test Description | Verify that when the frog gets to the top of the screen, the level ends |
| Requirement(s) | The game is started |
| Step(s) | 1. Successfully bring the frog to the top of the screen without getting hit by a car |
| Expected Result | The game system initializes the next level (if it was level 1 we go to level 2 for example). The frog appears at the starting position at the bottom of the screen. |
| Priority | 3 |
| Tested? | yes |

#### Level Counter Incrementation
| Number | Ten |
| --- | --- |
| Test Description | Verify that the level counter increments when it should |
| Requirement(s) | The game is started |
| Step(s) | 1. Successfully bring the frog to the top of the screen without getting hit by a car |
| Expected Result | The level counter is incremented by 1 |
| Priority | 2 |
| Tested? | yes |

#### Level Counter Reset on death
| Number | Eleven |
| --- | --- |
| Test Description | Verify that the level counter resets when it should |
| Requirement(s) | The game is started |
| Step(s) | 1. Get hit by a car|
| Expected Result | The level counter resets back to 1 |
| Priority | 1 |
| Tested? | no |

#### Level Counter Reset on button combination pressed
| Number | Twelve |
| --- | --- |
| Test Description | Verify that the level counter resets when it should |
| Requirement(s) | The game is started |
| Step(s) | 1. press all four buttons at the same time. |
| Expected Result | The level counter resets back to 1 |
| Priority | 1 |
| Tested? | no |

#### Car movement
| Number | Thirteen |
| --- | --- |
| Test Description | Verify that cars move as intended |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Wait |
| Expected Result | The Cars should be moving  horizontally across the screen|
| Priority | 3 |
| Tested? | yes |

#### Car gets to the edge
| Number | Fourteen |
| --- | --- |
| Test Description | Verify that cars can despawn |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Wait |
| Expected Result | Cars should despawn once they reach the edge of the screen and spawn back on the other side.|
| Priority | 3 |
| Tested? | yes |

#### Frog move only one tile
| Number | Fifteen |
| --- | --- |
| Test Description | Verify that the frog only moves one square per button press |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game 2. Hold a movement button |
| Expected Result | The frog should move one tile and stay idle |
| Priority | 3 |
| Tested? | yes |
