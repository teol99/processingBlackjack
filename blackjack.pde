color backgroundColor;
float margin;
float myHandHeight, myHandWidth, dealerHandHeight, dealerHandWidth;
float cardHeight, cardWidth;
float valWidth, valHeight, valRadius;
float uiWidth, uiHeight, buttonSpacing, buttonSize;
StringList deck;
int deckCount;
int delay;
Hand myHand, dealerHand;
HashMap<String,Boolean> buttons;

//Game states: playerActive, playerBust, dealerActive, dealerDone, betting
//Button states: hit, stand, double, split
String gameState, buttonState;
int buttonStateIndex;
StringList buttonStates = new StringList();
String outcomeState = "";

void setup() {
  backgroundColor = color(40,170,0);
  noStroke();
  size(960, 720);
  background(backgroundColor);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //Constants
  margin = 29;
  myHandWidth = width/2;
  myHandHeight = height/4 * 3;
  dealerHandWidth = width/2;
  dealerHandHeight = height/4 * 1;
  cardWidth = 150;
  cardHeight = 215;
  valWidth = 70;
  valHeight = 50;
  valRadius = 8;
  uiWidth = width / 12;
  uiHeight = height / 7 * 6;
  buttonSpacing = width / 12;
  buttonSize = width / 15;
  deckCount = 4;
  delay = 800;
  
  gameState = "playerActive";
  buttonStates.append("hit");
  buttonStates.append("stand");
  buttonStates.append("double");
  buttonStates.append("split");
  buttonStateIndex = 0;
  buttonState = buttonStates.get(buttonStateIndex);
  
  
  //deck initialization
  deck = new StringList();
  for (int i = 0; i < deckCount; i++) {
    addDeck();
  }
  
  //begin first round
  newRound();
  
  //UI initialization
  buttons = new HashMap<String,Boolean>();
  buttons.put("hit", true);
  buttons.put("stand", true);
  buttons.put("double", true);
  buttons.put("split", false);
  
  loop();
}

void draw() {
  background(backgroundColor);
  
  //draw my hand and its value
  myHand.drawHand();
  myHand.drawValue();
  
  //draw dealer hand
  dealerHand.drawHand();
  dealerHand.drawValue();
  
  if (gameState == "dealerActive") {
    int dealerValue = dealerHand.getValue();
    int myValue = myHand.getValue();
    if (dealerValue < 17) {
      dealerHand.addCard(deck.get(0));
      deck.remove(0);
    } else {
      if (dealerValue > 21 || dealerValue < myValue) {
        outcomeState = "WIN";
      } else if (dealerValue == myValue) {
        outcomeState = "PUSH";
      } else {
        outcomeState = "LOSE";
      }
      gameState = "dealerDone";
    }
    delay(delay);
  }
  
  //Draw UI
  drawUI();
  
  //Draw outcome if round is finished
  drawOutcome();
}

void keyPressed() {
  if (key == ' ') {
    switch (gameState) {
      case "playerActive":
        switch (buttonStates.get(buttonStateIndex)) {
          case "hit":
            myHand.addCard(deck.get(0));
            deck.remove(0);
            if (myHand.busted) {
              outcomeState = "LOSE";
              gameState = "playerBust";
            }
            break;
           case "stand":
             gameState = "dealerActive";
             dealerHand.hidden = false;
             break;
           case "double":
             // TODO
             break;
           case "split":
             // TODO
             break;
        }
        
        break;
      case "playerBust":
        background(backgroundColor);
        newRound();
        outcomeState = "";
        gameState = "playerActive";
        break;
      case "dealerActive":
        dealerHand.addCard(deck.get(0));
        deck.remove(0);
        break;
      case "dealerDone":
        newRound();
        gameState = "playerActive";
        outcomeState = "";
        buttonStateIndex = 0;
        break;
    }
  }
  if (keyCode == LEFT || key == 'a') {
    buttonStateIndex += 3;
    while (!buttons.get(buttonStates.get(buttonStateIndex % 4))) {
      buttonStateIndex--;
    }
  } else if (keyCode == RIGHT || key == 'd') {
    buttonStateIndex++;
    while (!buttons.get(buttonStates.get(buttonStateIndex % 4))) {
      buttonStateIndex++;
    }
  }
  buttonStateIndex = buttonStateIndex % 4;
}

void drawOutcome() {
  pushStyle();
  textSize(45);
  fill(0);
  textAlign(CENTER, CENTER);
  text(outcomeState, width/2, height/2 - 37);
  textSize(25);
  if (outcomeState != "") {
    text("Press space to play again", width/2, height/2);
  }
  popStyle();
}

void newRound() {
  //deal my hand
  myHand = new Hand(myHandWidth, myHandHeight, margin, false);
  
  //deal dealer hand
  dealerHand = new Hand(dealerHandWidth, dealerHandHeight, margin, true);
}

// Generate a new deck and shuffle it
void addDeck() {
  for (int rank = 0; rank < 13; rank++) {
    for (int suit = 0; suit < 4; suit++) {
      String card = "";
      if (rank == 1 || rank > 9) {
        switch(rank) {
          case 10:
            card += 'J';
            break;
          case 11:
            card += 'Q';
            break;
          case 12:
            card += 'K';
            break;
          case 1:
            card += 'A';
            break;
        }
      } else {
        card += rank;
      }
      switch(suit) {
        case 0:
          card += 'S';
          break;
        case 1:
          card += 'H';
          break;
        case 2:
          card += 'C';
          break;
        case 3:
          card += 'D';
          break;
      }
      deck.append(card);
    }
  }
  deck.shuffle();
}
