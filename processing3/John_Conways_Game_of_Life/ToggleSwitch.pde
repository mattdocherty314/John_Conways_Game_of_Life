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
  void render() {
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
  void click() {
    if ((mouseX > x-20)&&(mouseX < x+60)&&(mouseY > y-20)&&(mouseY < y+20)) {
      toggle();
    }
  }
  
  void toggle() {
    state = !state;
  }
}
