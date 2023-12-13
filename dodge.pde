// Global variables for player and object, game states, and input flags
player Player;
object Object;
boolean menuOn = true, playOn = false, eliminated = false, customOn = false;
boolean wKey = false, sKey = false, aKey = false, dKey = false;
int colorNum = 0;
int shapeNum = 0;
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
  background((10 * sin(frameCount / 10) + 20), 0, 50);

  // Different game screens/states
  menu(menuOn);
  play(playOn);
  gameOver(eliminated);
  customMenu(customOn);
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
    // White background spikes
    fill(255);
    triangle(-50, 0, 20, 0, 0, 100);
    triangle(-20, 0, 60, 0, 30, 80);
    triangle(40, 0, 110, 0, 70, 65);
    triangle(75, 0, 155, 0, 110, 50);
    triangle(120, 0, 190, 0, 155, 65);
    triangle(160, 0, 230, 0, 195, 55);
    triangle(190, 0, 280, 0, 240, 60);
    triangle(230, 0, 335, 0, 285, 70);
    triangle(270, 0, 360, 0, 320, 60);
    triangle(310, 0, 390, 0, 360, 75);
    triangle(350, 0, 430, 0, 400, 90);
    
    // Title
    textAlign(CENTER);
    textSize(25);
    fill(255);
    text("Dodge", 200, 10 * sin(frameCount/2.5) + 120);

    // Play button
    textSize(15);
    fill(0, 60, 60);
    strokeWeight(2);
    stroke(255);
    rect(175, 175, 100, 30);
    fill(255);
    text("Play", 175, 180);
    // Play icon
    triangle(240, 180, 240, 170, 250, 175);
    fill(0, 0);
    rect(245, 175, 20, 20);

    // Customize button
    fill(0, 60, 60);
    rect(225, 225, 100, 30);
    fill(255);
    text("Customize", 225, 230);
    // Customize Icon
    fill(0, 0);
    ellipse(155, 225, 20, 20);
    fill(255);
    ellipse(155, 225, 10, 10);

    // Exit button
    fill(0, 60, 60);
    rect(175, 275, 100, 30);
    fill(255);
    text("Exit", 175, 280);
    // Exit icon
    fill(0, 0);
    rect(245, 275, 15, 20);
    fill(255);
    triangle(245, 275, 255, 270, 255, 280);
    rect(255, 275, 10, 2.5);
    
    
  }
}

// Function to handle mouse clicks in the menu
void menuClick(boolean n) {
  if (n) {
    // Play button click
    if (mouseX >= 125 && mouseX <= 225) {
      if (mouseY >= 160 && mouseY <= 190) {
        fill(255);
        rect(175, 175, 100, 25);
        menuOn = false;
        playOn = true;
        println("Play button clicked"); // Debugging to make sure button works properly
      }
    }
    // Colors button click
    if (mouseX >= 175 && mouseX <= 275) {
      if (mouseY >= 210 && mouseY <= 240) {
        fill(255);
        rect(225, 225, 100, 30);
        menuOn = false;
        customOn = true;
        println("Custom button clicked"); // Debugging to make sure button works properly
      }
    }
    // Exit button click
    if (mouseX >= 125 && mouseX <= 225) {
      if (mouseY >= 260 && mouseY <= 290) {
        fill(255);
        rect(175, 275, 100, 30);
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
    fill(0, 30, 30);
    strokeWeight(2);
    stroke(255);
    rect(130, 200, 200, 150);
    fill(0, 60, 60);
    rect(130, 125, 100, 25);
    fill(255);
    text("Game Over", 130, 130);
    textSize(15);
    text("High Score: " + highScore, 130, 160);
    text("Score: " + gameScore, 130, 180);
    text("Tokens collected: " + tokensCollected, 130, 200);
    text("Time survived: " + Player.seconds, 130, 220);
    fill(0, 60, 60);
    rect(80, 250, 75, 25);
    rect(180, 250, 75, 25);
    fill(255);
    text("Replay", 80, 255);
    text("Menu", 180, 255);

    // Color unlocks tab
    textSize(20);
    fill(0, 30, 30);
    strokeWeight(2);
    stroke(255);
    rect(310, 200, 130, 150);
    fill(0, 60, 60);
    rect(310, 125, 100, 25);
    fill(255);
    text("Unlocks", 310, 130);
    textSize(15);

    // Conditional statements to decide whether colors are locked or unlocked depending on highest score
    if (highScore > 25) {
      Player.colorUnlock[1] = true;
      fill(0, 200, 0);
      text("Color 1: Unlocked", 310, 160);
    } else {
      fill(200, 0, 0);
      text("Color 1: Locked", 310, 160);
    }
    if (highScore > 50) {
      Player.colorUnlock[2] = true;
      fill(0, 200, 0);
      text("Color 2: Unlocked", 310, 180);
    } else {
      fill(200, 0, 0);
      text("Color 2: Locked", 310, 180);
    }
    if (highScore > 100) {
      Player.colorUnlock[3] = true;
      fill(0, 200, 0);
      text("Color 3: Unlocked", 310, 200);
    } else {
      fill(200, 0, 0);
      text("Color 3: Locked", 310, 200);
    }
    if (highScore > 35) {
      Player.shapeUnlock[1] = true;
      fill(0, 200, 0);
      text("Shape 1: Unlocked", 310, 220);
    } else {
      fill(200, 0, 0);
      text("Shape 1: Locked", 310, 220);
    }
    if (highScore > 75) {
      Player.shapeUnlock[2] = true;
      fill(0, 200, 0);
      text("Shape 2: Unlocked", 310, 240);
    } else {
      fill(200, 0, 0);
      text("Shape 2: Locked", 310, 240);
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
void customMenu(boolean n) {
  if (n) {
    // Section Heading
    textAlign(LEFT);
    textSize(20);
    text("COLORS", 10, 50);
    
    textAlign(CENTER);
    textSize(15);
    // Unlock box of first color
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(50, 100, 75, 75);
    fill(255);
    strokeWeight(2);
    stroke(0);
    rect(50, 100, 25, 25);

    // Unlock box of second color
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(150, 100, 75, 75);
    fill(0, 255, 0);
    strokeWeight(2);
    stroke(0);
    rect(150, 100, 25, 25);

    // Unlock box of third color
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(250, 100, 75, 75);
    fill(0, 0, 255);
    strokeWeight(2);
    stroke(0);
    rect(250, 100, 25, 25);

    // Unlock box of fourth color
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(350, 100, 75, 75);
    fill(0);
    strokeWeight(2);
    stroke(255);
    rect(350, 100, 25, 25);
    
    // Section Heading
    fill(255);
    textAlign(LEFT);
    textSize(20);
    text("SHAPES", 60, 200);
    
    textAlign(CENTER);
    textSize(15);
    // Unlock box of first shape
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(100, 250, 75, 75);
    fill(255);
    strokeWeight(2);
    stroke(0);
    rect(100, 250, 25, 25);
    
    // Unlock box of second shape
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(200, 250, 75, 75);
    fill(255);
    strokeWeight(2);
    stroke(0);
    ellipse(200, 250, 25, 25);
    
    // Unlock box of third shape
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(300, 250, 75, 75);
    fill(255);
    strokeWeight(2);
    stroke(0);
    triangle(300, 240, 310, 260, 290, 260);

    // Back button
    textSize(25);
    fill(0, 60, 60);
    strokeWeight(3);
    stroke(255);
    rect(200, 350, 100, 50);
    fill(255);
    text("Back", 200, 360);

    // Conditional statements to check if a color is locked and hide it with a requirement display
    textSize(12);
    if (!Player.colorUnlock[1]) {
      fill(0, 175);
      strokeWeight(3);
      stroke(255);
      rect(150, 100, 75, 75);
      fill(255);
      text("Score > 25", 150, 105);
    }
    if (!Player.colorUnlock[2]) {
      fill(0, 175);
      strokeWeight(3);
      stroke(255);
      rect(250, 100, 75, 75);
      fill(255);
      text("Score > 50", 250, 105);
    }
    if (!Player.colorUnlock[3]) {
      fill(0, 175);
      strokeWeight(3);
      stroke(255);
      rect(350, 100, 75, 75);
      fill(255);
      text("Score > 100", 350, 105);
    }
    textSize(12);
    if (!Player.shapeUnlock[1]) {
      fill(0, 175);
      strokeWeight(3);
      stroke(255);
      rect(200, 250, 75, 75);
      fill(255);
      text("Score > 35", 200, 255);
    }
    if (!Player.shapeUnlock[2]) {
      fill(0, 175);
      strokeWeight(3);
      stroke(255);
      rect(300, 250, 75, 75);
      fill(255);
      text("Score > 75", 300, 255);
    }
  }
}

// Function to handle mouse clicks in the color selection menu
void customMenuClick(boolean n) {
  if (n) {
    // Back button click
    if (mouseX >= 150 && mouseX <= 250) {
      if (mouseY >= 325 && mouseY <= 375) {
        customOn = false;
        menuOn = true;
      }
    }
    // Color selection 1 click
    if (Player.colorUnlock[0]) {
      if (mouseX >= 12.5 && mouseX <= 87.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 0;
          customOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 2 click
    if (Player.colorUnlock[1]) {
      if (mouseX >= 112.5 && mouseX <= 187.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 1;
          customOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 3 click
    if (Player.colorUnlock[2]) {
      if (mouseX >= 212.5 && mouseX <= 287.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 2;
          customOn = false;
          menuOn = true;
        }
      }
    }
    // Color selection 4 click
    if (Player.colorUnlock[3]) {
      if (mouseX >= 312.5 && mouseX <= 387.5) {
        if (mouseY >= 62.5 && mouseY <= 137.5) {
          colorNum = 3;
          customOn = false;
          menuOn = true;
        }
      }
    }
    // Shape selection 1 click
    if (Player.shapeUnlock[0]) {
      if (mouseX >= 62.5 && mouseX <= 137.5) {
        if (mouseY >= 212.5 && mouseY <= 287.5) {
          shapeNum = 0;
          customOn = false;
          menuOn = true;
        }
      }
    }
    // Shape selection 2 click
    if (Player.shapeUnlock[1]) {
      if (mouseX >= 162.5 && mouseX <= 237.5) {
        if (mouseY >= 212.5 && mouseY <= 287.5) {
          shapeNum = 1;
          customOn = false;
          menuOn = true;
        }
      }
    }
    // Shape selection 3 click
    if (Player.shapeUnlock[2]) {
      if (mouseX >= 262.5 && mouseX <= 337.5) {
        if (mouseY >= 212.5 && mouseY <= 287.5) {
          shapeNum = 2;
          customOn = false;
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
  customMenuClick(customOn);
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
