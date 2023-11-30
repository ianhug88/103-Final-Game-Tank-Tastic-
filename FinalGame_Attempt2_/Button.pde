

class Button {

  /////////////////////////
  // class vars
  /////////////////////////

  int x;
  int y;
  int w;
  int h;
  color c;

  /////////////////////////
  // Constructor Function
  /////////////////////////

  Button(int X, int Y, int W, int H, color C) {
    x = X;
    y = Y;
    w = W;
    h = H;
    c = C;
  }

  ///////////////////////
  // Functions
  ///////////////////////

  // draws the button
  void render() {
    rectMode(CENTER);
    stroke(255);
    strokeWeight(1);
    fill(c);
    rect(x, y, w, h, 5);
  }

  // detects if the mouse is in the button
  boolean mouseIsInButton() {
    if (mouseX >= x-w/2 &&
      mouseX <= x+w/2 &&
      mouseY >= y-h/2 &&
      mouseY <= y+h/2) {
      return true;
    } else {
      return false;
    }
  }
}
