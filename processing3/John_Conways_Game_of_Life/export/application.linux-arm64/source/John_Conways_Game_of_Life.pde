Cell[] all_cells = new Cell[2500];

boolean run = false;
int cellno = 0;

int CELL_SIZE = 20; // Cell size
int CELL_SIDE = 50; // Amount of cells on a side

enum state {ALIVE, DEAD, BORN, DYING};

void setup() {
  size(1000, 1000);
  background(191);
  strokeWeight(1);
  generatecells();
}

void draw() {
  if (run == true) { // If in a run state
    cell_logic();
    //delay(100);
  }
  drawcells();
}

void keyPressed() { 
  if (keyCode == 32) { // SPACE = toggle run state
    run = !run;
  }
}

void mouseDragged() {
  clickcells();
}
void mousePressed() {
  clickcells();
}

/* Detect if a cell is clicked and make it alive if it is */
void clickcells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      if ((mouseX > i*CELL_SIZE)&&(mouseX < (i+1)*CELL_SIZE)&&(mouseY > j*CELL_SIZE)&&(mouseY < (j+1)*CELL_SIZE)) {
        all_cells[i*CELL_SIDE+j].convertAlive();
      }
    }
  }
}

/* Draw the cells to the screen */
void drawcells() {
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].render();
  }
}

/* Create the cells and store them in an array */
void generatecells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      all_cells[cellno] = new Cell(CELL_SIZE*i, CELL_SIZE*j, state.DEAD, i*CELL_SIDE+j);
      cellno++;
    }
  }
  cellno = 0;
}

/* Apply the logic to the call the cells then update them */
void cell_logic() {
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].logic();
  }
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].nextstage();
  }
}
