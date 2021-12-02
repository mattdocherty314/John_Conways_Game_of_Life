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

public void setup() {
  allCells = new Cell[CELL_SIDE][CELL_SIDE];
  
  strokeWeight(1);
  generateCells();
}

public void draw() {
  background(220);
  if (!pausedSwitch.state) { // If in a run state
    cellLogic();
    delay(PApplet.parseInt(pow(2,9-speedInput.value)));
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

public void keyPressed() { 
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
  if (key == '+') { // + = increase cells
    sizeInput.incr();
  }
  if (key == '-') { // - = decrease cells
    sizeInput.decr();
  }
  if (CELL_SIDE != sizeInput.value) { // adjust size of grid when value changes
    CELL_SIDE = sizeInput.value;
    CELL_SIZE = 700.0f/CELL_SIDE;
    allCells = new Cell[CELL_SIDE][CELL_SIDE];
    generateCells();
  }
}

public void mouseDragged() {
  clickCells();
}
public void mousePressed() {
  clickCells();
  
  pausedSwitch.click();
  loopSwitch.click();
  speedInput.click();
  
  underpopInput.click();
  overpopInput.click();
  reprodInput.click();
  
  sizeInput.click();
  if (CELL_SIDE != sizeInput.value) { // adjust size of grid when value changes
    CELL_SIDE = sizeInput.value;
    CELL_SIZE = 700.0f/CELL_SIDE;
    allCells = new Cell[CELL_SIDE][CELL_SIDE];
    generateCells();
  }
}

/* Detect if a cell is clicked and make it alive if it is */
public void clickCells() {
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
public void drawCells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      allCells[i][j].render();
    }
  }
}

/* Create the cells and store them in an array */
public void generateCells() {
  for (int i = 0; i < CELL_SIDE; i++) {
    for (int j = 0; j < CELL_SIDE; j++) {
      allCells[i][j] = new Cell(CELL_SIZE*i, CELL_SIZE*j, state.DEAD, new int[] {i,j});
    }
  }
}

/* Apply the logic to the call the cells then update them */
public void cellLogic() {
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
public void drawInfo() {
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
    text("Cell: ("+str(PApplet.parseInt(mouseX/CELL_SIZE))+", "+str(PApplet.parseInt(mouseY/CELL_SIZE))+")", 700, 600, 300, 50);
  }
  text("FPS: "+str(round(frameRate*100)/100.0f), 700, 650, 300, 50);
}
/* An individual cell */
class Cell {
  private float x, y;
  private int[] idx;
  private state status;
  
  // Initialise the Cell with an x, y, state & index
  Cell(float cellx, float celly, state cellstatus, int[] cellIdx) {
    x = cellx;
    y = celly;
    idx = cellIdx;
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
  
  // Convert the cells to an dead one
  public void convertDead() {
    status = state.DEAD;
  }
  
  // Render the cell as dead as black or alive as white
  public void render() {
    switch (status) {
      case DEAD:
        fill(0);
        rect(x, y, CELL_SIZE, CELL_SIZE);
        break;
      case ALIVE:
        fill(255);
        rect(x, y, CELL_SIZE, CELL_SIZE);
        break;
      default:
        break;
    }
  }
  
  // Count the cells alive around the cell and if <1 or >4 turn it to dying, =3 to born
  public void logic() {
    if (status == state.ALIVE || status == state.DEAD) {
      int surroundCells = 0;
      int[][] neighbours = {{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}};
      for (int[] i : neighbours) {
        try { // try but may be out of the board
          int x, y;
          if (loopSwitch.state) { // if screen looping is on
            x = (idx[0]+i[0]+CELL_SIDE)%CELL_SIDE;
            y = (idx[1]+i[1]+CELL_SIDE)%CELL_SIDE;
          }
          else { // otherwise
            x = (idx[0]+i[0]);
            y = (idx[1]+i[1]);
          }
          if (allCells[x][y].isAlive()) {
            surroundCells++;
          }
        }
        catch (Exception e) {
        }
      }
      if ((surroundCells <= underpopInput.value) && (status == state.ALIVE)) { // UNDERPOPULATION
        status = state.DYING;
      }
      if ((surroundCells >= overpopInput.value) && (status == state.ALIVE)) { // OVERPOPULATION
        status = state.DYING;
      }
      if ((surroundCells == reprodInput.value) && (status == state.DEAD)) { // REPRODUCTION
        status = state.BORN;
      }
    }
  }
  
  // Apply the update to the board to have only dead or alive cells
  public void nextStage() {
    if (status == state.DYING) {
      status = state.DEAD;
    }
    if (status == state.BORN) {
      status = state.ALIVE;
    }
  }
}
class IncrDecrInput {
  float x, y;
  int value, min, max;
  IncrDecrInput(float incdecx, float incdecy, int defval, int minval, int maxval) {
    x = incdecx;
    y = incdecy;
    value = defval;
    min = minval;
    max = maxval;
  }
  
  public void render() {
    fill(0);
    strokeWeight(30);
    stroke(195);
    if (value != max) {
      line(x+40, y, x+40, y);
      text("+", x+30, y+10);
    }
    if (value != min) {
      line(x-30, y, x-30, y);
      text("-", x-35, y+10);
    }
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(x-10, y-20, 30, 40);
    fill(0);
    textSize(28.0f/(str(value).length()));
    text(str(value), x-5, y+10);
  }
  
  public void click() {
    if ((mouseX > x+25)&&(mouseX < x+55)&&(mouseY > y-15)&&(mouseY < y+15)) {
      incr();
    }
    if ((mouseX > x-45)&&(mouseX < x-15)&&(mouseY > y-15)&&(mouseY < y+15)) {
      decr();
    }
  }
  
  public void incr() {
    value = min(max, value+1);
  }
  
  public void decr() {
    value = max(min, value-1);
  }
}
/* A toggle switch input */
class ToggleSwitch {
  float x, y;
  boolean state;
  ToggleSwitch(float switchx, float switchy, boolean switchtoggle) {
    x = switchx;
    y = switchy;
    state = switchtoggle;
  }
  
  // Display the toggle
  public void render() {
    stroke(127);
    strokeWeight(40);
    line(x, y, x+40, y);
    if (state) {
      stroke(0,0,127);
      strokeWeight(30);
      line(x,y,x+30,y);
      
      stroke(255);
      strokeWeight(30);
      line(x+40,y,x+40,y);
    }
    else {
      stroke(63);
      strokeWeight(30);
      line(x,y,x+40,y);
      
      stroke(255);
      strokeWeight(30);
      line(x,y,x,y);
    }
    strokeWeight(1);
    stroke(0);
  }
  
  // Detect mouse click
  public void click() {
    if ((mouseX > x-20)&&(mouseX < x+60)&&(mouseY > y-20)&&(mouseY < y+20)) {
      toggle();
    }
  }
  
  public void toggle() {
    state = !state;
  }
}
  public void settings() {  size(1000, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "John_Conways_Game_of_Life" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
