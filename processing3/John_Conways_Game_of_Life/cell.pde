/* An individual cell */
class cell {
  float x, y, idx;
  String status;
  
  // Initialise the Cell with an x, y, state & index
  cell(float cellx, float celly, String cellstatus, float cell_idx) {
    x = cellx;
    y = celly;
    idx = cell_idx;
    status = cellstatus;
  }
  
  // Checks to see if a cell is alive or still alive in the iteration
  boolean isAlive() {
    if ((status.equals("alive")) || (status.equals("dying"))) {
      return true;
    }
    else {
      return false;
    }
  }
  
  // Convert the cells to an alive one
  void convertAlive() {
    status = "alive";
  }
  
  // Render the cell as dead as grey or alive as yellow
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
  
  // Count the cells alive around the cell and if <1 or >4 turn it to dying, =3 to born
  void logic() {
    if (status.equals("alive")) {
      int surround_cells = 0;
      if (idx-51 > -1) {
        if (all_cells[int(idx)-51].isAlive()) {
          surround_cells++;
        }
      }
      if (idx-50 > -1) {
        if (all_cells[int(idx)-50].isAlive()) {
          surround_cells++;
        }
      }
      if (idx-49 > -1) {
        if (all_cells[int(idx)-49].isAlive()) {
          surround_cells++;
        }
      }
      if (idx-1 > -1) {
        if (all_cells[int(idx)-1].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+1 < 2500) {
        if (all_cells[int(idx)+1].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+49 < 2500) {
        if (all_cells[int(idx)+49].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+50 < 2500) {
        if (all_cells[int(idx)+50].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+51 < 2500) {
        if (all_cells[int(idx)+51].isAlive()) {
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
      if (idx-51 > -1) {
        if (all_cells[int(idx)-51].isAlive()) {
          surround_cells++;
        }
      }
      if (idx-50 > -1) {
        if (all_cells[int(idx)-50].isAlive()) {
          surround_cells++;
        }
      }
      if (idx-49 > -1) {
        if (all_cells[int(idx)-49].isAlive()) {
          surround_cells++;
        }
      }
      if (idx-1 > -1) {
        if (all_cells[int(idx)-1].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+1 < 2500) {
        if (all_cells[int(idx)+1].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+49 < 2500) {
        if (all_cells[int(idx)+49].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+50 < 2500) {
        if (all_cells[int(idx)+50].isAlive()) {
          surround_cells++;
        }
      }
      if (idx+51 < 2500) {
        if (all_cells[int(idx)+51].isAlive()) {
          surround_cells++;
        }
      }
      if (surround_cells == 3) {
        status = "born";
      }
    }
  }
  
  // Apply the update to the board to have only dead or alive cells
  void nextstage() {
    if (status == "dying") {
      status = "dead";
    }
    if (status == "born") {
      status = "alive";
    }
  }
}
