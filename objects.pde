// Public class responsible for managing token object and obstacles
public class object {
  // Object variables
  ArrayList<PVector> objPosition, objSpeed, objMovement;
  PVector tokenPosition;
  boolean tokenCollected;
  boolean objOffScreen;
  int randomSpawn;
  float[] newX;
  float[] newY;

  // Constructor to initialize object properties
  object(boolean initialize) {
    if (initialize) {
      // Initializing arrays and properties
      this.objPosition = new ArrayList<PVector>();
      this.objSpeed = new ArrayList<PVector>();
      this.newX = new float[5];
      this.newY = new float[5];
      // Setting default values
      this.objPosition.add(new PVector(0, 0));
      this.objPosition.add(new PVector(0, 0));
      this.objPosition.add(new PVector(0, 0));
      this.objPosition.add(new PVector(0, 0));
      this.objPosition.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.objSpeed.add(new PVector(0, 0));
      this.tokenPosition = new PVector(0, 0);
      this.tokenCollected = true;
      this.objOffScreen = true;
    }
  }

  // Function to handle and run object-related operations during gameplay
  void runObjects() {
    createToken();
    drawToken();
    createObj();
    objMovement();
    drawObj();
    checkOffScreen();
  }

  // Function to generate a new token when collected and at the start of the game
  void createToken() {
    if (tokenCollected) {
      tokenPosition = PVector.random2D().setMag(390);

      // Conditional statement to ensure token spawns on-screen
      if (tokenPosition.x < 0) {
        tokenPosition.x *= -1;
      }
      tokenPosition.x = round(tokenPosition.x);
      println("x = " + tokenPosition.x); // Debugging to make sure token spawns properly

      if (tokenPosition.y < 0) {
        tokenPosition.y *= -1;
      }
      tokenPosition.y = round(tokenPosition.y);
      println("y = " + tokenPosition.y); // Debugging to make sure token spawns properly

      tokenCollected = false;
    }
  }

  // Function to draw the token on the canvas
  void drawToken() {
    fill(255, 200, 0);
    strokeWeight(1);
    stroke(0);
    ellipse(tokenPosition.x, tokenPosition.y, 20, 20);
    noStroke();
  }

  // Function to create new obstacles when needed
  void createObj() {
    if (objOffScreen) {
      // Looping through the array of object positions and movements
      for (int i = 0; i < objPosition.size(); i++) {
        newX[i] = 0;
        newY[i] = 0;
        randomSpawn = (int) random(1, 5);

        // Loop to change spawn location of obstacles and they're moevement direction depending on randomSpawn value
        for (int j = 0; j < objPosition.size(); j++) {
          // Determines spawn position and speed based on canvas edges
          if (randomSpawn==1) {
            objPosition.get(j).set(random(25, 375), 25);
            objSpeed.get(j).set(random(-5, 5), random(2.5, 5));
          } else if (randomSpawn==2) {
            objPosition.get(j).set(375, random(25, 375));
            objSpeed.get(j).set(random(-5, -2.5), random(-5, 5));
          } else if (randomSpawn==3) {
            objPosition.get(j).set(random(25, 375), 375);
            objSpeed.get(j).set(random(-5, 5), random(-5, -2.5));
          } else if (randomSpawn==4) {
            objPosition.get(j).set(25, random(25, 375));
            objSpeed.get(j).set(random(2.5, 5), random(-5, 5));
          }

          newX[j] = objPosition.get(j).x;
          newY[j] = objPosition.get(j).y;
          println("obj x: " + objPosition.get(j).x + "\n" + "obj y: " + objPosition.get(j).y); // Debugging to make sure obstacles spawn correctly
        }
      }

      objOffScreen = false;
    }
  }



  // Function to update obstacles positions based on their speeds
  void objMovement() {
    for (int i = 0; i < objPosition.size(); i++) {
      newX[i] += objSpeed.get(i).x;
      newY[i] += objSpeed.get(i).y;
      objPosition.get(i).set(newX[i], newY[i]);
    }
  }

  // Function to check if all the obstacles are off-screen
  void checkOffScreen() {
    if (objPosition.get(0).x > 400 || objPosition.get(0).x < 0 || objPosition.get(0).y > 400 || objPosition.get(0).y < 0) {
      if (objPosition.get(1).x > 400 || objPosition.get(1).x < 0 || objPosition.get(1).y > 400 || objPosition.get(1).y < 0) {
        if (objPosition.get(2).x > 400 || objPosition.get(2).x < 0 || objPosition.get(2).y > 400 || objPosition.get(2).y < 0) {
          if (objPosition.get(3).x > 400 || objPosition.get(3).x < 0 || objPosition.get(3).y > 400 || objPosition.get(3).y < 0) {
            if (objPosition.get(4).x > 400 || objPosition.get(4).x < 0 || objPosition.get(4).y > 400 || objPosition.get(4).y < 0) {
              // Set boolean to true causing new obstacles to spawn if all previous are off-screen
              objOffScreen = true;
            }
          }
        }
      }
    }
  }

  // Function to draw the obstacles on the canvas
  void drawObj() {
    strokeWeight(1);
    stroke(0);
    fill(200, 0, 0);
    ellipse(objPosition.get(0).x, objPosition.get(0).y, 40, 40);
    ellipse(objPosition.get(1).x, objPosition.get(1).y, 40, 40);
    ellipse(objPosition.get(2).x, objPosition.get(2).y, 40, 40);
    ellipse(objPosition.get(3).x, objPosition.get(3).y, 40, 40);
    ellipse(objPosition.get(4).x, objPosition.get(4).y, 40, 40);
  }
}
