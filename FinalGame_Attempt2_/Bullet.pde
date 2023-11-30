

class Bullet {
  ///////////////////////////////////////////////////////// variables

  // initial position vars
  int x;
  int y;
  int d;

  // move varas
  int speed;
  float xMove;
  float yMove;
  int angle;

  // bounce and remove bullet vars
  int bounceCount;
  boolean shouldRemove;

  // player vs enemy bullet var (1 is player, 0 is enemy)
  int bulletOrigin;

  // hitbox vars
  int top;
  int bottom;
  int left;
  int right;


  ////////////////////////////////////////////////////////////// constructor
  Bullet(int x_, int y_, int angle_, int origin) {
    x = x_;
    y = y_;
    angle = angle_;

    d=10;
    speed = 10;
    xMove = speed*cos(radians(angle));
    yMove = speed*sin(radians(angle));

    bounceCount = 0;
    shouldRemove = false;

    bulletOrigin = origin;

    // hitboxes
    top = y -d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }


  // functions
  void render() {
    stroke(255);
    if (bulletOrigin == 1) {
      fill(0, 0, 255);
    } else {
      fill(255, 0, 0);
    }
    strokeWeight(0.5);
    circle(x, y, d);
    noFill();
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


  /////////////////////////////////////////////////////// !!!!!!
  // definitely broken, but it does something when it reaches a border so thats something... right?
  void bounce(Barrier aBarrier) {
    //if (y-d/2 <= 0) {
    //  yMove = -(yMove);
    //  //y -= speed*sin(radians(angle));
    //  bounceCount +=1;
    //}
    //if (y+d/2 >= height) {
    //  yMove = -(yMove);
    //  bounceCount +=1;
    //  //y -= speed*sin(radians(angle));
    //}
    //if (x-d/2 <= 0) {
    //  xMove = -(xMove);
    //  bounceCount +=1;
    //  //x -= speed*cos(radians(angle));
    //}
    //if (x+d/2 >=width) {
    //  xMove = -(xMove);
    //  bounceCount +=1;
    //  //x -= speed*cos(radians(angle));
    //}


    // check collision on the left side of the barrier
    if (y-d/2 <= aBarrier.bottom &&
      y+d/2 >= aBarrier.top &&
      x+d/2 > aBarrier.left &&
      x-d/2 <= aBarrier.left) {
      //xMove = -(xMove);
      if (bulletOrigin == 0) {
        shouldRemove = true;
      } else {
        xMove = -abs(xMove);
        bounceCount += 1;
      }
    }
    // check collision on the right side of the barrier
    if (y-d/2 <= aBarrier.bottom &&
      y+d/2 >= aBarrier.top &&
      x+d/2 >= aBarrier.right &&
      x-d/2 < aBarrier.right) {
      //xMove = -(xMove);
      if (bulletOrigin == 0) {
        shouldRemove = true;
      } else {
        xMove = abs(xMove);
        bounceCount += 1;
      }
    }
    // check collision with the top
    if (y-d/2 <= aBarrier.top &&
      y+d/2 > aBarrier.top &&
      x+d/2 >= aBarrier.left &&
      x-d/2 <= aBarrier.right) {
      //yMove = -(yMove);
      if (bulletOrigin == 0) {
        shouldRemove = true;
      } else {
        yMove = -abs(yMove);
        bounceCount += 1;
      }
    }
    // check collision with the bottom
    if (y-d/2 < aBarrier.bottom &&
      y+d/2 >= aBarrier.bottom &&
      x+d/2 >= aBarrier.left &&
      x-d/2 <= aBarrier.right) {
      //yMove = -(yMove);
      if (bulletOrigin == 0) {
        shouldRemove = true;
      } else {
        yMove = abs(yMove);
        bounceCount += 1;
      }
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

  //void eBulletHitBarrier(Barrier aBarrier) {
  //}

  // collision detection between bullet and enemy + kills the enemy
  void hitEnemy(Enemy anEnemy) {
    if (top <= anEnemy.bottom &&
      bottom >= anEnemy.top &&
      left <= anEnemy.right &&
      right >= anEnemy.left &&
      bulletOrigin == 1) {
      println("Enemy is hit");
      anEnemy.life -=1;
      //anEnemy.isDead = true;
      shouldRemove = true;
    }
  }


  // collision detection between bullet and player + kills the player
  void hitPlayer(Player aPlayer) {
    if (top <= aPlayer.bottom &&
      bottom >= aPlayer.top &&
      left <= aPlayer.right &&
      right >= aPlayer.left &&
      bulletOrigin == 0) {
      aPlayer.life -=1;
      score -= 50;
      shouldRemove = true;
      println("player is hit");
    }
  }
}
