public class player {
  PVector position;
  float speed;
  float playerR, playerG, playerB, outline;
  boolean unlock[], timerActive;
  int score, startTime;
  float tokenDistance;
  int elapsedTime, seconds, tokenScore;


  player(boolean initialize) {
    if (initialize) {
      this.position = new PVector(width/2, width/2);
      this.speed = 3;
      this.playerR = 255;
      this.playerG = 255;
      this.playerB = 255;
      this.outline = 0;
      this.unlock = new boolean[5];
      this.unlock[0] = true;
      this.score = 0;
      for (int i = 1; i < unlock.length; i++) {
        this.unlock[i] = false;
      }
    }
  }

  void drawPlayer() {
    colorPick(colorNum);
    strokeWeight(1);
    stroke(outline);
    fill(playerR, playerG, playerB);
    rect(position.x, position.y, 10, 10);
  }

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

  void runPlayer() {
    playerMove();
    drawPlayer();
    playerToken(position, Object.tokenPosition);
    drawDistance(position, Object.tokenPosition, tokenDistance);
    timerPoints();
    playerCollision(position, Object.objPosition);
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text("Score: " + score, 5, 20);
  }

  void playerCollision(PVector player, ArrayList<PVector> objects) {
    for (int i = 0; i < objects.size(); i++) {
      if ((player.x <= (objects.get(i).x + 20)) && (player.x >= (objects.get(i).x - 20))) {
        if ((player.y <= (objects.get(i).y + 20)) && (player.y >= (objects.get(i).y - 20))) {
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

  void playerToken(PVector player, PVector token) {
    if ((player.x <= (token.x + 10)) && (player.x >= (token.x - 10))) {
      if ((player.y <= (token.y + 10)) && (player.y >= (token.y - 10))) {
        Object.tokenCollected = true;
        tokenScore += 5;
        tokensCollected += 1;
      }
    }
  }

  void drawDistance(PVector player, PVector token, float distance) {
    distance = player.dist(token);
    strokeWeight(2);
    stroke(0, 200, 0);
    line(player.x, player.y, token.x, token.y);
    noStroke();

    textSize(12);
    textAlign(RIGHT);
    text("Distance to token: " + (int)distance + "m", 395, 20);
    textAlign(CENTER);
  }

  void timerPoints() {
    if (!eliminated) {
      if (!timerActive) {
        startTime = millis();
        timerActive = true;
      }
      elapsedTime = millis() - startTime;
      seconds = (int)(elapsedTime / 1000.0);
      score = seconds + tokenScore;
    }
  }

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
      playerR = 255;
      playerG = 0;
      playerB = 0;
      outline = 0;
    } else if (n==4) {
      playerR = 0;
      playerG = 0;
      playerB = 0;
      outline = 255;
    }
  }
}
