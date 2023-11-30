

class EnemyBullet {
  // variables
  int x;
  int y;
  int d;

  int speed;
  float xMove;
  float yMove;

  int bounceCount;
  boolean shouldRemove;

  int top;
  int bottom;
  int left;
  int right;

  int angle;

  int startTime;
  int currentTime;
  int interval;

  // constructor
  EnemyBullet(int x_, int y_, int angle_) {
    x = x_;
    y = y_;
    angle = angle_;

    d=10;
    speed = 10;
    xMove = speed*cos(radians(angle));
    yMove = speed*sin(radians(angle));

    bounceCount = 0;
    shouldRemove = false;

    // hitboxes
    top = y -d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;

    startTime = millis();
    interval = 1000;
  }


  // functions
  void render() {
    stroke(255);
    fill(255);
    circle(x, y, d);
  }

  void move() {
    top = y -d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;

    //x += speed*cos(radians(angle));
    //y += speed*sin(radians(angle));

    x += xMove;
    y += yMove;
  }

  //void enemyShoot(Player aPlayer){
  //}


  /////////////////////////////////////////////////////// !!!!!!
  // definitely broken, but it does something when it reaches a border so thats something... right?
  void bounce(Barrier aBarrier) {
    if (y-d/2 <= 0) {
      yMove = -(yMove);
      //y -= speed*sin(radians(angle));
      bounceCount +=1;
    }
    if (y+d/2 >= height) {
      yMove = -(yMove);
      bounceCount +=1;
      //y -= speed*sin(radians(angle));
    }
    if (x-d/2 <= 0) {
      xMove = -(xMove);
      bounceCount +=1;
      //x -= speed*cos(radians(angle));
    }
    if (x+d/2 >=width) {
      xMove = -(xMove);
      bounceCount +=1;
      //x -= speed*cos(radians(angle));
    }

    // check collision on the left side of the barrier
    if (y-d/2 <= aBarrier.bottom &&
      y+d/2 >= aBarrier.top &&
      x+d/2 > aBarrier.left &&
      x-d/2 <= aBarrier.left) {
      xMove = -(xMove);
      bounceCount += 1;
    }
    // check collision on the right side of the barrier
    if (y-d/2 <= aBarrier.bottom &&
      y+d/2 >= aBarrier.top &&
      x+d/2 >= aBarrier.right &&
      x-d/2 < aBarrier.right) {
      xMove = -(xMove);
      bounceCount += 1;
    }
    // check collision with the top
    if (y-d/2 <= aBarrier.top &&
      y+d/2 > aBarrier.top &&
      x+d/2 >= aBarrier.left &&
      x-d/2 <= aBarrier.right) {
      yMove = -(yMove);
      bounceCount += 1;
    }
    // check collision with the bottom
    if (y-d/2 < aBarrier.bottom &&
      y+d/2 >= aBarrier.bottom &&
      x+d/2 >= aBarrier.left &&
      x-d/2 <= aBarrier.right) {
      yMove = -(yMove);
      bounceCount += 1;
    }
  }

  void resetBoundaries() {
    top = y;
    bottom = y + d;
    left = x;
    right = x + d;
  }

  void bounceRemove() {
    if (bounceCount >= 4) {
      shouldRemove = true;
    }
  }

  //// collision detection between bullet and enemy + kills the enemy
  //void hitEnemy(Enemy anEnemy) {
  //  if (top <= anEnemy.bottom &&
  //    bottom >= anEnemy.top &&
  //    left <= anEnemy.right &&
  //    right >= anEnemy.left) {
  //    println("hit");
  //    anEnemy.isDead = true;
  //    shouldRemove = true;
  //  }
  //}


  // collision detection between bullet and player + kills the player
  void hitPlayer(Player aPlayer) {
    if (top <= aPlayer.bottom &&
      bottom >= aPlayer.top &&
      left <= aPlayer.right &&
      right >= aPlayer.left) {
      println("player is hit");
    }
  }
}
