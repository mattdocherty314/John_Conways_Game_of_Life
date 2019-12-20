cell[] all_cells = new cell[2500];

boolean run = false;
int cellno = 0;



class cell {
  float x, y, list;
  String status;
  
  cell(float cellx, float celly, String cellstatus, float cell_list) {
    x = cellx;
    y = celly;
    list = cell_list;
    status = cellstatus;
  }
  
  boolean isAlive() {
    if ((status.equals("alive")) || (status.equals("dying"))) {
      return true;
    }
    else {
      return false;
    }
  }
  
  void convertAlive() {
    status = "alive";
  }
  
  void render() {
    if (status.equals("dead")) {
      fill(191);
      rect(x, y, 20, 20);
    }
    if (status.equals("alive")) {
      fill(255, 255, 0);
      rect(x, y, 20, 20);
    }
  }
  
  void logic() {
    if (status.equals("alive")) {
      int surround_cells = 0;
      if (list-51 > -1) {
        if (all_cells[int(list)-51].isAlive()) {
          surround_cells++;
        }
      }
      if (list-50 > -1) {
        if (all_cells[int(list)-50].isAlive()) {
          surround_cells++;
        }
      }
      if (list-49 > -1) {
        if (all_cells[int(list)-49].isAlive()) {
          surround_cells++;
        }
      }
      if (list-1 > -1) {
        if (all_cells[int(list)-1].isAlive()) {
          surround_cells++;
        }
      }
      if (list+1 < 2500) {
        if (all_cells[int(list)+1].isAlive()) {
          surround_cells++;
        }
      }
      if (list+49 < 2500) {
        if (all_cells[int(list)+49].isAlive()) {
          surround_cells++;
        }
      }
      if (list+50 < 2500) {
        if (all_cells[int(list)+50].isAlive()) {
          surround_cells++;
        }
      }
      if (list+51 < 2500) {
        if (all_cells[int(list)+51].isAlive()) {
          surround_cells++;
        }
      }
      if (surround_cells <= 1) {
        status = "dying";
      }
      else if (surround_cells >= 4) {
        status = "dying";
      }
    }
    if (status.equals("dead")) {
      int surround_cells = 0;
      if (list-51 > -1) {
        if (all_cells[int(list)-51].isAlive()) {
          surround_cells++;
        }
      }
      if (list-50 > -1) {
        if (all_cells[int(list)-50].isAlive()) {
          surround_cells++;
        }
      }
      if (list-49 > -1) {
        if (all_cells[int(list)-49].isAlive()) {
          surround_cells++;
        }
      }
      if (list-1 > -1) {
        if (all_cells[int(list)-1].isAlive()) {
          surround_cells++;
        }
      }
      if (list+1 < 2500) {
        if (all_cells[int(list)+1].isAlive()) {
          surround_cells++;
        }
      }
      if (list+49 < 2500) {
        if (all_cells[int(list)+49].isAlive()) {
          surround_cells++;
        }
      }
      if (list+50 < 2500) {
        if (all_cells[int(list)+50].isAlive()) {
          surround_cells++;
        }
      }
      if (list+51 < 2500) {
        if (all_cells[int(list)+51].isAlive()) {
          surround_cells++;
        }
      }
      if (surround_cells == 3) {
        status = "born";
      }
    }
  }
  
  void nextstage() {
    if (status == "dying") {
      status = "dead";
    }
    if (status == "born") {
      status = "alive";
    }
  }
}



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
