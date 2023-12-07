public class object {
  ArrayList<PVector> objPosition, objSpeed, objMovement;
  PVector tokenPosition;
  boolean tokenCollected;
  boolean objOffScreen;
  int randomSpawn;
  float[] newX;
  float[] newY;

  object(boolean initialize) {
    if (initialize) {
      this.objPosition = new ArrayList<PVector>();
      this.objSpeed = new ArrayList<PVector>();
      this.newX = new float[3];
      this.newY = new float[3];
      this.objPosition.add(new PVector(0, 0));
      this.objPosition.add(new PVector(0, 0));
      this.objPosition.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.tokenPosition = new PVector(0, 0);
      this.tokenCollected = true;
      this.objOffScreen = true;
    }
  }

  void runObjects() {
    createToken();
    drawToken();
    createObj();
    objMovement();
    drawObj();
    checkOffScreen();
  }

  void createToken() {
    if (tokenCollected) {
      tokenPosition = PVector.random2D().setMag(390);

      if (tokenPosition.x < 0) {
        tokenPosition.x *= -1;
      }
      tokenPosition.x = round(tokenPosition.x);
      println("x = " + tokenPosition.x);

      if (tokenPosition.y < 0) {
        tokenPosition.y *= -1;
      }
      tokenPosition.y = round(tokenPosition.y);
      println("y = " + tokenPosition.y);

      tokenCollected = false;
    }
  }

  void drawToken() {
    fill(255, 200, 0);
    strokeWeight(1);
    stroke(0);
    ellipse(tokenPosition.x, tokenPosition.y, 20, 20);
    noStroke();
  }

  void createObj() {
    if (objOffScreen) {
      for (int i = 0; i < objPosition.size(); i++) {
        newX[i] = 0;
        newY[i] = 0;
        randomSpawn = (int) random(1, 5);

        for (int j = 0; j < objPosition.size(); j++) {
          switch (randomSpawn) {
          case 1:
            objPosition.get(j).set(random(25, 375), 25);
            objSpeed.get(j).set(random(-5, 5), random(2.5, 5));
            break;
          case 2:
            objPosition.get(j).set(375, random(25, 375));
            objSpeed.get(j).set(random(-5, -2.5), random(-5, 5));
            break;
          case 3:
            objPosition.get(j).set(random(25, 375), 375);
            objSpeed.get(j).set(random(-5, 5), random(-5, -2.5));
            break;
          case 4:
            objPosition.get(j).set(25, random(25, 375));
            objSpeed.get(j).set(random(2.5, 5), random(-5, 5));
            break;
          }
          newX[j] = objPosition.get(j).x;
          newY[j] = objPosition.get(j).y;
          println("obj x: " + objPosition.get(j).x + "\n" + "obj y: " + objPosition.get(j).y);
        }
        objOffScreen = false;
      }
    }
  }

  void objMovement() {
    for (int i = 0; i < objPosition.size(); i++) {
      newX[i] += objSpeed.get(i).x;
      newY[i] += objSpeed.get(i).y;
      objPosition.get(i).set(newX[i], newY[i]);
    }
  }

  void checkOffScreen() {
    if (objPosition.get(0).x > 400 || objPosition.get(0).x < 0 || objPosition.get(0).y > 400 || objPosition.get(0).y < 0) {
      if (objPosition.get(1).x > 400 || objPosition.get(1).x < 0 || objPosition.get(1).y > 400 || objPosition.get(1).y < 0) {
        if (objPosition.get(2).x > 400 || objPosition.get(2).x < 0 || objPosition.get(2).y > 400 || objPosition.get(2).y < 0) {
          objOffScreen = true;
        }
      }
    }
  }

  void drawObj() {
    strokeWeight(1);
    stroke(0);
    fill(200, 0, 0);
    ellipse(objPosition.get(0).x, objPosition.get(0).y, 40, 40);
    ellipse(objPosition.get(1).x, objPosition.get(1).y, 40, 40);
    ellipse(objPosition.get(2).x, objPosition.get(2).y, 40, 40);
  }
}
