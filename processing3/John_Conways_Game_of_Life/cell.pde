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
