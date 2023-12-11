// Public class responsible for managing player and game mechanics
public class player {
  // Player variables
  PVector position;
  float speed;
  float playerR, playerG, playerB, outline;
  boolean colorUnlock[], shapeUnlock[], timerActive;
  int score, startTime;
  float tokenDistance;
  int elapsedTime, seconds, tokenScore;

  // Constructor to initialize player properties
  player(boolean initialize) {
    if (initialize) {
      // Initializing player properties
      this.position = new PVector(width/2, width/2);
      this.speed = 3;
      this.playerR = 255;
      this.playerG = 255;
      this.playerB = 255;
      this.outline = 0;
      this.colorUnlock = new boolean[4];
      this.shapeUnlock = new boolean[3];
      this.colorUnlock[0] = true;
      this.shapeUnlock[0] = true;
      this.score = 0;
      // Setting unlock flags to false initially (except first unlock)
      for (int i = 1; i < colorUnlock.length; i++) {
        this.colorUnlock[i] = false;
      }
      for (int i = 1; i < shapeUnlock.length; i++) {
        this.shapeUnlock[i] = false;
      }
    }
  }

  // Function to draw the player on the canvas
  void drawPlayer() {
    colorPick(colorNum);
    strokeWeight(1);
    stroke(outline);
    fill(playerR, playerG, playerB);
    
    // Changes player shape depending on variable
    switch(shapeNum) {
    case 0:
      rect(position.x, position.y, 10, 10);
      break;
    case 1:
      ellipse(position.x, position.y, 10, 10);
      break;
    case 2:
      triangle(position.x, position.y-7.5, position.x+7.5, position.y+7.5, position.x-7.5, position.y+7.5);
      break;
    }
  }

  // Function to handle player movement based on key inputs
  void playerMove() {
    if (wKey) {
      position.y = constrain(position.y - speed, 5, 395);
    }
    if (sKey) {
      position.y = constrain(position.y + speed, 5, 395);
    }
    if (aKey) {
      position.x = constrain(position.x - speed, 5, 395);
    }
    if (dKey) {
      position.x = constrain(position.x + speed, 5, 395);
    }
  }

  // Function to handle and run player-related operations during gameplay
  void runPlayer() {
    playerMove();
    drawPlayer();
    playerToken(position, Object.tokenPosition);
    drawDistance(position, Object.tokenPosition, tokenDistance);
    timerPoints();
    playerCollision(position, Object.objPosition);
    // Displays player score
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text("Score: " + score, 5, 20);
  }

  // Function to check for player collisions with obstacles
  void playerCollision(PVector player, ArrayList<PVector> objects) {
    // Loop to check for collisions with each obstacle
    for (int i = 0; i < objects.size(); i++) {
      if ((player.x <= (objects.get(i).x + 20)) && (player.x >= (objects.get(i).x - 20))) {
        if ((player.y <= (objects.get(i).y + 20)) && (player.y >= (objects.get(i).y - 20))) {
          // Ends game if player touches obstacle
          timerActive = false;
          gameScore = score;
          if (gameScore > highScore) {
            highScore = gameScore;
          }
          playOn = false;
          eliminated = true;
          reset();
        }
      }
    }
  }

  // Function to check for collecting the token
  void playerToken(PVector player, PVector token) {
    if ((player.x <= (token.x + 10)) && (player.x >= (token.x - 10))) {
      if ((player.y <= (token.y + 10)) && (player.y >= (token.y - 10))) {
        // Increases score if player collects token and causes new one to spawn
        Object.tokenCollected = true;
        tokenScore += 5;
        tokensCollected += 1;
      }
    }
  }

  // Function to draw the distance line between player and token
  void drawDistance(PVector player, PVector token, float distance) {
    distance = player.dist(token);
    strokeWeight(2);
    stroke(0, 200, 0);
    line(player.x, player.y, token.x, token.y);
    noStroke();

    // Display distance from token in text
    fill(255);
    textSize(12);
    textAlign(RIGHT);
    text("Distance to token: " + (int)distance + "m", 395, 20);
    textAlign(CENTER);
  }

  // Function to update player score and timer
  void timerPoints() {
    if (!eliminated) {
      if (!timerActive) {
        // Starts timer for new game
        startTime = millis();
        timerActive = true;
      }
      // Updates score every second alive with 1 point
      elapsedTime = millis() - startTime;
      seconds = (int)(elapsedTime / 1000.0);
      score = seconds + tokenScore;
    }
  }

  // Function to set player color based on button pressed
  void colorPick(int n) {
    if (n==0) {
      playerR = 255;
      playerG = 255;
      playerB = 255;
      outline = 0;
    } else if (n==1) {
      playerR = 0;
      playerG = 255;
      playerB = 0;
      outline = 0;
    } else if (n==2) {
      playerR = 0;
      playerG = 0;
      playerB = 255;
      outline = 0;
    } else if (n==3) {
      playerR = 0;
      playerG = 0;
      playerB = 0;
      outline = 255;
    }
  }
}
