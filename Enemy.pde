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
