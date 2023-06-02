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
    if (dist(playerx, playery, x, y) < spinSize && spin == true) {
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
    health = 300;
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
        dx = 3;
      }
      if (x > playerx) {
        dx = -3;
      }
      if (y < playery) {
        dy = 3;
      }
      if (y > playery) {
        dy = -3;
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
    fill(115, 15, 105);
    ellipse(x, y, 100, 100);
    //Health bar
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(x - 51, y - 66, 101, 11);
    fill(200, 0, 0);
    noStroke();
    rect(x - 50, y - 65, health/3, 10);
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
    if (dist(playerx, playery, x, y) < spinSize && spin == true) {
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
    stroke(0, 0, 0);
    strokeWeight(2);
    noFill();
    rect(x - 51, y - 66, 101, 11);
    fill(100, 100, 200);
    noStroke();
    rect(x - 50, y - 65, health/2, 10);
    //body
    fill(175, 175, 225);
    ellipse(x, y, 100, 100);
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
    stroke(0, 0, 0, opacity);
    strokeWeight(2);
    noFill();
    rect(x - 51, y - 66, 101, 11);
    fill(96, 126, 6, opacity);
    noStroke();
    rect(x - 50, y - 65, health/4, 10);
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
