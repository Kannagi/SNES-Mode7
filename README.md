# SNES Demo Mode 7
<img src="screenshot.png?raw=true" alt="Demo Mode 7 Screenshot" width="512" height="448">


## Notes
binary snesm7 precalculation values for mode 7, the calculation is not yet implemented on the SNES code.

In the demo you can make a 'zoom' with L and R, but for that the zoom is correct it is necessary to calculated during the game.


### Requirements
Building the demo from the source code requires:
- wla-dx
- GNU Make

### How to Build
- bash snes.sh
- gcc main.c -o snesm7
