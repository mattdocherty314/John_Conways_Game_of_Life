import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class John_Conways_Game_of_Life extends PApplet {

Cell[] all_cells = new Cell[2500];

boolean run = false;
int cellno = 0;

int CELL_SIZE = 20; // Cell size
int CELL_SIDE = 50; // Amount of cells on a side

enum state {ALIVE, DEAD, BORN, DYING};

public void setup() {
  
  background(191);
  strokeWeight(1);
  generatecells();
}

public void draw() {
  if (run == true) { // If in a run state
    cell_logic();
    //delay(100);
  }
  drawcells();
}

public void keyPressed() { 
  if (keyCode == 32) { // SPACE = toggle run state
    run = !run;
  }
}

public void mouseDragged() {
  clickcells();
}
public void mousePressed() {
  clickcells();
}

/* Detect if a cell is clicked and make it alive if it is */
public void clickcells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      if ((mouseX > i*CELL_SIZE)&&(mouseX < (i+1)*CELL_SIZE)&&(mouseY > j*CELL_SIZE)&&(mouseY < (j+1)*CELL_SIZE)) {
        all_cells[i*CELL_SIDE+j].convertAlive();
      }
    }
  }
}

/* Draw the cells to the screen */
public void drawcells() {
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].render();
  }
}

/* Create the cells and store them in an array */
public void generatecells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      all_cells[cellno] = new Cell(CELL_SIZE*i, CELL_SIZE*j, state.DEAD, i*CELL_SIDE+j);
      cellno++;
    }
  }
  cellno = 0;
}

/* Apply the logic to the call the cells then update them */
public void cell_logic() {
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].logic();
  }
  for (int i = 0; i < all_cells.length; i++) {
    all_cells[i].nextstage();
  }
}
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
  public boolean isAlive() {
    return ((status == state.ALIVE) || (status == state.DYING));
  }
  
  // Convert the cells to an alive one
  public void convertAlive() {
    status = state.ALIVE;
  }
  
  // Render the cell as dead as grey or alive as yellow
  public void render() {
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
  public void logic() {
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
  public void nextstage() {
    if (status == state.DYING) {
      status = state.DEAD;
    }
    if (status == state.BORN) {
      status = state.ALIVE;
    }
  }
}
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "John_Conways_Game_of_Life" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
