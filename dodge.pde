boolean menuOn = true, playOn = false, gameOverOn = false, colorsOn = false;

void setup() {
  size(400, 400);
  frameRate(60);
  textAlign(CENTER);
  rectMode(CENTER);
}

void draw() {
  background(0, 50, 50);

  menu(menuOn);
}

void menu(boolean n) {
  if (n) {
    textSize(25);
    fill(255);
    text("Dodge", width/2, 130);
    
    textSize(15);
    fill(100);
    strokeWeight(2);
    stroke(255);
    rect(width/2, 175, 100, 30);
    fill(255);
    text("Play", width/2, 180);
    fill(100);
    rect(width/2, 225, 100, 30);
    fill(255);
    text("Colors", width/2, 230);
    fill(100);
    rect(width/2, 275, 100, 30);
    fill(255);
    text("Exit", width/2, 280);
  }
}

void mousePressed() {
  if (mouseX >= 150 && mouseX <= 250) {
    if (mouseY >= 160 && mouseY <= 190) {
      fill(255);
      rect(width/2, 175, 100, 25);
      playOn = true;
      println("Play button clicked");
    }
  }
  if (mouseX >= 150 && mouseX <= 250) {
    if (mouseY >= 210 && mouseY <= 240) {
      fill(255);
      rect(width/2, 225, 100, 30);
      colorsOn = true;
      println("Colors button clicked");
    }
  }
  if (mouseX >= 150 && mouseX <= 250) {
    if (mouseY >= 260 && mouseY <= 290) {
      fill(255);
      rect(width/2, 275, 100, 30);
      println("Exit button clicked");
    }
  }
}
