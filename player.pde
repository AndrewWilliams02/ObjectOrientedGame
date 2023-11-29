public class player {
  PVector position;
  float speed;
  float playerR, playerG, playerB, outline;
  boolean unlock[];

  player() {
    this.position = new PVector(width/2, width/2);
    this.speed = 5;
    this.playerR = 255;
    this.playerG = 255;
    this.playerB = 255;
    this.outline = 0;
    this.unlock = new boolean[5];
    this.unlock[0] = true;
    for(int i = 1; i < unlock.length; i++){
      this.unlock[i] = false;
    }
  }

  void drawPlayer() {
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
  }
  
  void colorPick(int n) {
    if(n == 0){
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
