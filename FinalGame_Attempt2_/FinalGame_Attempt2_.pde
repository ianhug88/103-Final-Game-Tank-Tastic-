

// import sound library
import processing.sound.*;

// declare sound vars
SoundFile playerShoot;
SoundFile mainMenu;
SoundFile level1;
SoundFile level2;
SoundFile level3;
SoundFile death;
SoundFile win;

// declare images and animation
Animation TankForward;
Animation TankBackward;
PImage[] forwardImages = new PImage[3];
PImage[] backwardImages = new PImage[3];
PImage blueTank;

/*/////////////////////////////////////////////// Game State Variable
 state variable right below
 0 = start screen
 1 = first level (single Player)
 2 = second level (single player)
 3 = third level (single player)
 4 = player dead screen
 5 = player win screen
 */
int state = 0;

// keeps track of how many enemies have died in that level and signals a state change when all enemies are dead
int killCount;

// keeps track of the score
int score;

// enemy bullet angle
int angle;




Button startButton;


/*
 Im going to declare and initialize everything in ground of levels rather than all
 barriers in one block, and all enemies in another block
 */


////////////////////////////////////////////////
Player p1;
Barrier b1;
Barrier leftWall;
Barrier rightWall;                     // Barriers for all levels
Barrier topWall;
Barrier bottomWall;
Barrier leftPStart;
////////////////////////////////////////////////
Barrier mid_1;
Barrier top_1;
Barrier bottom_1;
// first level
Enemy e1_1;
Enemy e2_1;

ArrayList<Barrier> barrierListLVL1;
ArrayList<Enemy> enemyListLVL1;
///////////////////////////////////////////////
Barrier leftTop_2;
Barrier leftBottom_2;
Barrier rightTop_2;
Barrier rightBottom_2;
Barrier rightFront_2;

Enemy e1_2;                        // second level
Enemy e2_2;
Enemy e3_2;
Enemy e4_2;

ArrayList<Barrier> barrierListLVL2;
ArrayList<Enemy> enemyListLVL2;
///////////////////////////////////////////////
Barrier midTop_3;
Barrier midBottom_3;
Barrier midLeft_3;
Barrier midRight_3;
Barrier topRight_3;
Barrier bottomRight_3;

Enemy e1_3;                             // third level
Enemy e2_3;
Enemy e3_3;
Enemy e4_3;
Enemy e5_3;

ArrayList<Barrier> barrierListLVL3;
ArrayList<Enemy> enemyListLVL3;
///////////////////////////////////////////////





// make an array list of barriers for the three single player levels



// "make an array list of things in class Bullet, and call it "bulletList""
// an array list of bullets fired by enemies
ArrayList<Bullet> bulletList;
// array list of bullets fired by enemies
//ArrayList<EnemyBullet> eBulletList;
//"make an array list of things in class Enemy, and call it "enemyList""









////////////////////////////////////////////////////////////////////////////
//░██████╗███████╗████████╗██╗░░░██╗██████╗░
//██╔════╝██╔════╝╚══██╔══╝██║░░░██║██╔══██╗
//╚█████╗░█████╗░░░░░██║░░░██║░░░██║██████╔╝
//░╚═══██╗██╔══╝░░░░░██║░░░██║░░░██║██╔═══╝░
//██████╔╝███████╗░░░██║░░░╚██████╔╝██║░░░░░
//╚═════╝░╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░
////////////////////////////////////////////////////////////////////////////


void setup() {
  size(1300, 900);

  // initialize sounds
  playerShoot = new SoundFile(this, "TankShoot.mp3");
  mainMenu = new SoundFile(this, "MainMenuMusic.mp3");
  level1 = new SoundFile(this, "LevelOneMusic.mp3");
  level2 = new SoundFile(this, "LevelTwoMusic.mp3");
  level3 = new SoundFile(this, "LevelThreeMusic.mp3");
  death = new SoundFile(this, "PipeFalling.mp3");
  win = new SoundFile(this, "WinMusic.mp3");


  // initialize images
  blueTank = loadImage("BlueTank_sprite1.png");

  // fill and initialize animation arrays
  for (int index=0; index < 3; index++) {
    forwardImages[index] = loadImage("BlueTank_sprite" + index + ".png");
  }

  for (int index = 2; index >= 0; index--) {
    backwardImages[index] = loadImage("BlueTank_sprite" + index + ".png");
  }

  p1 = new Player(125, height/2);
  TankForward = new Animation(forwardImages, p1.x, p1.y, 0.4, 1.5);
  TankBackward = new Animation(backwardImages, p1.x, p1.y, 0.5, 1.5);

  killCount = 0;
  score = 0;






  startButton = new Button(width/2, height-(height/4), 800, 200, color(255));


  /*
  
   initialize and add each barrier and enemy by level
   
   */

  /////////////////////////////////////////////////////////////////////////////////
  mid_1 = new Barrier(width/2-100, height/2, 100, 100);
  top_1 = new Barrier(width-(width/3), height/4, 40, 200);
  bottom_1 = new Barrier(width-(width/3), height-(height/4), 40, 200);

  e1_1 = new Enemy(width-(width/4), height-(height/4));
  e2_1 = new Enemy(width-(width/4), height/4);

  barrierListLVL1 = new ArrayList<Barrier>();                             //  FIRST LEVEL
  barrierListLVL1.add(mid_1);
  barrierListLVL1.add(top_1);
  barrierListLVL1.add(bottom_1);

  enemyListLVL1 = new ArrayList<Enemy>();

  enemyListLVL1.add(e1_1);
  enemyListLVL1.add(e2_1);
  //////////////////////////////////////////////////////////////////////////////
  leftTop_2 = new Barrier(450, height/2, 300, 60);
  //leftBottom_2 = new Barrier(400, height-(height/3), 100, 40);
  rightTop_2 = new Barrier(width - 300, height/4, 200, 40);
  rightBottom_2 = new Barrier(width - 300, height-(height/4), 200, 40);
  rightFront_2 = new Barrier(width-500, height/2, 40, 300);


  // second level
  e1_2 = new Enemy(400, height/3);
  e2_2 = new Enemy(400, height -(height/3));
  e3_2 = new Enemy(width-200, (height/2)-25);
  e4_2 = new Enemy(width-200, (height/2)+25);

  barrierListLVL2 = new ArrayList<Barrier>();                            // SECOND LEVEL

  barrierListLVL2.add(leftTop_2);
  //barrierListLVL2.add(leftBottom_2);
  barrierListLVL2.add(rightTop_2);
  barrierListLVL2.add(rightBottom_2);
  barrierListLVL2.add(rightFront_2);

  enemyListLVL2 = new ArrayList<Enemy>();
  enemyListLVL2.add(e1_2);
  enemyListLVL2.add(e2_2);
  enemyListLVL2.add(e3_2);
  enemyListLVL2.add(e4_2);


  /////////////////////////////////////////////////////////////////////////////
  leftPStart = new Barrier(200, height/2, 30, 300);
  midTop_3 = new Barrier(width/2, height/3, 200, 40);
  midBottom_3 = new Barrier(width/2, height- (height/3), 200, 40);
  midLeft_3 = new Barrier(width/2 - height/4, height/2, 40, 150);
  midRight_3 = new Barrier(width/2 + height/4, height/2, 40, 150);
  topRight_3 = new Barrier(width-(width/5), 100, 40, 100);
  bottomRight_3 = new Barrier(width-(width/5), height-100, 40, 100);

  e1_3 = new Enemy(width/3, 150);
  e2_3 = new Enemy(width/3, height-150);
  e3_3 = new Enemy(width/2, height/2);
  e4_3 = new Enemy(width-(width/7), 100);
  e5_3 = new Enemy(width-(width/7), height-100);

  barrierListLVL3 = new ArrayList<Barrier>();                               // THIRD LEVEL
  barrierListLVL3.add(midTop_3);
  barrierListLVL3.add(midBottom_3);
  barrierListLVL3.add(midLeft_3);
  barrierListLVL3.add(midRight_3);
  barrierListLVL3.add(topRight_3);
  barrierListLVL3.add(bottomRight_3);

  enemyListLVL3 = new ArrayList<Enemy>();
  enemyListLVL3.add(e1_3);
  enemyListLVL3.add(e2_3);
  enemyListLVL3.add(e3_3);
  enemyListLVL3.add(e4_3);
  enemyListLVL3.add(e5_3);

  /////////////////////////////////////////////////////////////////////////////



  ////////////////// border walls and player start wall for every level
  leftWall = new Barrier(25, height/2, 50, height);
  rightWall = new Barrier(width - 25, height/2, 50, height);
  topWall = new Barrier(width/2, 25, width, 50);
  bottomWall = new Barrier(width/2, height-25, width, 50);


  barrierListLVL1.add(leftWall);
  barrierListLVL2.add(leftWall);
  barrierListLVL3.add(leftWall);

  barrierListLVL1.add(rightWall);
  barrierListLVL2.add(rightWall);
  barrierListLVL3.add(rightWall);

  barrierListLVL1.add(topWall);
  barrierListLVL2.add(topWall);
  barrierListLVL3.add(topWall);

  barrierListLVL1.add(bottomWall);
  barrierListLVL2.add(bottomWall);
  barrierListLVL3.add(bottomWall);

  barrierListLVL1.add(leftPStart);
  barrierListLVL2.add(leftPStart);
  barrierListLVL3.add(leftPStart);


  bulletList = new ArrayList<Bullet>();
}


////////////////////////////////////////////////////////////////////////////////
//██████╗░██████╗░░█████╗░░██╗░░░░░░░██╗
//██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║
//██║░░██║██████╔╝███████║░╚██╗████╗██╔╝
//██║░░██║██╔══██╗██╔══██║░░████╔═████║░
//██████╔╝██║░░██║██║░░██║░░╚██╔╝░╚██╔╝░
//╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░
/////////////////////////////////////////////////////////////////////////////////

void draw() {
  background(50);


  switch(state) {

  case 0:

    /////////////////////////////////////////// main screen
    background(0, 0, 0);
    rectMode(CENTER);

    if (mainMenu.isPlaying() == false) {
      mainMenu.play();
    }


    fill(255, 255, 255);
    startButton.render();
    if (startButton.mouseIsInButton() == true && mousePressed == true) {
      state++;
    }
    textAlign(CENTER);
    textSize(170);
    fill(255);
    text("Iron Dominance", width/2, 300);
    textSize(100);
    fill(0, 0, 0);
    text("press to start", width/2, height-(height/5));

    break;

    ///////////////////////////////////////////////////////////////////////////
    //██╗░░░░░███████╗██╗░░░██╗███████╗██╗░░░░░░░░░███╗░░
    //██║░░░░░██╔════╝██║░░░██║██╔════╝██║░░░░░░░░████║░░
    //██║░░░░░█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░░░██╔██║░░
    //██║░░░░░██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░░░╚═╝██║░░
    //███████╗███████╗░░╚██╔╝░░███████╗███████╗░░███████╗
    //╚══════╝╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░░╚══════╝
    //////////////////////////////////////////////////////////////////////////
  case 1:

    mainMenu.stop();
    if (level1.isPlaying() == false) {
      level1.play();
    }
    rectMode(CENTER);

    if (p1.isMovingForward == true) {
      TankForward.isAnimating = true;
    } else if (p1.isMovingBack == true) {
      TankBackward.isAnimating = true;
    }

    pushMatrix(); // remember current drawing matrix)
    translate(p1.x, p1.y);
    rotate(radians(p1.angle)); // rotate player based on angle
    p1.render(0, 0);
    if (TankForward.isAnimating == true) {
      TankForward.display(0, 0);
    } else if (TankBackward.isAnimating == true) {
      TankBackward.display(0, 0);
    } else {
      blueTank.resize(90, 90);
      image(blueTank, 0, 0);
    }
    popMatrix(); // restore previous graphics matrix
    p1.runRotations();
    p1.move();


    textSize(50);
    text("life:", 120, 100);
    text(p1.life, 220, 100);
    text("score:", width/2-(100), 100);
    text(score, width/2, 100);

    //////////////////////////////////////// player death
    if (p1.health()) {
      state = 4;
      death.play();
      //println("PLAYER IS DEAD AND IN THE FINAL GAME THE GAMESTATE WILL CHANGE");
    }


    ////////////////////////////////////////////////// Barrier Stuff
    for (Barrier aBarrier : barrierListLVL1) {
      aBarrier.render();
      p1.checkBarrier(aBarrier);
    }

    ////////////////////////////////////////////////////Player Bullet Stuff
    for (Bullet aBullet : bulletList) {
      aBullet.resetBoundaries();
      aBullet.render();
      aBullet.move();
      aBullet.bounceRemove();
      aBullet.hitPlayer(p1);
      for (Barrier aBarrier : barrierListLVL1) {
        aBullet.bounce(aBarrier);
      }
      for (Enemy anEnemy : enemyListLVL1) {
        aBullet.hitEnemy(anEnemy);
      }
    }


    // for loop that removes a bullet when shouldRemove is true
    for (int i = bulletList.size()-1; i >= 0; i=i-1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }


    ////////////////////////////////////////////////////Enemy Stuff
    for (Enemy anEnemy : enemyListLVL1) {
      anEnemy.render();
      anEnemy.health();
      if (anEnemy.shoot()) {
        // above and right
        if (p1.x>anEnemy.x && p1.y < anEnemy.y) {
          angle = int(random(270, 360));
        }
        // below and right
        else if (p1.x > anEnemy.x && p1.y > anEnemy.y) {
          angle = int(random(0, 90));
        }
        // below and left
        else if (p1.x < anEnemy.x && p1.y > anEnemy.y) {
          angle = int(random(90, 180));
        }
        //above and right
        else if (p1.x < anEnemy.x && p1.y < anEnemy.y) {
          angle = int(random(180, 270));
        }
        bulletList.add(new Bullet(anEnemy.x, anEnemy.y, angle, 0));
      }
    }

    // for loop that removes enemies when hit by bullet
    for (int i = enemyListLVL1.size()-1; i >= 0; i=i-1) {
      Enemy anEnemy = enemyListLVL1.get(i);

      if (anEnemy.isDead == true) {
        enemyListLVL1.remove(anEnemy);
        killCount++;
        score +=100;
        println("enemy dead");
      }
    }

    if (killCount == 2) {
      killCount = 0;
      p1.x = 125;
      p1.y = height/2;
      p1.angle = 0;
      //enemyListLVL1.add(e1_1);
      //enemyListLVL1.add(e2_1);
      bulletList.clear();
      state = 2;

      println("proceed to level 2");
    }


    break;

    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //██╗░░░░░███████╗██╗░░░██╗███████╗██╗░░░░░░░██████╗░
    //██║░░░░░██╔════╝██║░░░██║██╔════╝██║░░░░░░░╚════██╗
    //██║░░░░░█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░░░░░███╔═╝
    //██║░░░░░██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░░░██╔══╝░░
    //███████╗███████╗░░╚██╔╝░░███████╗███████╗░░███████╗
    //╚══════╝╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░░╚══════╝


  case 2:
    level1.stop();
    if (level2.isPlaying() == false) {
      level2.play();
    }


    if (p1.isMovingForward == true) {
      TankForward.isAnimating = true;
    } else if (p1.isMovingBack == true) {
      TankBackward.isAnimating = true;
    }

    // Change the image mode so now we specify the image
    // position using the image center rather than top-left
    // corner

    // Draw the image centred about [x, y]
    //p1.render();
    // Now we want to rotate the image 'in position'
    pushMatrix(); // remember current drawing matrix)
    translate(p1.x, p1.y);
    rotate(radians(p1.angle)); // rotate player based on angle
    p1.render(0, 0);
    if (TankForward.isAnimating == true) {
      TankForward.display(0, 0);
    } else if (TankBackward.isAnimating == true) {
      TankBackward.display(0, 0);
    } else {
      blueTank.resize(90, 90);
      image(blueTank, 0, 0);
    }
    popMatrix(); // restore previous graphics matrix
    p1.runRotations();
    p1.move();

    // player cheks collisions with all barriers
    //p1.checkBarrier(b1);
    //p1.checkBarrier(leftWall);
    //p1.checkBarrier(rightSideWall);
    //p1.checkBarrier(topWall);
    //p1.checkBarrier(bottomWall);

    textSize(50);
    text(p1.life, 200, 100);
    text(score, width-400, 100);


    if (p1.health()) {
      state = 4;
      death.play();
      //println("PLAYER IS DEAD AND IN THE FINAL GAME THE GAMESTATE WILL CHANGE");
    }


    ////////////////////////////////////////////////// Barrier Stuff
    for (Barrier aBarrier : barrierListLVL2) {
      aBarrier.render();
      p1.checkBarrier(aBarrier);
    }

    ////////////////////////////////////////////////////Player Bullet Stuff
    for (Bullet aBullet : bulletList) {
      aBullet.resetBoundaries();
      aBullet.render();
      aBullet.move();
      aBullet.bounceRemove();
      aBullet.hitPlayer(p1);
      for (Barrier aBarrier : barrierListLVL2) {
        aBullet.bounce(aBarrier);
      }
      for (Enemy anEnemy : enemyListLVL2) {
        aBullet.hitEnemy(anEnemy);
      }
    }


    /////////////////////// ERROR
    // for loop that removes a bullet when shouldRemove is true
    for (int i = bulletList.size()-1; i >= 0; i=i-1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }


    ////////////////////////////////////////////////////Enemy Stuff
    for (Enemy anEnemy : enemyListLVL2) {
      anEnemy.render();
      anEnemy.health();
      if (anEnemy.shoot()) {
        // above and right
        if (p1.x>anEnemy.x && p1.y < anEnemy.y) {
          angle = int(random(270, 360));
        }
        // below and right
        else if (p1.x > anEnemy.x && p1.y > anEnemy.y) {
          angle = int(random(0, 90));
        }
        // below and left
        else if (p1.x < anEnemy.x && p1.y > anEnemy.y) {
          angle = int(random(90, 180));
        }
        //above and right
        else if (p1.x < anEnemy.x && p1.y < anEnemy.y) {
          angle = int(random(180, 270));
        }
        bulletList.add(new Bullet(anEnemy.x, anEnemy.y, angle, 0));
      }
    }

    // for loop that removes enemies when hit by bullet
    for (int i = enemyListLVL2.size()-1; i >= 0; i=i-1) {
      Enemy anEnemy = enemyListLVL2.get(i);

      if (anEnemy.isDead == true) {
        enemyListLVL2.remove(anEnemy);
        killCount++;
        score +=100;
      }
    }

    if (killCount == 4) {
      killCount = 0;
      p1.x = 125;
      p1.y = height/2;
      p1.angle = 0;

      bulletList.clear();
      state=3;
    }

    ////////////////////////////////////////////////////Enemy Bullet Stuff

    //  for (EnemyBullet anEnemyBullet : eBulletList) {
    //    anEnemyBullet.resetBoundaries();
    //    anEnemyBullet.render();
    //    anEnemyBullet.move();
    //    anEnemyBullet.bounceRemove();
    //    anEnemyBullet.hitPlayer(p1);
    //  }

    break;

    //////////////////////////////////////////////////////////////////////////////////////////
    //██╗░░░░░███████╗██╗░░░██╗███████╗██╗░░░░░░░██████╗░
    //██║░░░░░██╔════╝██║░░░██║██╔════╝██║░░░░░░░╚════██╗
    //██║░░░░░█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░░░░█████╔╝
    //██║░░░░░██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░░░░╚═══██╗
    //███████╗███████╗░░╚██╔╝░░███████╗███████╗░░██████╔╝
    //╚══════╝╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░░╚═════╝░


  case 3:

    level2.stop();
    if (level3.isPlaying() == false) {
      level3.play();
    }

    if (p1.isMovingForward == true) {
      TankForward.isAnimating = true;
    } else if (p1.isMovingBack == true) {
      TankBackward.isAnimating = true;
    }

    // Change the image mode so now we specify the image
    // position using the image center rather than top-left
    // corner

    // Draw the image centred about [x, y]
    //p1.render();
    // Now we want to rotate the image 'in position'
    pushMatrix(); // remember current drawing matrix)
    translate(p1.x, p1.y);
    rotate(radians(p1.angle)); // rotate player based on angle
    p1.render(0, 0);
    if (TankForward.isAnimating == true) {
      TankForward.display(0, 0);
    } else if (TankBackward.isAnimating == true) {
      TankBackward.display(0, 0);
    } else {
      blueTank.resize(90, 90);
      image(blueTank, 0, 0);
    }
    popMatrix(); // restore previous graphics matrix
    p1.runRotations();
    p1.move();

    // player cheks collisions with all barriers
    //p1.checkBarrier(b1);
    //p1.checkBarrier(leftWall);
    //p1.checkBarrier(rightSideWall);
    //p1.checkBarrier(topWall);
    //p1.checkBarrier(bottomWall);

    textSize(50);
    text(p1.life, 200, 100);
    text(score, width-400, 100);


    if (p1.health()) {
      state = 4;
      death.play();
      //println("PLAYER IS DEAD AND IN THE FINAL GAME THE GAMESTATE WILL CHANGE");
    }


    ////////////////////////////////////////////////// Barrier Stuff
    for (Barrier aBarrier : barrierListLVL3) {
      aBarrier.render();
      p1.checkBarrier(aBarrier);
    }

    ////////////////////////////////////////////////////Player Bullet Stuff
    for (Bullet aBullet : bulletList) {
      aBullet.resetBoundaries();
      aBullet.render();
      aBullet.move();
      aBullet.bounceRemove();
      aBullet.hitPlayer(p1);
      for (Barrier aBarrier : barrierListLVL3) {
        aBullet.bounce(aBarrier);
      }
      for (Enemy anEnemy : enemyListLVL3) {
        aBullet.hitEnemy(anEnemy);
      }
    }


    /////////////////////// ERROR
    // for loop that removes a bullet when shouldRemove is true
    for (int i = bulletList.size()-1; i >= 0; i=i-1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }


    ////////////////////////////////////////////////////Enemy Stuff
    for (Enemy anEnemy : enemyListLVL3) {
      anEnemy.render();
      anEnemy.health();
      if (anEnemy.shoot()) {
        // above and right
        if (p1.x>anEnemy.x && p1.y < anEnemy.y) {
          angle = int(random(270, 360));
        }
        // below and right
        else if (p1.x > anEnemy.x && p1.y > anEnemy.y) {
          angle = int(random(0, 90));
        }
        // below and left
        else if (p1.x < anEnemy.x && p1.y > anEnemy.y) {
          angle = int(random(90, 180));
        }
        //above and right
        else if (p1.x < anEnemy.x && p1.y < anEnemy.y) {
          angle = int(random(180, 270));
        }
        bulletList.add(new Bullet(anEnemy.x, anEnemy.y, angle, 0));
      }
    }

    // for loop that removes enemies when hit by bullet
    for (int i = enemyListLVL3.size()-1; i >= 0; i=i-1) {
      Enemy anEnemy = enemyListLVL3.get(i);

      if (anEnemy.isDead == true) {
        enemyListLVL3.remove(anEnemy);
        killCount++;
        score +=100;
      }
    }

    if (killCount == 5) {
      killCount = 0;
      p1.x = 125;
      p1.y = height/2;
      p1.angle = 0;

      bulletList.clear();
      state=5;
    }

    ////////////////////////////////////////////////////Enemy Bullet Stuff

    //  for (EnemyBullet anEnemyBullet : eBulletList) {
    //    anEnemyBullet.resetBoundaries();
    //    anEnemyBullet.render();
    //    anEnemyBullet.move();
    //    anEnemyBullet.bounceRemove();
    //    anEnemyBullet.hitPlayer(p1);
    //  }


    break;






    ////////////////////////////////////////////////////////////////////
    //██╗░░░░░░█████╗░░██████╗███████╗
    //██║░░░░░██╔══██╗██╔════╝██╔════╝
    //██║░░░░░██║░░██║╚█████╗░█████╗░░
    //██║░░░░░██║░░██║░╚═══██╗██╔══╝░░
    //███████╗╚█████╔╝██████╔╝███████╗
    //╚══════╝░╚════╝░╚═════╝░╚══════╝


  case 4:
    level1.stop();
    level2.stop();
    level3.stop();
    death.rate(0.1);
    if(death.isPlaying() == false){
    death.play();
    }

    background(170, 20, 20);
    fill(255, 255, 255);
    textAlign(CENTER);
    textSize(200);
    text("YOU DIED", width/2, height/2);
    textSize(50);
    text(score, width/2, height-300);
    text("Press r to try again", width/2, height - 200);
    break;



    ////////////////////////////////////////////////////////////////////
    //██╗░░░░░░░██╗██╗███╗░░██╗██╗
    //██║░░██╗░░██║██║████╗░██║██║
    //╚██╗████╗██╔╝██║██╔██╗██║██║
    //░████╔═████║░██║██║╚████║╚═╝
    //░╚██╔╝░╚██╔╝░██║██║░╚███║██╗
    //░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝

  case 5:
  level3.stop();
  if(win.isPlaying() == false){
    win.play();
  }
  
    background(0, 190, 255);
    fill(255, 255, 255);
    textAlign(CENTER);
    textSize(200);
    text("YOU WIN!", width/2, height/2);
    textSize(50);
    text(score, width/2, height-300);
    text("Press r to play again", width/2, height - 200);
    break;
  }


  // Final curly
}




void keyPressed() {
  if (key == 'a') {
    p1.rotatingLeft = true;
  }
  if (key == 'd') {
    p1.rotatingRight = true;
  }

  if (key == 'w') {
    p1.isMovingForward = true;
  }
  if (key == 's') {
    p1.isMovingBack = true;
  }

  if (key == ' ') {
    // make player bullet
    bulletList.add(new Bullet(p1.x, p1.y, p1.angle, 1));
    playerShoot.play();
  }

  if (key == 'r') {
    state = 0;
    score = 0;
    killCount = 0;
    p1.life = 3;
    p1.x = 125;
    p1.y = height/2;
    p1.angle = 0;

    e1_1 = new Enemy(width-(width/4), height-(height/4));
    e2_1 = new Enemy(width-(width/4), height/4);
    enemyListLVL1.clear();
    enemyListLVL1.add(e1_1);
    enemyListLVL1.add(e2_1);

    e1_2 = new Enemy(width/2 + 300, height/2);
    enemyListLVL2.clear();
    enemyListLVL2.add(e1_2);

    e1_3 = new Enemy(width/3, 150);
    e2_3 = new Enemy(width/3, height-150);
    e3_3 = new Enemy(width/2, height/2);
    e4_3 = new Enemy(width-(width/7), 100);
    e5_3 = new Enemy(width-(width/7), height-100);
    enemyListLVL3.clear();
    enemyListLVL3.add(e1_3);
    enemyListLVL3.add(e2_3);
    enemyListLVL3.add(e3_3);
    enemyListLVL3.add(e4_3);
    enemyListLVL3.add(e5_3);

    bulletList.clear();
    //for( Enemy anEnemy : enemyListLVL1){
    //anEnemy.isDead = false;
    //}
    
    level1.stop();
    level2.stop();
    level3.stop();
    death.stop();
    win.stop();
    
  }
}


void keyReleased() {
  // " if key aa' OR (||) key 'd' is not pressed..."
  if (key == 'a' || key == 'd') {
    p1.runReset();
  }

  if (key == 'a') {
    p1.rotatingRight = false;
  }
  if (key == 'd') {
    p1.rotatingRight = false;
  }

  if (key == 'w') {
    p1.isMovingForward = false;
  }
  if (key == 's') {
    p1.isMovingBack = false;
  }
}
