

class Player {
  // variables
  int x;
  int y;
  int size;

  // moving booleans
  boolean rotatingLeft;
  boolean rotatingRight;
  boolean isMovingForward;
  boolean isMovingBack;
  int speed;

  // player hitbox
  int top;
  int bottom;
  int right;
  int left;

  // health vars
  int life;
  boolean isDead;


  // angle in degrees of the player
  int angle;

  // constructor
  Player(int startX, int startY) {
    size = 50;
    angle = 0;
    
    x = startX;
    y = startY;
    
    //x = width/2 - size/2;
    //y = height/2-size/2;

    // moving booleans
    rotatingLeft = false;
    rotatingRight = false;
    isMovingForward = false;
    isMovingBack = false;
    speed = 4;

    // hitbox variables
    top = y;
    bottom = y+size/2;
    left = x;
    right = x+size/2;

    life = 5;
    isDead = false;
  }

  ////////////////////////////////////////////////////// functions

  ///////////// rendering stuff
  void render(int aX, int aY) {
    stroke(255);
    fill(0, 255, 255);
    rectMode(CENTER);
    //square(aX, aY, size);
    //image(blueTank, 0, 0);
  }

  // running code
  void runRotations() {
    rotateLeft();
    rotateRight();
  }
  void rotateRight() {
    if (rotatingRight) {
      angle += 2;
    }
  }
  void rotateLeft() {
    if (rotatingLeft) {
      angle -= 2;
    }
  }
  void runReset() {
    rotatingLeft = false;
    rotatingRight = false;
  }

  ///////////////////////////////////////////////////////////////
  // strange issue when moving at angle: does not go directly forward,
  //   instead drifts a little to the side.
  void move() {
    // hitbox variables
    top = y-size/2;
    bottom = y+size/2;
    left = x-size/2;
    right = x+size/2;

    if (isMovingForward) {
      x += speed*cos(radians(angle));
      y += speed*sin(radians(angle));
    }

    if (isMovingBack) {
      x -= speed*cos(radians(angle));
      y -= speed*sin(radians(angle));
    }
  }


  ////////////////////////////////////////////////////////////// collision detection between player and barrier
  void checkBarrier(Barrier aBarrier) {

    // check collision on the left side of the barrier
    if (top <= aBarrier.bottom &&
      bottom >= aBarrier.top &&
      right > aBarrier.left &&
      left <= aBarrier.left) {
      isMovingForward = false;
      isMovingBack = false;
      x = aBarrier.left - (size/2)-1;
    }
    // check collision on the right side of the barrier
    if (top <= aBarrier.bottom &&
      bottom >= aBarrier.top &&
      right >= aBarrier.right &&
      left < aBarrier.right) {
      isMovingForward = false;
      isMovingBack = false;
      x = aBarrier.right + (size/2)+1;
    }
    // check collision with the top
    if (top <= aBarrier.top &&
      bottom > aBarrier.top &&
      right >= aBarrier.left &&
      left <= aBarrier.right) {
      isMovingForward = false;
      isMovingBack = false;
      y = aBarrier.top - (size/2)-1;
    }
    // check collision with the bottom
    if (top < aBarrier.bottom &&
      bottom >= aBarrier.bottom &&
      right >= aBarrier.left &&
      left <= aBarrier.right) {
      isMovingForward = false;
      isMovingBack = false;
      y = aBarrier.bottom + (size/2)+1;
    }
  }


  boolean health() {
    if (life <= 0) {
      return true;
    } else {
      return false;
    }
  }
}
