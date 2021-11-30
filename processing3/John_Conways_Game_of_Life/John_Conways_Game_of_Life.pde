Cell[][] allCells = new Cell[50][50];
ToggleSwitch pausedSwitch = new ToggleSwitch(725, 175, true);
ToggleSwitch loopSwitch = new ToggleSwitch(725, 225, true);
IncrDecrInput speedInput = new IncrDecrInput(760, 275, 2, 1, 9);

// Game parameters
int CELL_SIDE = allCells.length; // Amount of cells on a side
int CELL_SIZE = 700/CELL_SIDE; // Cell size

enum state {ALIVE, DEAD, BORN, DYING};

void setup() {
  size(1000, 700);
  strokeWeight(1);
  generateCells();
}

void draw() {
  background(220);
  if (!pausedSwitch.state) { // If in a run state
    cellLogic();
    delay(int(pow(2,speedInput.value)));
  }
  drawCells();
  drawInfo();
  pausedSwitch.render();
  loopSwitch.render();
  speedInput.render();
}

void keyPressed() { 
  if (keyCode == 32) { // SPACE = toggle run state
    pausedSwitch.toggle();
  }
  if ((key == 'l') || (key == 'L')) { // L = toggle loop
    loopSwitch.toggle();
  }
  if (key == '<') { // < = slow down
    speedInput.decr();
  }
  if (key == '>') { // > = speed up
    speedInput.incr();
  }
}

void mouseDragged() {
  clickCells();
}
void mousePressed() {
  clickCells();
  pausedSwitch.click();
  loopSwitch.click();
  speedInput.click();
}

/* Detect if a cell is clicked and make it alive if it is */
void clickCells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      if ((mouseX > i*CELL_SIZE)&&(mouseX < (i+1)*CELL_SIZE)&&(mouseY > j*CELL_SIZE)&&(mouseY < (j+1)*CELL_SIZE)) {
        if (mouseButton == 37) { // LEFT CLICK = alive
          allCells[i][j].convertAlive();
        }
        if (mouseButton == 39) { // RIGHT CLICK = dead
          allCells[i][j].convertDead();
        }
      }
    }
  }
}

/* Draw the cells to the screen */
void drawCells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      allCells[i][j].render();
    }
  }
}

/* Create the cells and store them in an array */
void generateCells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      allCells[i][j] = new Cell(CELL_SIZE*i, CELL_SIZE*j, state.DEAD, new int[] {i,j});
    }
  }
}

/* Apply the logic to the call the cells then update them */
void cellLogic() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      allCells[i][j].logic();
    }
  }
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      allCells[i][j].nextStage();
    }
  }
}

/* Get info in bottom right of screen */
void drawInfo() {
  fill(0);
  textSize(36);
  text("John Conway's Game of Life", 700, 0, 300, 150);
  textSize(28);
  if (!pausedSwitch.state) {
    text("UNPAUSED", 800, 160, 300, 50);
  }
  else {
    text("PAUSED", 800, 160, 300, 50);
  }
  
  if (loopSwitch.state) {
    text("LOOP", 800, 210, 300, 50);
  }
  else {
    text("NO LOOP", 800, 210, 300, 50);
  }
  
  text("SPEED", 830, 260, 300, 50);
  
  if (mouseX < 700) {
    text("Cell: ("+str(mouseX/CELL_SIZE)+", "+str(mouseY/CELL_SIZE)+")", 700, 600, 300, 50);
  }
  text("FPS: "+str(round(frameRate*100)/100.0), 700, 650, 300, 50);
}
