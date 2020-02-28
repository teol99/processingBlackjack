class Hand {
  StringList cards;
  float x, y;
  float margin;
  int value;
  boolean hasAce = false;
  boolean busted = false;
  boolean hidden = false;
  
  Hand(float w, float h, float m, boolean isDealer) {
    cards = new StringList();
    x = w;
    y = h;
    margin = m;
    hasAce = false;
    busted = false;
    hidden = isDealer;
    
    //Get two new cards
    addCard(deck.get(0));
    deck.remove(0);
    addCard(deck.get(0));
    deck.remove(0);
  }
  
  //Add a card to the deck and update the hand value
  void addCard(String card) {
    cards.append(card);
    char rank = card.charAt(0);
    if (rank == '0' || rank == 'J' || rank == 'Q' || rank == 'K') {
      value += 10;
    } else if (rank == 'A') {
      hasAce = true;
      value += 1;
    } else {
      value += int(rank) - '0';
    }
    if (value > 21) {
      busted = true;
    }
  }
  
  //Draw the hand on screen
  void drawHand() {
    int yMarg = 0;
    float xBuff = 0;
    for (int i = 0; i < cards.size(); i++) {
      String myCard = cards.get(i);
      if (i == 1 && hidden == true) {
        myCard = "F";
      }
      PImage cardImg = loadImage("images/" + myCard + ".png");
      if (i > 7) {
        yMarg = 110;
        xBuff = 7;
      } else if (i > 3) {
        yMarg = 55;
        xBuff = 3.5;
      } 
      
      image(cardImg, x + margin * (i - xBuff), y + yMarg, cardWidth, cardHeight);
    }
  }
  
  int getValue() {
    return hasAce && value <= 11 ? value + 10 : value;
  }
  
  //Draw the hand value above the cards
  void drawValue() {
    pushStyle();
    fill(40,170,0);
    rect(x, y - cardHeight/3*2, valWidth, valHeight, valRadius, valRadius, valRadius, valRadius);
    popStyle();
    
    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(25);
    if (!hidden) {
      text(getValue(), x, y - cardHeight/3*2);
    }
    popStyle();
  }
}
