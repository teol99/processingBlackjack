void drawUI() {
  pushStyle();
  stroke(4);
  textAlign(CENTER, CENTER);
  drawHit();
  drawStand();
  drawDouble();
  drawSplit();
  popStyle();
}

void drawHit() {
  if (buttonStates.get(buttonStateIndex) == "hit") {
    pushStyle();
    noStroke();
    fill(255);
    circle(uiWidth, uiHeight, buttonSize+10);
    popStyle();
  }
  stroke(4);
  fill(20,200,0);
  circle(uiWidth, uiHeight, buttonSize);
  fill(0);
  text("Hit", uiWidth, uiHeight - 4);
}

void drawStand() {
  if (buttonStates.get(buttonStateIndex) == "stand") {
    pushStyle();
    noStroke();
    fill(255);
    circle(uiWidth + buttonSpacing, uiHeight, buttonSize+10);
    popStyle();
  }
  fill(200,20,40);
  circle(uiWidth + buttonSpacing, uiHeight, buttonSize);
  fill(0);
  text("Std", uiWidth + buttonSpacing, uiHeight - 4);
}

void drawDouble() {
  if (buttonStates.get(buttonStateIndex) == "double") {
    pushStyle();
    noStroke();
    fill(255);
    circle(uiWidth + buttonSpacing * 2, uiHeight, buttonSize+10);
    popStyle();
  }
  fill(170,200,0);
  circle(uiWidth + buttonSpacing * 2, uiHeight, buttonSize);
  fill(0);
  text("Dbl", uiWidth + buttonSpacing * 2, uiHeight - 4);
}

void drawSplit() {
  if (buttonStates.get(buttonStateIndex) == "split") {
    pushStyle();
    noStroke();
    fill(255);
    circle(uiWidth + buttonSpacing * 3, uiHeight, buttonSize+10);
    popStyle();
  }
  fill(200,0,140);
  circle(uiWidth + buttonSpacing * 3, uiHeight, buttonSize);
  fill(0);
  text("Splt", uiWidth + buttonSpacing * 3, uiHeight - 4);
}
