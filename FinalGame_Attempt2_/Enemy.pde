

class Enemy {

  // vars

  int x;
  int y;
  int size;

  //hitbox vars
  int top;
  int bottom;
  int left;
  int right;

  int life;
  boolean isDead;
  //int killCount;

  //timed fire vars
  int startTime;
  int currentTime;
  int interval;
  boolean shouldFire;


  Enemy(int startX, int startY) {

    x = startX;
    y = startY;
    size = 50;

    top = y - size/2;
    bottom = y + size/2;
    left = x - size/2;
    right = x + size/2;

    life = 3;
    isDead = false;
    //killCount = 0;

    startTime = millis();
    currentTime = millis();
    interval = int(random(700, 1200));
    shouldFire = false;
  }


  void render() {
    rectMode(CENTER);
    fill(255, 0, 0);
    square(x, y, size);
    imageMode(CENTER);
    //image(blueTank, x, y);
  }

  void health() {
    if (life <= 0) {
      isDead = true;
      //killCount++;
    }
  }
  
  //void bringBack(){
    
  //}


  boolean shoot() {
    
    currentTime = millis();
    
    if (currentTime - startTime >= interval) {
      startTime = currentTime;
      //println(shouldFire);
      return true;
    } else {
      return false;
    }
  }
}
