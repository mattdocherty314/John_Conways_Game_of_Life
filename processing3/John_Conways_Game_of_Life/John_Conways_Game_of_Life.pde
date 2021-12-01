Cell[][] allCells = new Cell[50][50];
ToggleSwitch pausedSwitch = new ToggleSwitch(725, 175, true);
ToggleSwitch loopSwitch = new ToggleSwitch(725, 225, true);
IncrDecrInput speedInput = new IncrDecrInput(760, 275, 8, 1, 9);

IncrDecrInput underpopInput = new IncrDecrInput(760, 375, 1, 0, 8);
IncrDecrInput overpopInput = new IncrDecrInput(760, 425, 4, 0, 8);
IncrDecrInput reprodInput = new IncrDecrInput(760, 475, 3, 0, 8);

IncrDecrInput sizeInput = new IncrDecrInput(850, 575, 50, 1, 100);

// Game parameters
int CELL_SIDE = sizeInput.value; // Amount of cells on a side
float CELL_SIZE = 700/CELL_SIDE; // Cell size

enum state {ALIVE, DEAD, BORN, DYING};

void setup() {
  allCells = new Cell[CELL_SIDE][CELL_SIDE];
  size(1000, 700);
  strokeWeight(1);
  generateCells();
}

void draw() {
  background(220);
  if (!pausedSwitch.state) { // If in a run state
    cellLogic();
    delay(int(pow(2,9-speedInput.value)));
  }
  drawCells();
  drawInfo();
  
  pausedSwitch.render();
  loopSwitch.render();
  speedInput.render();
  
  underpopInput.render();
  overpopInput.render();
  reprodInput.render();
  
  sizeInput.render();
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
  
  underpopInput.click();
  overpopInput.click();
  reprodInput.click();
  
  sizeInput.click();
  if (CELL_SIDE != sizeInput.value) {
    CELL_SIDE = sizeInput.value;
    CELL_SIZE = 700.0/CELL_SIDE;
    allCells = new Cell[CELL_SIDE][CELL_SIDE];
    generateCells();
  }
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
  text("___Game States___", 710, 110, 300, 50);
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
  
  text("___Game Rules___", 710, 310, 300, 50);
  text("UNDERPOP", 830, 360, 300, 50);
  text("OVERPOP", 830, 410, 300, 50);
  text("REPROD", 830, 460, 300, 50);
  
  text("Num of Cells (NxN)", 710, 510, 300, 50);
  
  if (mouseX < 700) {
    text("Cell: ("+str(int(mouseX/CELL_SIZE))+", "+str(int(mouseY/CELL_SIZE))+")", 700, 600, 300, 50);
  }
  text("FPS: "+str(round(frameRate*100)/100.0), 700, 650, 300, 50);
}
