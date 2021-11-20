cell[] all_cells = new cell[2500];

boolean run = false;
int cellno = 0;

void setup() {
  size(1000, 1000);
  background(191);
  strokeWeight(1);
  generatecells();
}

void draw() {
  if (run == true) {
    cell_logic();
    //delay(100);
  }
  drawcells();
}

void keyPressed() {
  if (keyCode == 32) {
    if (run == true) {
      run = false;
    }
    else if (run == false) {
      run = true;
    }
  }
  if (keyCode == 10) {
    run = false;
    generatecells();
  }
}

void mouseDragged() {
  clickcells();
}
void mousePressed() {
  clickcells();
}

void clickcells() {
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      if ((mouseX > i*20)&&(mouseX < (i+1)*20)&&(mouseY > j*20)&&(mouseY < (j+1)*20)) {
        all_cells[i*50+j].convertAlive();
      }
    }
  }
}

void drawcells() {
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].render();
  }
}

void generatecells() {
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      all_cells[cellno] = new cell(20*i, 20*j, "dead", i*50+j);
      cellno++;
    }
  }
  cellno = 0;
}

void cell_logic() {
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].logic();
  }
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].nextstage();
  }
}
