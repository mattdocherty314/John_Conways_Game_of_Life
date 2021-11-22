Cell[][] allCells = new Cell[50][50];

boolean run = false;
int cellno = 0;

int CELL_SIDE = 50; // Amount of cells on a side
int CELL_SIZE = 700/CELL_SIDE; // Cell size

enum state {ALIVE, DEAD, BORN, DYING};

void setup() {
  size(1000, 700);
  strokeWeight(1);
  generateCells();
}

void draw() {
  background(220);
  if (run == true) { // If in a run state
    cellLogic();
    //delay(100);
  }
  drawCells();
  drawInfo();
}

void keyPressed() { 
  if (keyCode == 32) { // SPACE = toggle run state
    run = !run;
  }
}

void mouseDragged() {
  clickCells();
}
void mousePressed() {
  clickCells();
}

/* Detect if a cell is clicked and make it alive if it is */
void clickCells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      if ((mouseX > i*CELL_SIZE)&&(mouseX < (i+1)*CELL_SIZE)&&(mouseY > j*CELL_SIZE)&&(mouseY < (j+1)*CELL_SIZE)) {
        allCells[i][j].convertAlive();
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
      allCells[i][j] = new Cell(CELL_SIZE*i, CELL_SIZE*j, state.DEAD, i*CELL_SIDE+j);
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
  textSize(24);
  if (!run) {
    text("PAUSED", 850, 100, 300, 50);
  }
  if (mouseX < 700) {
    text("Cell: ("+str(mouseX/CELL_SIZE)+", "+str(mouseY/CELL_SIZE)+")", 700, 600, 300, 50);
  }
  text("FPS: "+str(round(frameRate*100)/100.0), 700, 650, 300, 50);
}
