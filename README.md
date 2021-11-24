# John Conway's Game of Life
## Overview
This is a Game of Life game proposed by John Conway, made in the Processing3 Language
Environment. I was inspired to make it after hearing about the program from the Numberphile video, [Inventing Game of Life - Numberphile](https://www.youtube.com/watch?v=R9Plq-D1gEk)

## Dependencies
* Processing3 (tested to v3.3.2 rev0270)

## Debugging
This program has been tested on Processing 3.3.2 revision 0259 without any issues.
If you run into any errors please make sure you are on this version because it is
known to work. If you still are having issues on the aforementioned version, just
send me a message on my [GitHub](https://github.com/mattdocherty314).

## Program Use
When the program is launched, the game is started in a paused state. Click a grayed
out cell (dead) to change it to a yellow (alive) cell. If you want to play/pause the
simulation just press the SPACE button. The following is a list of the rules (as
developed by John Conway):
1. &lt;2 neighbouring alive cells, cell dies of under population.
2. =3  neighbouring alive cells, cell is born.
3. &gt;3 neighbouring alive cells, cell dies of over population.

## Version History
### v1.0.0
* Added the base program

### v1.1.0
* Better code comments
* Optimised algorithm
* Cleaned up code
* Make into an EXE

### v1.2.0
* Fixed screen looping
* Added more UI to show game state

## TODO
* Add more controls
	* Remove cells
	* Change rules
	* Screen looping toggle