import processing.sound.*;

int playerx = 500;
int playery = 325;
int playerxSpeed=0;
int playerySpeed=0;
int healthr;
int healthg;
int healthb;
float screen=11;
float save=0;
int swordTimer=0;
int roll=0;
int rollTimer=0;
int rollTimerSpeed=0;
int facingL=1;
int zeldaTimer=0;
int trifade=255;
int spinSize=-10;
int spinSpeed;
int spinSpeedtime;
int spinSpeedtimeSpeed;
int spinholdTimer;
int spinholdTimerSpeed;
int shieldTimer=0;
int greenpath;
float treeRadius;
float treeColorFactor;
float tree1pos;
float tree2pos;
float tree3pos;
float tree4pos;
float tree5pos;
float playerHealth = 100;
float savePlayerHealth = 100;
float swordx0;
float swordy0;
float swordx1;
float swordy1;
float swordx2;
float swordy2;
float zeldax=500;
float zelday=355;
float zeldaxSpeed=0;
float zeldaySpeed=0;
float zeldaHealth=400;
float savezeldaHealth;
float time=0;
float time2=0;
float scoretime=72000;
float score=0;
float finalscore;
float blueMissilex=500;
float blueMissiley=375;
float blueMissile2x=500;
float blueMissile2y=375;
float bluexSpeed=0;
float blueySpeed=0;
float bluex2Speed=0;
float bluey2Speed=0;
float bluetheta=0;
float bluethetaSpeed=0;
float bluebossx=-100;
float bluebossy=-100;
float bluebossHealth=250;
float greenbossx=500;
float greenbossy=375;
float greenbossHealth=150;
boolean gotswordr=false;
boolean gotswordm=false;
boolean clicked=false;
boolean ganonlocked=false;
boolean gottri=false;
boolean gottriblue=false;
boolean gottrigreen=false;
boolean gottriforce=false;
boolean bokogo=false;
boolean spin=false;
boolean paused=false;
boolean shield=false;
Enemy[] enemies = new Enemy[5];
PImage title;
SoundFile fieldTheme;
SoundFile titleTheme;
void setup() {
  size(1000, 750);
  title=loadImage("titleLogo.png");
  titleTheme = new SoundFile(this, "titleTheme.mp3");
  fieldTheme = new SoundFile(this, "fieldTheme.mp3");
}
void draw() {
  //debug
  //println("");
  playMusic();
  checksAndResets();
  //game over screen
  if (screen==-1) {
    finalscore=score;
    background(125, 85, 85);
    textSize(100);
    fill(62.5, 42.5, 42.5);
    text("Game Over", 200, 200);
    textSize(50);
    text("Score: "+finalscore, 250, 300);
    textSize(10);
    text("Click Here to Retry", 455, 675);
    strokeWeight(7);
    stroke(62.5, 42.5, 42.5);
    noFill();
    rect(450, 650, 100, 50);
    noStroke();
    //retry button
    if (mousePressed&&mouseX>450&&mouseX<550&&mouseY>650&&mouseY<700) {
      reset();
    }
  }
  //menu screen
  if (screen==0) {
    background(255);
    fill(229, 92, 0);
    textSize(75);
    text("Path of the Triforce", 200, 600);
    fill(24, 30, 15);
    textSize(17);
    text("Start Game", 532, 675);
    text("How to Play", 382, 675);
    noFill();
    stroke(120, 150, 75);
    strokeWeight(7);
    rect(525, 650, 100, 50);
    rect(375, 650, 100, 50);
    //picture
    image(title, 40, 25, title.width*3, title.height*3);
    if (mousePressed&&mouseX>525&&mouseX<625&&mouseY>650&&mouseY<700) {
      screen=1.5;
      time=0;
      playerx=300;
      playery=500;
    }
    if (mousePressed&&mouseX>375&&mouseX<475&&mouseY>650&&mouseY<700) {
      screen=1;
      time=0;
    }
  }
  //how to play screen
  if (screen==1) {
    background(255);
    //text
    textSize(75);
    fill(70, 100, 60);
    text("Use wasd to move", 0, 80);
    text("Use Shift+WASD to dash", 0, 160);
    text("Click to slash your sword", 0, 240);
    text("Click and hold to use a Spin Attack", 0, 320);
    text("Press f to save your game", 0, 400);
    text("Press q to pause the game", 0, 480);
    text("Press space to shield", 0, 560);
    //next screen mechanic
    fill(24, 30, 15);
    textSize(15);
    text("Back to Menu", 457, 675);
    noFill();
    stroke(120, 150, 75);
    strokeWeight(7);
    rect(450, 650, 100, 50);
    if (mousePressed&&mouseX>450&&mouseX<550&&mouseY>650&&mouseY<700) {
      screen=0;
      time=0;
    }
  }

  //first overworld screen
  if (screen == 1.5) {
    noStroke();
    background(110, 77, 16.5);
    fill(55, 37, 18.2);
    rect(0, 0, 1000, 200);
    fill(0);
    ellipse(500, 50, 200, 100);
    rect(400, 50, 200, 150);
    link();
    //walls and enter cave
    if (playerx>400 && playerx < 600 && playery < 210) {
      screen = 2;
      time = 0;
      playery = 700;
      enemies[0] = new Boko(750, 500);
    }
    if (playerx >= 975 && gotswordr == true) {
      enemies[0] = new Boko(900, 325);
      enemies[1] = new Boko(0, 325);
      screen = 3;
      playerx = 50;
    } else if (playerx >= 975) {
      playerx=968;
    }
    if (playerx <= 25) {
      playerx = 32;
    }
    if (playery <= 195) {
      playery = 202;
    }
    if (playery >= 725) {
      playery = 718;
    }
  }
  //sword tutor screen
  if (screen==2) {
    swordTutorScreen();
    link();
    //next screen mechanic
    if (playery > 700 && enemies[0].dead()) {
      screen = 1.5;
      playery = 250;
      playerx = 500;
      time=0;
      score=100;
    } else if (playerx>=975) {
      playerx=968;
    }
  }
  //third screen
  if (screen==3) {
    gotswordr=true;
    bokoScreen();
    //next screen mechanic & border
    if (playerx>=975 && enemies[0].dead() && enemies[1].dead()) {
      screen=4;
      playerx=50;
      time=0;
      score=200;
    } else if (playerx>=975) {
      playerx=968;
    }
  }
  //fourth screen
  if (screen==4) {
    background(95, 100, 95);
    //master sword pedestal
    fill(140, 160, 160);
    triangle(740, 375, 835, 315, 835, 435);
    fill(110, 130, 130);
    rect(800, 360, 15, 30);
    //master sword in pedestal & getting master sword
    if (dist(playerx, playery, 810, 375)>25&&gotswordm==false) {
      strokeWeight(7);
      stroke(20, 80, 210);
      line(807, 340, 807, 350);
      stroke(190, 200, 200);
      line(807, 350, 807, 380);
    } else  if (dist(playerx, playery, 810, 375)<25||gotswordm==true) {
      gotswordm=true;
    }
    //Not link
    link();
    //vines
    strokeWeight(7);
    stroke(55, 100, 70);
    line(0, 100, 200, 0);
    line(200, 0, 200, 150);
    line(100, 0, 300, 125);
    line(300, 125, 400, 0);
    line(355, 0, 500, 100);
    line(400, 0, 400, 125);
    line(500, 100, 625, 0);
    line(575, 0, 625, 150);
    line(625, 150, 650, 0);
    line(635, 0, 700, 125);
    line(700, 125, 825, 0);
    line(800, 0, 900, 100);
    line(900, 100, 1000, 0);
    noStroke();
    //next screen mechanic & border
    if (playerx>=975&&gotswordm==true) {
      screen=11;
      playerx=50;
      time=0;
      playerHealth=100;
      score=250;
    } else if (playerx>=975) {
      playerx=968;
    }
  }
  // branch screen
  if (screen==11) {
    time += 1.6666667;
    gotswordm=true;
    noStroke();
    background(110, 77, 16.5);
    //if (gottriblue==true&&gottrigreen==true) {
    fill(252, 248, 36);
    triangle(900, 420, 980, 420, 940, 350);
    fill(200, 10, 10);
    ellipse(940, 395, 30, 30);
    //}
    if (gottriblue==false) {
      fill(252, 248, 36);
      triangle(400, 100, 440, 30, 480, 100);
      fill(90, 90, 200);
      ellipse(440, 75, 30, 30);
    }
    if (gottrigreen==false) {
      fill(252, 248, 36);
      triangle(400, 720, 440, 650, 480, 720);
      fill(10, 100, 10);
      ellipse(440, 695, 30, 30);
    }
    //Not link
    link();
    if (playery<40 && gottriblue==false) {
      screen=14;
      time=0;
      playery=720;
    }
    if (playery > 700 && gottrigreen == false) {
      screen=16;
      playery=30;
      greenpath=0;
      tree1pos=random(-25, 25);
      tree2pos=random(-25, 25);
      tree3pos=random(-25, 25);
      tree4pos=random(-25, 25);
      tree5pos=random(-25, 25);
      time=0;
    }
    if (playerx > 975 ) { //&& gottriblue==true
      screen=5;
      playerx=40;
      enemies[0] = new Boko(900, 325);
      enemies[1] = new Boko(300, 325);
      //&&gottriforce==true
    } else if (playerx>975) {
      playerx=965;
    }
  }
  //wisdom branch screen 1
  if (screen==14) {
    time=time+1;
    time2=time2+1;
    //take damage
    if ((dist(blueMissilex, blueMissiley, playerx, playery)<45)||(dist(blueMissile2x, blueMissile2y, playerx, playery)<45)) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
    if (time>=110) {
      time=0;
      blueMissilex=500;
      blueMissiley=375;
    }
    if (time>=54&&time<=56) {
      blueMissile2x=500;
      blueMissile2y=375;
    }
    //move missiles
    moveBlueMissiles();
    background(100, 110, 110);
    fill(200, 200, 250);
    ellipse(500, 375, 600, 400);
    fill(175, 175, 225);
    ellipse(blueMissilex, blueMissiley, 40, 40);
    ellipse(blueMissile2x, blueMissile2y, 40, 40);
    noFill();
    strokeWeight(30);
    stroke(100, 150, 100, 100);
    rect(0, 0, 1000, 750);
    noStroke();
    //Not link
    link();

    //next screen mechanic & border
    if (playery<=50&&time2>=900) {
      screen=15;
      playery=725;
      time=0;
      time2=0;
      score=350;
    } else if (playery<=0) {
      playery=7;
    }
    //time signal
    fill(160, 160, 200);
    textSize(25);
    if (time2<=900) {
      text("Time remaining: " + (15+(-1*(time2/60))), 320, 50);
    } else {
      text("Go North!", 375, 50);
    }
  }
  //wisdom branch 2 (15)
  if (screen==15) {
    background(100, 110, 110);
    if (bluebossHealth>0) {
      time=time+1;
      time2=time2+1;
      bluethetaSpeed=0.025;
      bluebossx=500+300*cos(bluetheta);
      bluebossy=375+250*sin(bluetheta);
      //take damage
      if ((dist(blueMissilex, blueMissiley, playerx, playery)<45)||(dist(blueMissile2x, blueMissile2y, playerx, playery)<45)) {
        if (shield==false) {
          playerHealth--;
        } else {
          playerHealth=playerHealth-0.2;
        }
      }
      //reset missiles (time out missiles)
      if (time>=110) {
        time=0;
        blueMissilex=bluebossx;
        blueMissiley=bluebossy;
      }
      if (time>=54&&time<=56) {
        blueMissile2x=bluebossx;
        blueMissile2y=bluebossy;
      }
      //move missiles
      moveBlueMissiles();
      //Health bar
      stroke(0, 0, 0);
      strokeWeight(2);
      noFill();
      rect(bluebossx-51, bluebossy-66, 101, 11);
      fill(100, 100, 200);
      noStroke();
      rect(bluebossx-50, bluebossy-65, bluebossHealth/2, 10);
      //graphics
      fill(175, 175, 225);
      ellipse(bluebossx, bluebossy, 100, 100);
      fill(175, 175, 225);
      ellipse(blueMissilex, blueMissiley, 40, 40);
      ellipse(blueMissile2x, blueMissile2y, 40, 40);
      if (bluebossHealth<5) {
        time=0;
      }
    } else if (gottriblue==false) {
      playerHealth=100;
      time=time++;
      background (125, 135, 135);
      fill (100, 130, 150);
      ellipse (0, 0, 400, 200);
      ellipse (1000, 0, 400, 200);
      ellipse (0, 0, 100, 800);
      ellipse (1000, 0, 100, 800);
      fill(170, 170, 220, 100-2*time);
      ellipse(bluebossx, bluebossy, 100, 100);
      fill (175, 190, 190);
      ellipse (500, 200, 150, 150);
      fill(252, 248, 36);
      triangle(460, 220, 500, 150, 540, 220);
      if (dist(playerx, playery, 500, 200) <50) {
        gottriblue=true;
      }
    } else {
      background (125, 135, 135);
      fill (100, 130, 150);
      ellipse (0, 0, 400, 200);
      ellipse (1000, 0, 400, 200);
      ellipse (0, 0, 100, 800);
      ellipse (1000, 0, 100, 800);
      fill (175, 190, 190);
      ellipse (500, 200, 150, 150);
      textSize(35);
      text ("You got a piece of the triforce! Go get the rest!", 190, 700);
      if (playery>700) {
        screen=11;
        playery=50;
        score=500;
      }
    }
    //Not link
    link();
  }
  //courage branch 1
  if (screen==16) {
    for (int n=0; n<15; n=n+1) {
      treeRadius=random(135, 145);
      treeColorFactor=random(0.9, 1.1);
    }
    background(45, 25, 10);
    fill(50, 100, 70, 255-time*7);
    textSize(60);
    text("Find your way...", 300, 70);
    //Not link
    link();

    //trees
    fill(10*treeColorFactor, 50*treeColorFactor, 15*treeColorFactor, 160);
    ellipse(150+tree1pos, 150+tree1pos, treeRadius, treeRadius);
    fill(10*treeColorFactor, 40*treeColorFactor, 15*treeColorFactor, 150);
    ellipse(850+tree2pos, 100+tree2pos, treeRadius, treeRadius);
    fill(10*treeColorFactor, 50*treeColorFactor, 15*treeColorFactor, 150);
    ellipse(170+tree3pos, 550+tree3pos, treeRadius+10, treeRadius+10);
    fill(5*treeColorFactor, 40*treeColorFactor, 20*treeColorFactor, 200);
    ellipse(900+tree4pos, 670+tree4pos, treeRadius-5, treeRadius-5);
    fill(5*treeColorFactor, 50*treeColorFactor, 30*treeColorFactor, 150);
    ellipse(575+tree5pos, 400+tree5pos, treeRadius+15, treeRadius+15);
    println(greenpath);
    //maze mechanic
    if (playerx>950&&greenpath==0) {
      playerx=50;
      greenpath=1;
      tree1pos=random(-25, 25);
      tree2pos=random(-25, 25);
      tree3pos=random(-25, 25);
      tree4pos=random(-25, 25);
      tree5pos=random(-25, 25);
    }
    if (playery<50&&greenpath==1) {
      playery=700;
      greenpath=2;
      tree1pos=random(-25, 25);
      tree2pos=random(-25, 25);
      tree3pos=random(-25, 25);
      tree4pos=random(-25, 25);
      tree5pos=random(-25, 25);
    }
    if (playerx<50&&greenpath==2) {
      playerx=950;
      screen=17;
      greenbossx=500;
      greenbossy=375;
    }
  }
  //greenboss screen
  if (screen==17) {
    background(50, 22, 8);
    //Not link
    link();

    //frogger (greenboss)
    //(ellipse (greenbossx
  }
  //boko screen 2
  if (screen==5) {
    gotswordm=true;
    noStroke();
    bokoScreen();
    //next screen mechanic & border
    if (playerx>=975 && enemies[0].dead() && enemies[1].dead()) {
      screen=6;
      playerx=50;
      time=0;
      enemies[0] = new Ganon(800, 350);
      enemies[1] = null;
      score=600;
    } else if (playerx>=975) {
      playerx=968;
    }
  }
  //ganon screen
  if (screen==6) {
    background(100, 70, 15);
    enemies[0].all();
    //Not link
    link();
    //trees
    fill(5, 125, 10);
    for (int n=25; n<1001; n=n+150) {
      ellipse(n, 10, 150, 150);
    }
    for (int m=25; m<1001; m=m+150) {
      ellipse(m, 740, 150, 150);
    }
    //next screen mechanic and border
    if (playerx>=975 && enemies[0].dead()) {
      screen=7;
      playerx=500;
      playery=700;
      time=0;
      score=750;
    } else if (playerx>=975) {
      playerx=968;
    }
  }
  if (screen==7) {
    noStroke();
    background(95, 100, 95);
    //background art
    fill(100, 0, 0);
    rect(0, 0, 200, 750);
    rect(800, 0, 200, 750);
    fill(215, 190, 0);
    triangle(100, 75, 25, 200, 175, 200);
    fill(100, 0, 0);
    triangle(62, 137, 137, 137, 100, 200);
    fill(215, 190, 0);
    triangle(900, 75, 825, 200, 975, 200);
    fill(100, 0, 0);
    triangle(863, 137, 937, 137, 900, 200);
    //zelda
    fill(215, 190, 0);
    ellipse(500, 345, 55, 55);
    ellipse(475, 360, 5, 40);
    ellipse(525, 360, 5, 40);
    fill(255, 255, 255);
    ellipse(500, 350, 50, 50);
    fill(215, 190, 0);
    textSize(30);
    //zelda talking
    if (time<20) {
      text("Thank you, Link!", 375, 400);
    } else if (time<40) {
      text("You have brought peace to the Triforce,", 200, 400);
    } else if (time<60) {
      text("And the sacred realm of Hyrule!", 280, 400);
    } else {
      screen=8;
    }
    //Not link
    link();
    // if you just happen to hit zelda
    if (dist(swordx2, swordy2, 500, 350)<=25) {
      screen=9;
      time=0;
    }
  }
  //win screen
  if (screen==8) {
    finalscore=score+(scoretime/60);
    background(85, 125, 85);
    textSize(100);
    fill(42.5, 62.5, 42.5);
    text("You Won!", 250, 200);
    textSize(50);
    text("Score: "+finalscore, 250, 300);
    textSize(10);
    text("Click Here to Replay", 455, 675);
    strokeWeight(7);
    stroke(42.5, 62.5, 42.5);
    noFill();
    rect(450, 650, 110, 50);
    noStroke();
    //retry button
    if (mousePressed&&mouseX>450&&mouseX<550&&mouseY>650&&mouseY<700) {
      reset();
      screen = 0;
    }
  }
  if (screen==9) {
    zeldaTimer++;
    background(95, 100, 95);
    if (playerx>975) {
      playerx=975;
    }
    if (playerx<25) {
      playerx=25;
    }
    if (playery>725) {
      playery=725;
    }
    if (playery<25) {
      playery=25;
    }
    //take damage
    if (dist(zeldax, zelday, playerx, playery)<50) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
    //possessed zelda/hilda
    if (time<60) {
      fill(140, 10, 30);
      ellipse(500, 345, 55, 55);
      ellipse(475, 360, 5, 40);
      ellipse(525, 360, 5, 40);
      fill(235, 200, 200);
      ellipse(500, 350, 50, 50);
      fill(140, 10, 30);
      textSize(30);
      //zelda talking
      if (time<20) {
        text("NOOOOO!", 430, 400);
      } else if (time<40) {
        text("You have revealed my true identity,", 250, 400);
      } else if (time<60) {
        text("You will never save Zelda!", 300, 400);
      }
    } else if (time>60) {
      //hit possessed zelda/hilda
      if (paused==false) {
        if (dist(swordx2, swordy2, zeldax, zelday)<=25) {
          zeldaHealth=zeldaHealth-2;
        }
        if (dist(playerx, playery, zeldax, zelday)<spinSize&&spin==true) {
          zeldaHealth=zeldaHealth-3;
        }
      }
      if (zeldaHealth>0) {
        fill(140, 10, 30);
        ellipse(zeldax, zelday-10, 55, 55);
        ellipse(zeldax-25, zelday+5, 5, 40);
        ellipse(zeldax+25, zelday+5, 5, 40);
        fill(235, 200, 200);
        ellipse(zeldax, zelday, 50, 50);
        //Health bar
        stroke(0, 0, 0);
        strokeWeight(2);
        noFill();
        rect(zeldax-26, zelday-41, 51, 11);
        fill(200, 0, 0);
        noStroke();
        rect(zeldax-25, zelday-40, zeldaHealth/8, 10);
        if (paused==false) {
          if (zeldaTimer<=150) {
            if (zeldax<playerx) {
              zeldaxSpeed=5;
            }
            if (zeldax>playerx) {
              zeldaxSpeed=-5;
            }
            if (zelday<playery) {
              zeldaySpeed=5;
            }
            if (zelday>playery) {
              zeldaySpeed=-5;
            }
          } else if (zeldaTimer<=200&&zeldaTimer>=175) {
            if (zeldax<playerx) {
              zeldaxSpeed=10;
            }
            if (zeldax>playerx) {
              zeldaxSpeed=-10;
            }
            if (zelday<playery) {
              zeldaySpeed=10;
            }
            if (zelday>playery) {
              zeldaySpeed=-10;
            }
          } else if (zeldaTimer<225&&zeldaTimer>200) {
            zeldaxSpeed=0;
            zeldaySpeed=0;
            fill(160, 15, 75, 175);
            ellipse(zeldax, zelday, 150, 150);
            fill(140, 10, 30);
            ellipse(zeldax, zelday-10, 55, 55);
            ellipse(zeldax-25, zelday+5, 5, 40);
            ellipse(zeldax+25, zelday+5, 5, 40);
            fill(235, 200, 200);
            ellipse(zeldax, zelday, 50, 50);
            //take damage
            if (dist(zeldax, zelday, playerx, playery)<100) {
              if (shield==false) {
                playerHealth--;
              } else {
                playerHealth=playerHealth-0.2;
              }
            }
          } else {
            zeldaxSpeed=0;
            zeldaySpeed=0;
          }
        }
      } else {
        screen=10;
        playerx=500;
        playery=600;
        time=0;
        score=1500;
      }
    }
    //Not link
    link();
  }
  if (screen==10) {
    noStroke();
    background(95, 100, 95);
    //background art
    fill(25, 0, 175);
    rect(0, 0, 200, 750);
    rect(800, 0, 200, 750);
    fill(215, 190, 0);
    triangle(100, 75, 25, 200, 175, 200);
    fill(25, 0, 175);
    triangle(62, 137, 137, 137, 100, 200);
    fill(215, 190, 0);
    triangle(900, 75, 825, 200, 975, 200);
    fill(25, 0, 175);
    triangle(863, 137, 937, 137, 900, 200);
    //zelda
    fill(215, 190, 0);
    ellipse(500, 345, 55, 55);
    ellipse(475, 360, 5, 40);
    ellipse(525, 360, 5, 40);
    fill(255, 255, 255);
    ellipse(500, 350, 50, 50);
    fill(215, 190, 0);
    textSize(30);
    //zelda talking
    if (time<20) {
      text("Thank you, Link!", 375, 400);
    } else if (time<40) {
      text("You have saved Hyrule and the Triforce,", 200, 400);
    } else if (time<60) {
      text("And me!", 440, 400);
    } else {
      screen=8;
    }
    //Not link
    link();
    //sword
    if (playerx>=975) {
      playerx=968;
    }
  }
}

void keyPressed() {
  if (paused==false) {
    if (key=='w') {
      playerySpeed=-8;
      facingL=4;
    }
    if (key=='a') {
      playerxSpeed=-8;
      facingL=2;
    }
    if (key=='s') {
      playerySpeed=8;
      facingL=3;
    }
    if (key=='d') {
      playerxSpeed=8;
      facingL=1;
    }
  }
  if (key=='f') {
    if (screen!=-1) {
      save=screen;
      savePlayerHealth = playerHealth + (0.25 * (100 - playerHealth));
    }
    savezeldaHealth=zeldaHealth;
  }
  if (key==' '&&shieldTimer<=1) {
    shield=true;
  }
  if (key=='q') {
    paused=!paused;
  }
  if (paused==false) {
    if (key=='W'&&roll==0) {
      playerySpeed=-25;
      roll=1;
      rollTimerSpeed=1;
    }
    if (key=='A'&&roll==0) {
      playerxSpeed=-25;
      roll=1;
      rollTimerSpeed=1;
    }
    if (key=='S'&&roll==0) {
      playerySpeed=25;
      roll=1;
      rollTimerSpeed=1;
    }
    if (key=='D'&&roll==0) {
      playerxSpeed=25;
      roll=1;
      rollTimerSpeed=1;
    }
  }
}
void keyReleased() {
  if (key=='w'||key=='W') {
    playerySpeed=0;
  }
  if (key=='a'||key=='A') {
    playerxSpeed=0;
  }
  if (key=='s'||key=='S') {
    playerySpeed=0;
  }
  if (key=='d'||key=='D') {
    playerxSpeed=0;
  }
  if (key==' ') {
    shield=false;
  }
}
void mousePressed() {
  clicked=true;
  spinSpeed=10;
  spinholdTimerSpeed=1;
  shield=false;
  shieldTimer++;
}
void mouseReleased() {
  spinSpeedtimeSpeed=1;
  spinSpeed=0;
  spinholdTimerSpeed=0;
  spinholdTimer=0;
  spin=true;
  shieldTimer--;
}

void link() {
  stroke(0, 0, 0);
  strokeWeight(2);
  noFill();
  if (spin==true) {
    fill(180, 180, 180, 80);
  }
  ellipse(playerx, playery, spinSize, spinSize);
  noStroke();
  fill(70, 100, 60);
  ellipse(playerx, playery, 50, 50);
  stroke(0, 0, 0);
  strokeWeight(2);
  noFill();
  rect(playerx-26, playery-41, 51, 11);
  fill(healthr, healthg, healthb);
  noStroke();
  rect(playerx-25, playery-40, playerHealth/2, 10);
  //shield
  if (shield==true) {
    strokeWeight(2);
    stroke(150, 150, 150);
    fill(30, 30, 200);
    beginShape();
    vertex(playerx-20, playery-10);
    vertex(playerx+20, playery-10);
    vertex(playerx+17, playery+17);
    vertex(playerx, playery+27);
    vertex(playerx-17, playery+17);
    vertex(playerx-20, playery-10);
    endShape();
    noStroke();
    fill(215, 190, 0);
    triangle(playerx, playery-5, playerx+7.5, playery+8, playerx-7.5, playery+8);
    fill(30, 30, 200);
    triangle(playerx, playery+8, playerx+4, playery+1.5, playerx-4, playery+1.5);
    noFill();
    strokeWeight(2);
    stroke(150, 0, 0);
    arc(playerx, playery+10, 17, 10, 0, PI);
    line(playerx, playery+12, playerx, playery+20);
  } else {
  }
  if (gotswordr || gotswordm || screen > 4) {
    sword();
  }
}

void sword() {
  strokeWeight(7);
  if (gotswordm || screen > 4) {
    stroke(20, 80, 210);
  } else {
    stroke(130, 90, 40);
  }
  line(swordx0, swordy0, swordx1, swordy1);
  stroke(190, 200, 200);
  line(swordx1, swordy1, swordx2, swordy2);
  noStroke();
  //swung sword
  if (shield==false) {
    if (swordTimer<=20&&swordTimer>=1) {
      if (facingL==1) {
        swordx0=playerx+28;
        swordy0=playery+10;
        swordx1=playerx+40;
        swordy1=playery+10;
        swordx2=playerx+80;
        swordy2=playery+10;
      }
      if (facingL==2) {
        swordx0=playerx-28;
        swordy0=playery+10;
        swordx1=playerx-40;
        swordy1=playery+10;
        swordx2=playerx-80;
        swordy2=playery+10;
      }
      if (facingL==3) {
        swordx0=playerx-28;
        swordy0=playery+10;
        swordx1=playerx-28;
        swordy1=playery+20;
        swordx2=playerx-28;
        swordy2=playery+50;
      }
      if (facingL==4) {
        swordx0=playerx+28;
        swordy0=playery-30;
        swordx1=playerx+28;
        swordy1=playery-40;
        swordx2=playerx+28;
        swordy2=playery-70;
      }
    }
  }
  //unswung sword
  if (swordTimer==0||swordTimer>20) {
    swordTimer=0;
    clicked=false;
    if (facingL==2||facingL==3) {
      swordx0=playerx-28;
      swordy0=playery+10;
      swordx1=playerx-28;
      swordy1=playery;
      swordx2=playerx-28;
      swordy2=playery-30;
    }
    if (facingL==1||facingL==4) {
      swordx0=playerx+28;
      swordy0=playery+10;
      swordx1=playerx+28;
      swordy1=playery;
      swordx2=playerx+28;
      swordy2=playery-30;
    }
  }
  if (swordTimer>=61) {
    swordTimer=0;
  }
}


void checksAndResets() {
  //checks and resets
  if (paused==false&&screen!=8&&scoretime>0) {
    scoretime--;
  }
  if (screen!=10 && paused == false) {
    playerx=playerx+playerxSpeed;
    playery=playery+playerySpeed;
  }
  //add Speeds
  if (paused==false) {
    time=time+0.166667;
    zeldax=zeldax+zeldaxSpeed;
    zelday=zelday+zeldaySpeed;
    blueMissilex=blueMissilex+bluexSpeed;
    blueMissiley=blueMissiley+blueySpeed;
    blueMissile2x=blueMissile2x+bluex2Speed;
    blueMissile2y=blueMissile2y+bluey2Speed;
    bluetheta=bluetheta+bluethetaSpeed;
    rollTimer=rollTimer+rollTimerSpeed;
    spinSize=spinSize+spinSpeed;
    spinholdTimer=spinholdTimer+spinholdTimerSpeed;
    spinSpeedtime=spinSpeedtime+spinSpeedtimeSpeed;
  }
  if (clicked==true) {
    swordTimer=swordTimer+1;
  }
  //reset bluetheta
  if (bluetheta>=6.283) {
    bluetheta=0;
  }
  //reset zeldaTimer
  if (zeldaTimer>=250) {
    zeldaTimer=0;
  }
  //reset spinSize
  if (spinSize<=-25) {
    spinSize=-25;
    spinSpeed=0;
    spin=false;
  }
  if (spinSize==0) {
    spin=false;
  }
  //reset spinSpeedtime
  if (spinSpeedtime>10) {
    spinSpeedtime=0;
    spinSpeedtimeSpeed=0;
    spinSpeed=-100;
  }
  //limit spinSize
  if (spinSize>150) {
    spinSpeed=0;
    spinSize=150;
  }
  //limit time you can hold spin attack
  if (spinholdTimer>30) {
    spinSize=0;
  }
  //limit shieldTimer
  if (shieldTimer<=0) {
    shieldTimer=0;
  }
  if (shieldTimer>=120) {
    shieldTimer=120;
  }
  if (paused==false) {
    //hit blueboss
    if (dist(swordx2, swordy2, bluebossx, bluebossy)<=50) {
      bluebossHealth=bluebossHealth-2;
    }
    if (dist(playerx, playery, bluebossx, bluebossy)<spinSize+25&&spin==true) {
      bluebossHealth=bluebossHealth-3;
    }
  }
  //game over mechanic
  if (playerHealth<=0) {
    screen=-1;
  }
  //paused text
  if (paused==true&&screen>0) {
    fill(70, 100, 60);
    textSize(150);
    text("Paused", 250, 400);
  }
  //roll Timer
  if (rollTimer>=60) {
    roll=0;
    rollTimerSpeed=0;
    rollTimer=0;
  }
  //edge boundaries
  if (screen!=13||screen!=14||screen!=15) {
    if (playery<=25) {
      playery=32;
    } else if (playery>=725) {
      playery=718;
    } else if (playerx<=25) {
      playerx=32;
    }
  } else {
    if (playerx>=975) {
      playerx=965;
    } else if (playery>=725) {
      playery=718;
    } else if (playerx<=25) {
      playerx=32;
    }
  }
  //Health bar color control
  if (playerHealth>50) {
    healthr=50;
    healthg=250;
    healthb=50;
  } else if (playerHealth>20) {
    healthr=250;
    healthg=200;
    healthb=0;
  } else {
    healthr=230;
    healthg=35;
    healthb=0;
  }
}

void swordTutorScreen() {
  background(55, 37, 18.2);
  //old boi
  noStroke();
  fill(125, 88, 75);
  ellipse(500, 100, 50, 50);
  //old boi talking
  textSize(30);
  if (time<20) {
    text("It's dangerous to go alone!", 300, 160);
  } else if (time<40) {
    bokogo=true;
    text("Take this!", 400, 160);
    strokeWeight(7);
    stroke(130, 90, 40);
    line(472, 110, 472, 100);
    stroke(190, 200, 200);
    line(472, 100, 472, 70);
    noStroke();
  } else if (!enemies[0].dead()) {
    gotswordr=true;
    text("Oh no! Link! Kill the Bokoblin!", 275, 160);
    //bokoblin
    enemies[0].all();
  } else {
    fill(125, 88, 75);
    text("Thank you. I will heal your wounds. Go on, Link!", 200, 160);
    playerHealth=100;
  }
}

void bokoScreen() {
  noStroke();
  background(110, 77, 16.5);
  enemies[0].all();
  enemies[1].all();
  link();
  //trees
  fill(5, 125, 10);
  for (int n=25; n<1001; n=n+150) {
    ellipse(n, 10, 150, 150);
  }
  for (int m=25; m<1001; m=m+150) {
    ellipse(m, 740, 150, 150);
  }
}

void moveBlueMissiles() {
  if (dist(playerx, playery, bluebossx, bluebossy)-65>=dist(blueMissilex, blueMissiley, bluebossx, bluebossy)) {
    if (blueMissilex>=playerx) {
      bluexSpeed=-5;
    }
    if (blueMissilex<=playerx) {
      bluexSpeed=5;
    }
    if (blueMissiley>=playery) {
      blueySpeed=-5;
    }
    if (blueMissiley<=playery) {
      blueySpeed=5;
    }
  }
  if (dist(playerx, playery, bluebossx, bluebossy)-65>=dist(blueMissile2x, blueMissile2y, bluebossx, bluebossy)) {
    if (blueMissile2x>=playerx) {
      bluex2Speed=-5;
    }
    if (blueMissile2x<=playerx) {
      bluex2Speed=5;
    }
    if (blueMissile2y>=playery) {
      bluey2Speed=-5;
    }
    if (blueMissile2y<=playery) {
      bluey2Speed=5;
    }
  }
}

void reset() {
  playerx=(int)random(100, 900);
  playery=(int)random(100, 650);
  playerxSpeed=0;
  playerySpeed=0;
  screen=save;
  swordTimer=0;
  roll=0;
  rollTimer=0;
  rollTimerSpeed=0;
  facingL=1;
  zeldaTimer=0;
  trifade=255;
  spinSize=-10;
  shieldTimer=0;
  playerHealth=savePlayerHealth;
  zeldax=500;
  zelday=355;
  zeldaxSpeed=0;
  zeldaySpeed=0;
  zeldaHealth=400;
  time=0;
  time2=0;
  scoretime=72000;
  score=0;
  blueMissilex=500;
  blueMissiley=375;
  blueMissile2x=500;
  blueMissile2y=375;
  bluexSpeed=0;
  blueySpeed=0;
  bluex2Speed=0;
  bluey2Speed=0;
  bluetheta=0;
  bluethetaSpeed=0;
  bluebossx=-100;
  bluebossy=-100;
  bluebossHealth=200;
  greenbossx=500;
  greenbossy=375;
  greenbossHealth=150;
  bokogo=false;
  spin=false;
  paused=false;
}

void playMusic() {
  if ((screen == 0 || screen==1) && !titleTheme.isPlaying()) {
    titleTheme.play();
  } else if (screen != 0 && screen != 1 && !fieldTheme.isPlaying()) {
    titleTheme.stop();
    fieldTheme.play();
  }
}
