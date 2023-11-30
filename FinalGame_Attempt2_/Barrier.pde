

class Barrier{
  
  // declare vars
  
  // position vars
  int x;
  int y;
  int w;
  int h;
  
  // hitbox vars
  int top;
  int bottom;
  int right;
  int left;
  
  
  // constructor
  Barrier(int X, int Y, int W, int H){
    
    x = X;
    y = Y;
    w = W;
    h = H;
    
    top = y-h/2;
    bottom = y+h/2;
    left = x-w/2;
    right = x+w/2;
    
  }
  
  void render(){
    rectMode(CENTER);
    fill(255);
    rect(x,y,w,h);
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
