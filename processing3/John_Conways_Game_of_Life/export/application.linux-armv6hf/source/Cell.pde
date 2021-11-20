/* An individual cell */
class Cell {
  float x, y;
  int idx;
  state status;
  
  // Initialise the Cell with an x, y, state & index
  Cell(float cellx, float celly, state cellstatus, int cell_idx) {
    x = cellx;
    y = celly;
    idx = cell_idx;
    status = cellstatus;
  }
  
  // Checks to see if a cell is alive or still alive in the iteration
  boolean isAlive() {
    return ((status == state.ALIVE) || (status == state.DYING));
  }
  
  // Convert the cells to an alive one
  void convertAlive() {
    status = state.ALIVE;
  }
  
  // Render the cell as dead as grey or alive as yellow
  void render() {
    switch (status) {
      case DEAD:
        fill(191);
        rect(x, y, CELL_SIZE, CELL_SIZE);
        break;
      case ALIVE:
        fill(255, 255, 0);
        rect(x, y, CELL_SIZE, CELL_SIZE);
        break;
      default:
        break;
    }
  }
  
  // Count the cells alive around the cell and if <1 or >4 turn it to dying, =3 to born
  void logic() {
    if (status == state.ALIVE || status == state.DEAD) {
      int surround_cells = 0;
      int[] neighbours = {-CELL_SIDE-1, -CELL_SIDE, -CELL_SIDE+1, -1, +1, +CELL_SIDE-1, +CELL_SIDE, +CELL_SIDE+1};
      for (int i : neighbours) {
        try { // try but may be out of the board
          if (all_cells[idx+i].isAlive()) {
            surround_cells++;
          }
        }
        catch (Exception e) {
        }
      }
      switch (surround_cells) {
        case 0: case 1: // UNDERPOPULATION
          if (status == state.ALIVE)
            status = state.DYING;
          break;
        case 4: case 5: case 6: case 7: case 8: // OVERPOPULATION
          if (status == state.ALIVE)
            status = state.DYING;
          break;
        case 3: // REPRODUCTION
          if (status == state.DEAD)
            status = state.BORN;
          break;
        default:
          break;
      }
    }
  }
  
  // Apply the update to the board to have only dead or alive cells
  void nextstage() {
    if (status == state.DYING) {
      status = state.DEAD;
    }
    if (status == state.BORN) {
      status = state.ALIVE;
    }
  }
}
