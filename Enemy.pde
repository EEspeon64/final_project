interface Enemy {
  void all();
  void act();
  void show();
  void takeDamage();
  void dealDamage();
  boolean dead();
}

class Boko implements Enemy {
  float health;
  float x;
  float y;
  float dx;
  float dy;
  Boko(float posX, float posY) {
    health = 60;
    x = posX;
    y = posY;
  }
  void all() {
    if (!dead()) {
      show();
      if (paused == false) {
        act();
        takeDamage();
        dealDamage();
      }
    }
  }
  void act() {
    if (x<playerx) {
      dx = 1;
    }
    if (x>playerx) {
      dx = -1;
    }
    if (y<playery) {
      dy = 1;
    } else {
      dy = -1;
    }
    x += dx;
    y += dy;
  }
  void show() {
    noStroke();
    fill(200, 125, 75);
    ellipse(x, y, 50, 50);
    //Health bar
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(x - 26, y - 41, 51, 11);
    noStroke();
    fill(200, 125, 75);
    rect(x - 25, y - 40, health * 0.8333, 10);
  }
  void takeDamage() {
    if (dist(swordx2, swordy2, x, y)<=25) {
      if (gotswordr==true) {
        health--;
      }
      if (gotswordm==true) {
        health = health-2;
      }
    }
    if (dist(playerx, playery, x, y) < spinSize - 25 && spin == true) {
      if (gotswordr==true) {
        health = health - 2;
      }
      if (gotswordm==true) {
        health = health - 3;
      }
    }
  }
  void dealDamage() {
    if ((dist(x, y, playerx, playery) < 50) && !dead() && paused == false) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
  }
  boolean dead() {
    if (health <= 0) return true;
    return false;
  }
}

class Ganon implements Enemy {
  float health;
  float x;
  float y;
  float dx;
  float dy;
  float time = 0;

  Ganon(float posx, float posy) {
    x = posx;
    y = posy;
    health = 600;
  }
  void all() {
    if (!dead()) {
      show();
      if (paused == false) {
        act();
        takeDamage();
        dealDamage();
      }
    }
  }
  void act() {
    time++;
    x += dx;
    y += dy;
    if (time > 250) time = 0;
    if (time<=150) {
      if (x < playerx) {
        dx = 2;
      }
      if (x > playerx) {
        dx = -2;
      }
      if (y < playery) {
        dy = 2;
      }
      if (y > playery) {
        dy = -2;
      }
    } else if (time<=200 && time>=175) {
      if (x<playerx) {
        dx=10;
      }
      if (x>playerx) {
        dx=-10;
      }
      if (y<playery) {
        dy=10;
      }
      if (y>playery) {
        dy=-10;
      }
    } else {
      dx=0;
      dy=0;
    }
  }
  void show() {
    //Health bar
    fill(255);
    textSize(50);
    text("Ganon, Beast of Power", 250, 50);
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(99, 64, 801, 21);
    fill(115, 15, 105);
    noStroke();
    rect(100, 65, health*1.333, 20);
    //body
    fill(115, 15, 105);
    ellipse(x, y, 150, 150);
    fill(240, 225, 190);
    triangle(x + 50, y + 55, x + 20, y + 55, x + 35, y + 23);
    triangle(x - 50, y + 55, x - 20, y + 55, x - 35, y + 20);
    fill(200, 5, 40);
    triangle(x - 55, y - 25, x - 50, y - 50, x - 10, y - 25);
    triangle(x + 55, y - 25, x + 50, y - 50, x + 10, y - 25);
    fill(75, 10, 55);
    ellipse(x, y + 20, 30, 30);
    fill(0);
    ellipse(x + 6, y + 20, 4, 20);
    ellipse(x - 6, y + 20, 4, 20);
    stroke(0);
    line(x + 20, y + 55, x - 20, y + 55);
    noStroke();
  }
  void takeDamage() {
    if (dist(swordx2, swordy2, x, y)<=75) {
      if (gotswordr==true) {
        health--;
      }
      if (gotswordm==true) {
        health = health-2;
      }
    }
    if (dist(playerx, playery, x, y) < spinSize + 70 && spin == true) {
      if (gotswordr==true) {
        health = health - 2;
      }
      if (gotswordm==true) {
        health = health - 3;
      }
    }
  }
  void dealDamage() {
    if ((dist(x, y, playerx, playery) < 100) && !dead() && paused == false) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
  }
  boolean dead() {
    if (health <= 0) return true;
    return false;
  }
}

class Missile implements Enemy {
  float x;
  float y;
  float dx;
  float dy;
  float spawnx;
  float spawny;
  float time;
  Missile(float posx, float posy, float t) {
    x = posx;
    y = posy;
    spawnx = posx;
    spawny = posy;
    time = t;
  }
  void all() {
    show();
    if (paused == false && !dead()) {
      act();
      takeDamage();
      dealDamage();
    }
  }
  void act() {
    time++;
    x += dx;
    y += dy;
    if (dist(playerx, playery, spawnx, spawny) - 35>=dist(x, y, spawnx, spawny)) {
      if (x>=playerx) {
        dx=-5;
      }
      if (x<=playerx) {
        dx=5;
      }
      if (y>=playery) {
        dy=-5;
      }
      if (y<=playery) {
        dy=5;
      }
    }
  }
  void show() {
    fill(175, 175, 225);
    ellipse(x, y, 40, 40);
  }
  void takeDamage() {
  }
  void dealDamage() {
    if (dist(x, y, playerx, playery)<45) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
  }
  boolean dead() {
    if (time > 110) return true;
    return false;
  }
}

class Specter implements Enemy {
  float x;
  float y;
  float theta;
  float health;
  Specter() {
    theta = 0;
    health = 200;
    x = 500 + 300*cos(theta);
    y = 375 + 250*sin(theta);
  }
  void all() {
    if (!dead()) {
      show();
      if (paused == false) {
        act();
        takeDamage();
        dealDamage();
      }
    }
  }
  void act() {
    theta += 0.025;
    if (theta > 6.28) theta = 0;
    x = 500 + 300*cos(theta);
    y = 375 + 250*sin(theta);
  }
  void show() {
    //Health bar
    fill(255);
    textSize(50);
    text("Spectral Eagle, Spirit of Wisdom", 150, 50);
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(99, 64, 801, 21);
    fill(100, 100, 200);
    noStroke();
    rect(100, 65, health*4, 20);
    //body
    stroke(175, 175, 225);
    strokeWeight(4);
    noFill();
    triangle(x, y, x - 90, y + 22*sin(3.5*theta + 0.01), x - 100, y + 25*sin(3 * theta));
    triangle(x, y, x + 90, y + 22*sin(3.5*theta + 0.01), x + 100, y + 25*sin(3 * theta));
    noStroke();
    fill(175, 175, 225);
    ellipse(x, y, 100, 100);
    fill(240, 240, 255);
    ellipse(x - 25, y - 10, 20, 20);
    ellipse(x + 25, y - 10, 20, 20);
    fill(222, 222, 0);
    triangle(x - 12, y + 3, x + 12, y + 3, x, y + 60);
  }
  void takeDamage() {
    if (dist(swordx2, swordy2, x, y) <= 50) {
      if (gotswordr==true) {
        health--;
      }
      if (gotswordm==true) {
        health = health-2;
      }
    }
    if (dist(playerx, playery, x, y) < spinSize + 35 && spin == true) {
      if (gotswordr==true) {
        health = health - 2;
      }
      if (gotswordm==true) {
        health = health - 3;
      }
    }
  }
  void dealDamage() {
  }
  boolean dead() {
    if (health <= 0) return true;
    return false;
  }
  float getx() {
    return x;
  }
  float gety() {
    return y;
  }
}

class SwampMonster implements Enemy {
  float health;
  float x;
  float y;
  float dx;
  float dy;
  float time;
  float opacity;
  float waveRadius;
  float waveSize;
  float waveCenterx;
  float waveCentery;
  boolean wave;
  SwampMonster() {
    health = 400;
    opacity = 255;
    x = 500;
    y = 350;
    time = 0;
    waveRadius = 0;
    waveCenterx = -50;
    waveCentery = -50;
    // x = 60 + random(880);
    //  y = 60 + random(630);
  }
  void all() {
    if (!dead()) {
      if (paused == false) {
        act();
      }
      show();
    }
  }
  void act() {
    time++;
    if (time < 300) {
      takeDamage();
      dealDamage();
      waveSize = (430 - time) / 20;
      waveRadius += 5;
      if (x<playerx) {
        dx = 1;
      }
      if (x>playerx) {
        dx = -1;
      }
      if (y<playery) {
        dy = 1;
      } else {
        dy = -1;
      }
      x += dx;
      y += dy;
    } else if (time < 430) {
      opacity = 255 - ((time - 300) * 2);
      waveRadius += 5;
      waveSize = (430 - time) / 20;
    } else if (time < 435) {
      wave = false;
      x = playerx;
      y = playery;
    } else if (time < 520) {
      opacity = (time - 435) * (255/85);
    } else {
      waveRadius = 0;
      waveCenterx = x;
      waveCentery = y;
      wave = true;
      time = 0;
    }
  }
  void show() {
    if (wave) {
      //wave
      noFill();
      strokeWeight(waveSize);
      stroke(130, 0, 0, opacity);
      ellipse(waveCenterx, waveCentery, waveRadius, waveRadius);
      noStroke();
    }
    //Health bar
    fill(255);
    textSize(50);
    text("Mud Lurker, Guardian of Courage", 150, 50);
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(99, 64, 801, 21);
    fill(96, 126, 6);
    noStroke();
    rect(100, 65, health*2, 20);
    //body
    noStroke();
    fill(96, 126, 6, opacity);
    ellipse(x, y, 100, 100);
    fill(255, 255, 225, opacity);
    ellipse(x, y - 15, 30, 30);
    fill(0, opacity);
    ellipse(x, y - 15, 10, 29);
    fill(130, 0, 0, opacity);
    ellipse(x, y - 15, 8, 25);
  }
  void takeDamage() {
    if (dist(swordx2, swordy2, x, y) <= 50) {
      if (gotswordr==true) {
        health--;
      }
      if (gotswordm==true) {
        health = health-2;
      }
    }
    if (dist(playerx, playery, x, y) < spinSize + 35 && spin == true) {
      if (gotswordr==true) {
        health = health - 2;
      }
      if (gotswordm==true) {
        health = health - 3;
      }
    }
  }
  void dealDamage() {
    if ((dist(x, y, playerx, playery) < 50) && !dead() && !paused) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
    if ((dist(waveCenterx, waveCentery, playerx, playery) < waveRadius/2 + 25) && (dist(waveCenterx, waveCentery, playerx, playery) > waveRadius/2 - 25) && !dead() && !paused && wave) {
      if (shield==false) {
        playerHealth--;
        //println("owie " + waveRadius);
      }
    }
  }
  boolean dead() {
    if (health <= 0) return true;
    return false;
  }
}

class Adlez implements Enemy {
  float health;
  float x;
  float y;
  float dx;
  float dy;
  float opacity;
  float hitRadius;
  float time = 0;
  float[] waveRadii;
  float[] dwaveRadii;
  float[] waveCenterx;
  float[] waveCentery;
  PVector[] missilePos;
  PVector[] missileVel;

  Adlez() {
    x = 500;
    y = 375;
    health = 400;
    waveRadii = new float[3];
    dwaveRadii = new float[3];
    waveCenterx = new float[3];
    waveCentery = new float[3];
    opacity = 255;
  }
  void all() {
    if (!dead()) {
      show();
      if (paused == false) {
        act();
        takeDamage();
        dealDamage();
      }
    }
  }
  void act() {
    time++;
    for (int n = 0; n < 3; n++) {
      waveRadii[n] += dwaveRadii[n];
    }
    if (time < 200) {
      x += dx;
      y += dy;
      hitRadius = 25;
      if (x<playerx) {
        dx=4;
      }
      if (x>playerx) {
        dx=-4;
      }
      if (y<playery) {
        dy=4;
      }
      if (y>playery) {
        dy=-4;
      }
      takeDamage();
      //dealDamage();
    } else if (time < 255) {
      //reset waves
      for (int n = 0; n < 3; n++) {
        waveRadii[n] = 0;
        dwaveRadii[n] = 0;
      }
      opacity = 255 - ((time - 200) * 5);
    } else if (time < 260) {
      x = playerx;
      y = playery;
    } else if (time < 285) {
      opacity = (time - 260) * 10.2;
      waveCenterx[0] = x;
      waveCentery[0] = y;
    } else if (time < 340) {
      opacity = 255 - ((time - 285) * 5);
      dwaveRadii[0] = 8;
    } else if (time < 345) {
      x = playerx;
      y = playery;
    } else if (time < 370) {
      opacity = (time - 345) * 10.2;
      waveCenterx[1] = x;
      waveCentery[1] = y;
    } else if (time < 425) {
      opacity = 255 - ((time - 370) * 5);
      dwaveRadii[1] = 8;
    } else if (time < 430) {
      x = playerx;
      y = playery;
    } else if (time < 455) {
      opacity = (time - 430) * 10.2;
      waveCenterx[2] = x;
      waveCentery[2] = y;
    } else if (time < 600) {
      dwaveRadii[2] = 8;
      hitRadius = 25;
      x += dx;
      y += dy;
      if (x<playerx) {
        dx=2;
      }
      if (x>playerx) {
        dx=-2;
      }
      if (y<playery) {
        dy=2;
      }
      if (y>playery) {
        dy=-2;
      }
      takeDamage();
      //dealDamage();
    } else if (time < 615) {
      hitRadius = 25;
      x += dx;
      y += dy;
      if (x<500) {
        dx=5;
      }
      if (x>500) {
        dx=-5;
      }
      if (y<375) {
        dy=5;
      }
      if (y>375) {
        dy=-5;
      }
      takeDamage();
      //dealDamage();
    } else {
     time = 0; 
    }
  }
  void show() {
    //waves
    for (int n = 0; n < 3; n++) {
      noFill();
      strokeWeight(5);
      stroke(130, 0, 0);
      ellipse(waveCenterx[n], waveCentery[n], waveRadii[n], waveRadii[n]);
      noStroke();
    }
    //body
    fill(140, 10, 30, opacity);
    ellipse(x, y-10, 55, 55);
    ellipse(x-25, y+5, 5, 40);
    ellipse(x+25, y+5, 5, 40);
    fill(235, 200, 200, opacity);
    ellipse(x, y, 50, 50);
    //Health bar
    fill(255);
    textSize(50);
    text("Adlez, Scourge of Hyrule", 250, 50);
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(99, 64, 801, 21);
    fill(140, 10, 30);
    noStroke();
    rect(100, 65, health*2, 20);
  }
  void takeDamage() {
    if (dist(swordx2, swordy2, x, y) <= 25) {
      health = health-2;
    }
    if (dist(playerx, playery, x, y) < spinSize + 25 && spin == true) {
      health = health - 3;
    }
  }
  void dealDamage() {
    if ((dist(x, y, playerx, playery) < 100) && !dead() && paused == false) {
      if (shield==false) {
        playerHealth--;
      } else {
        playerHealth=playerHealth-0.2;
      }
    }
  }
  boolean dead() {
    if (health <= 0) return true;
    return false;
  }
}
