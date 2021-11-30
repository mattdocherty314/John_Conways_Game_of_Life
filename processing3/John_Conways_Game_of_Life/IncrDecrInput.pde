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
  
  void render() {
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
    text(str(value), x-5, y+10);
  }
  
  void click() {
    if ((mouseX > x+25)&&(mouseX < x+55)&&(mouseY > y-15)&&(mouseY < y+15)) {
      incr();
    }
    if ((mouseX > x-45)&&(mouseX < x-15)&&(mouseY > y-15)&&(mouseY < y+15)) {
      decr();
    }
  }
  
  void incr() {
    value = min(max, value+1);
  }
  
  void decr() {
    value = max(min, value-1);
  }
}
