// Global variables for player and object, game states, and input flags
player Player;
object Object;
boolean menuOn = true, playOn = false, eliminated = false, colorsOn = false;
boolean wKey = false, sKey = false, aKey = false, dKey = false;
int colorNum = 0;
int gameScore, tokensCollected, highScore;

// Setup for the drawing
void setup() {
  size(400, 400);
  frameRate(60);
  textAlign(CENTER);
  rectMode(CENTER);
  Player = new player(menuOn);
  Object = new object(menuOn);
}


void draw() {
  background(0, 50, 50);

  // Different game screens/states
  menu(menuOn);
  play(playOn);
  gameOver(eliminated);
  colorMenu(colorsOn);
}

// Function to reset game stats
void reset() {
  Object.tokenCollected = true;
  Object.objOffScreen = true;
  Player.score = 0;
  Player.position.x = width/2;
  Player.position.y = height/2;
  Player.tokenScore = 0;
}

// Function to display the main menu
void menu(boolean n) {
  if (n) {
    // Title
    textAlign(CENTER);
    textSize(25);
    fill(255);
    text("Dodge", width/2, 130);

    // Play button
    textSize(15);
    fill(100);
    strokeWeight(2);
    stroke(255);
    rect(width/2, 175, 100, 30);
    fill(255);
    text("Play", width/2, 180);

    // Colors button
    fill(100);
    rect(width/2, 225, 100, 30);
    fill(255);
    text("Colors", width/2, 230);

    // Exit button
    fill(100);
    rect(width/2, 275, 100, 30);
    fill(255);
    text("Exit", width/2, 280);
  }
}

// Function to handle mouse clicks in the menu
void menuClick(boolean n) {
  if (n) {
    // Play button click
    if (mouseX >= 150 && mouseX <= 250) {
      if (mouseY >= 160 && mouseY <= 190) {
        fill(255);
        rect(width/2, 175, 100, 25);
        menuOn = false;
        playOn = true;
        println("Play button clicked"); // Debugging to make sure button works properly
      }
    }
    // Colors button click
    if (mouseX >= 150 && mouseX <= 250) {
      if (mouseY >= 210 && mouseY <= 240) {
        fill(255);
        rect(width/2, 225, 100, 30);
        menuOn = false;
        colorsOn = true;
        println("Colors button clicked"); // Debugging to make sure button works properly
      }
    }
    // Exit button click
    if (mouseX >= 150 && mouseX <= 250) {
      if (mouseY >= 260 && mouseY <= 290) {
        fill(255);
        rect(width/2, 275, 100, 30);
        println("Exit button clicked"); // Debugging to make sure button works properly
        exit();
      }
    }
  }
}

// Function to display game over screen
void gameOver(boolean n) {
  if (n) {
    // Previous game stats and highscore tab
    textAlign(CENTER);
    textSize(20);
    fill(50);
    strokeWeight(2);
    stroke(255);
    rect(130, 200, 200, 150);
    fill(100);
    rect(130, 125, 100, 25);
    fill(255);
    text("Game Over", 130, 130);
    textSize(15);
    text("High Score: " + highScore, 130, 160);
    text("Score: " + gameScore, 130, 180);
    text("Tokens collected: " + tokensCollected, 130, 200);
    text("Time survived: " + Player.seconds, 130, 220);
    fill(100);
    rect(80, 250, 75, 25);
    rect(180, 250, 75, 25);
    fill(255);
    text("Replay", 80, 255);
    text("Menu", 180, 255);

    // Color unlocks tab
    textSize(20);
    fill(50);
    strokeWeight(2);
    stroke(255);
    rect(310, 200, 130, 150);
    fill(100);
    rect(310, 125, 100, 25);
    fill(255);
    text("Unlocks", 310, 130);
    textSize(15);

    // Conditional statements to decide whether colors are locked or unlocked depending on highest score
    if (highScore > 25) {
      Player.unlock[1] = true;
      fill(0, 200, 0);
      text("Color 1: Unlocked", 310, 160);
    } else {
      fill(200, 0, 0);
      text("Color 1: Locked", 310, 160);
    }
    if (highScore > 50) {
      Player.unlock[2] = true;
      fill(0, 200, 0);
      text("Color 2: Unlocked", 310, 180);
    } else {
      fill(200, 0, 0);
      text("Color 2: Locked", 310, 180);
    }
    if (highScore > 100) {
      Player.unlock[3] = true;
      fill(0, 200, 0);
      text("Color 3: Unlocked", 310, 200);
    } else {
      fill(200, 0, 0);
      text("Color 3: Locked", 310, 200);
    }
    if (highScore > 200) {
      Player.unlock[4] = true;
      fill(0, 200, 0);
      text("Color 4: Unlocked", 310, 220);
    } else {
      fill(200, 0, 0);
      text("Color 4: Locked", 310, 220);
    }
  }
}

// Function to handle mouse clicks in the game over screen
void gameOverClick(boolean n) {
  if (n) {
    // Replay button click
    if (mouseX >= 42.5 && mouseX <= 117.5) {
      if (mouseY >= 237.5 && mouseY <= 262.5) {
        fill(255);
        rect(80, 250, 75, 25);
        eliminated = false;
        playOn = true;
        println("Replay button clicked"); // Debugging to make sure button works properly
      }
    }
    // Menu button click
    if (mouseX >= 142.5 && mouseX <= 217.5) {
      if (mouseY >= 237.5 && mouseY <= 262.5) {
        fill(255);
        rect(180, 250, 75, 25);
        eliminated = false;
        menuOn = true;
        println("Menu button clicked"); // Debugging to make sure button works properly
      }
    }
  }
}

// Function to display color selection menu
void colorMenu(boolean n) {
  if (n) {
    // Unlock box of first color
    textAlign(CENTER);
    textSize(15);
    fill(100);
    strokeWeight(3);
    stroke(255);
    rect(100, 100, 75, 75);
    fill(255);
    strokeWeight(2);
    stroke(0);
    rect(100, 100, 25, 25);

    // Unlock box of second color
    fill(100);
    strokeWeight(3);
    stroke(255);
    rect(200, 100, 75, 75);
    fill(0, 255, 0);
    strokeWeight(2);
    stroke(0);
    rect(200, 100, 25, 25);

    // Unlock box of third color
    fill(100);
    strokeWeight(3);
    stroke(255);
    rect(300, 100, 75, 75);
    fill(0, 0, 255);
    strokeWeight(2);
    stroke(0);
    rect(300, 100, 25, 25);

    // Unlock box of fourth color
    fill(100);
    strokeWeight(3);
    stroke(255);
    rect(150, 200, 75, 75);
    fill(255, 0, 0);
    strokeWeight(2);
    stroke(0);
    rect(150, 200, 25, 25);

    // Unlock box of fifth color
    fill(100);
    strokeWeight(3);
    stroke(255);
    rect(250, 200, 75, 75);
    fill(0);
    strokeWeight(2);
    stroke(255);
    rect(250, 200, 25, 25);

    // Back button
    textSize(25);
    fill(100);
    strokeWeight(3);
    stroke(255);
    rect(200, 350, 100, 50);
    fill(255);
    text("Back", 200, 360);

    // Conditional statements to check if a color is locked and hide it with a requirement display
    textSize(12);
    if (!Player.unlock[1]) {
      fill(0);
      strokeWeight(3);
      stroke(255);
      rect(200, 100, 75, 75);
      fill(255);
      text("Score > 25", 200, 105);
    }
    if (!Player.unlock[2]) {
      fill(0);
      strokeWeight(3);
      stroke(255);
      rect(300, 100, 75, 75);
      fill(255);
      text("Score > 50", 300, 105);
    }
    if (!Player.unlock[3]) {
      fill(0);
      strokeWeight(3);
      stroke(255);
      rect(150, 200, 75, 75);
      fill(255);
      text("Score > 100", 150, 205);
    }
    if (!Player.unlock[4]) {
      fill(0);
      strokeWeight(3);
      stroke(255);
      rect(250, 200, 75, 75);
      fill(255);
      text("Score > 200", 250, 205);
    }
  }
}

// Function to handle mouse clicks in the color selection menu
void colorMenuClick(boolean n) {
  if (n) {
    // Back button click
    if (mouseX >= 150 && mouseX <= 250) {
      if (mouseY >= 325 && mouseY <= 375) {
        colorsOn = false;
        menuOn = true;
      }
    }
    // Color selection 1 click
    if (Player.unlock[0]) {
      if (mouseX >= 62.5 && mouseX <= 137.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 0;
          colorsOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 2 click
    if (Player.unlock[1]) {
      if (mouseX >= 162.5 && mouseX <= 237.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 1;
          colorsOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 3 click
    if (Player.unlock[2]) {
      if (mouseX >= 262.5 && mouseX <= 337.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 2;
          colorsOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 4 click
    if (Player.unlock[3]) {
      if (mouseX >= 112.5 && mouseX <= 187.5) {
        if (mouseY >= 162.5 && mouseY <= 237.5) {
          colorNum = 3;
          colorsOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 5 click
    if (Player.unlock[4]) {
      if (mouseX >= 212.5 && mouseX <= 287.5) {
        if (mouseY >= 162.5 && mouseY <= 237.5) {
          colorNum = 4;
          colorsOn = false;
          menuOn = true;
        }
      }
    }
  }
}

// Function to handle gameplay logic
void play(boolean n) {
  if (n) {
    textAlign(CENTER);
    rectMode(CENTER);
    // Runs all player functions
    Player.runPlayer();
    // Runs all object functions
    Object.runObjects();
  }
}

// Function to handle mouse click events
void mousePressed() {
  menuClick(menuOn);
  gameOverClick(eliminated);
  colorMenuClick(colorsOn);
}

// Function to handle movement key hold events
void keyPressed() {
  if (key == 'w' || key == 'W') {
    wKey = true;
  } else if (key == 's' || key == 'S') {
    sKey = true;
  }
  if (key == 'a' || key == 'A') {
    aKey = true;
  } else if (key == 'd' || key == 'D') {
    dKey = true;
  }
}

// Function to handle movement key release events
void keyReleased() {
  if (key == 'w' || key == 'W') {
    wKey = false;
  }
  if (key == 's' || key == 'S') {
    sKey = false;
  }
  if (key == 'a' || key == 'A') {
    aKey = false;
  }
  if (key == 'd' || key == 'D') {
    dKey = false;
  }
}
