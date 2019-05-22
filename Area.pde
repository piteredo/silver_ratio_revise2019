class Area {
  LogicArt logicArt;
  color colorRectColor = BG_COLOR;
  int strokeWidth = 1;
  PImage img_a_all = loadImage("img_a.jpg");
  PImage img_a_half = img_a_all.get(0, 0, 75, 105);
  PImage img_b_all = loadImage("img_b.jpg");
  PImage img_b_half = img_b_all.get(0, 0, 180, 255);
  PImage img_c_all = loadImage("img_c.png");
  PImage img_c_half = img_c_all.get(0, 0, 435, 615);
  PImage img_c_guruguru_half = loadImage("img_c_guruguru.png").get(0, 0, 435, 615);
  PImage img_d = loadImage("img_d.png");
  int gradationCount = 0;
  int gradationColorType = 0;
  boolean isFlashing = false;
  int flashAlpha = 0;
  color flashColor = color(220);
  int flashCount = 0;
  int flashTime = 5;
  int flashDecreaseSize = 6;
  
  Area() {
    logicArt = new LogicArt();
  }
  
  void drawArea() {
    int turnCount = ball.getTurnCount();
    int turnLength = data.getTurnLength(mapId);
    int wholeNoteStartMapId = data.getWholeNoteStartMapId(mapId);
    boolean wholeNoteTurn = turnCount >= wholeNoteStartMapId;
    int rectWidth = data.getRectWidth(mapId);
    int rectHeight = data.getRectHeight(mapId);
    boolean endWaitable = ball.getEndWaitable();
    int sideCount = ball.getSideCount();
    int unitCount = ball.getUnitCount();
    
    if(ball.getIsMoving()) {
      // COLOR_RECT
      switch(mapId) {
        case 0: if(turnCount >= 6 && !wholeNoteTurn) drawColorRect(rectWidth, rectHeight); break;
        case 1: if(turnCount >= 3 && !wholeNoteTurn) drawColorRect(rectWidth, rectHeight); break;
        case 2: case 3: if(turnCount >= 1 && !wholeNoteTurn) drawColorRect(rectWidth, rectHeight); break;
        case 4: if((turnCount == 0 && sideCount >= 2) || turnCount == 1) drawColorRect(rectWidth, rectHeight); break;
        case 5: if(turnCount == 0/* || (turnCount == 2 && !(sideCount==3 && unitCount>=56))*/) drawColorRect(rectWidth, rectHeight); break;
      }
      
      // GRADATION RECT
      switch(mapId) {
        case 4: if(turnCount == 2 || (turnCount == 3 && sideCount%2==1)) drawGradationRect(rectWidth, rectHeight); break;
      }
      
      // BEFORE_END_IMAGE
      switch(mapId) {
        case 1:
        case 3:
        case 5:
          if(turnLength - turnCount == 1) displayBeforeEndImage(mapId, sideCount);
          break;
      }
      
      // BG FLASH
      if(isFlashing) {
        switch(mapId) {
          case 0: case 1: case 2: case 3: /*DO NOTHING*/ break;
          //case 2: if(turnCount >= 2 && !wholeNoteTurn)  drawFlashRect(rectWidth, rectHeight); break;
          //case 3: if(((turnCount==1 && sideCount>=2) || turnCount >=2) && !wholeNoteTurn) drawFlashRect(rectWidth, rectHeight); break;
          case 4: if(((turnCount==0 && sideCount<2) || turnCount==1) && !wholeNoteTurn) drawFlashRect(rectWidth, rectHeight); break;
          case 5: if(turnCount == 0 || (turnCount == 3/* && !(sideCount==0 && unitCount<=3)*/)) drawFlashRect(rectWidth, rectHeight); break;
        }      
        flashCount++;
        flashAlpha -= flashDecreaseSize;
      }
      if(flashCount > flashTime) {
        isFlashing = false;
        flashAlpha = 0;
        flashCount = 0;
      }
      
      // LOGIC_ART
      switch(mapId) {
        case 5:
          if(turnCount != 0 && !(wholeNoteTurn && sideCount == 3)) {
            logicArt.setDrawable(true);
            logicArt.drawLogicArt();
          }
          break;
      }
      
      // BREFORE END RECT
      if(turnCount >= wholeNoteStartMapId && mapId < 4) drawBeforeEndRect(rectWidth, rectHeight, sideCount);
    }
    
    // END_IMAGE
    switch(mapId) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        if(endWaitable) displayEndImage(mapId);
        break;
    }
    
    // BORDER RECT
    drawBorderRect(rectWidth, rectHeight);
  }
  
  private void drawColorRect(int w, int h) {
    fill(colorRectColor);
    noStroke();
    rect(0, 0, w, h);
  }
  
  void setColorRectColor(color col) {
    colorRectColor = col;
  }
  
  private void drawGradationRect(int w, int h) {
    float ellipseRad = SCREEN_HEIGHT; // 768
    color colA = data.getChordColor("F#m");
    color colB = data.getChordColor("Cm");
    color gradationColorA = colA;
    color gradationColorB = colB;
    if(gradationColorType % 2 == 1) {
      gradationColorA = colB;
      gradationColorB = colA;
    }
    noStroke();
    for(float i=ellipseRad; i>0; i-=192) {
      float v = 2;
      fill(gradationColorA);
      ellipse(w/2, h/2, i + (gradationCount*v), i + (gradationCount*v));
      fill(gradationColorB);
      ellipse(w/2, h/2, i-96 + (gradationCount*v), i-96 + (gradationCount*v));
    }
    drawGradationMask(w, h);
    gradationCount++;
  }
  
  private void drawGradationMask(int w, int h) {
    int mapX = course.getMapPosX();
    int mapY = course.getMapPosY();
    fill(BG_COLOR);
    rect(-mapX, -mapY, mapX, SCREEN_HEIGHT);
    rect(w, -mapY, SCREEN_WIDTH-(mapX+w), SCREEN_HEIGHT);
    rect(-mapX, -mapY, SCREEN_WIDTH, mapY);
    rect(-mapX, h, SCREEN_WIDTH, SCREEN_HEIGHT-(mapY+h));
  }
  
  void updateGradationColor() {
    gradationCount = 0;
    changeGradationColor();
  }
  
  private void changeGradationColor() {
    gradationColorType++;
  }
  
  private void displayBeforeEndImage(int id, int sideCount) {
    switch(id){
      case 1: image(img_a_half, 0, 0); break;
      case 3: image(img_b_half, 0, 0); break;
      case 5:
        if(sideCount == 3) image(img_c_all, 0, 0);
        break;
    }
  }
  
  private void displayEndImage(int id) {
    switch(id){
      case 0: image(img_a_half, 0, 0); break;
      case 1: image(img_a_all, 0, 0); break;
      case 2: image(img_b_half, 0, 0); break;
      case 3: image(img_b_all, 0, 0); break;
      case 4: image(img_c_guruguru_half, 0, 0); image(img_c_half, 0, 0); break;
      case 5: image(img_d, 0, 0);
    }
  }
  
  void flash() {
    flashAlpha = 10;
    isFlashing = true;
  }
  
  private void drawFlashRect(int w, int h) {
    fill(flashColor, flashAlpha);
    noStroke();
    rect(0, 0, w, h);
  }
  
  private void drawBeforeEndRect(int w, int h, int sideCount) {
    switch(sideCount) {
      case 0:
      case 2:
        fill(BG_COLOR, 60);
        break;
      case 1:
      case 3:
        fill(HIGHLIGHT_COLOR, 70);
        break;
    }
    noStroke();
    rect(0, 0, w, h);
  }
  
  private void drawBorderRect(int w, int h) {
    noFill();
    stroke(BASE_COLOR);
    strokeWeight(strokeWidth);
    rect(0, 0, w, h);
  }
  
  void updateRectColor(String chordName) {
    String chordNumerator = chordName.replaceAll("/.*$", "");
    switch(chordNumerator) {
      case "": break;
      case "(NC)": colorRectColor = BG_COLOR; break;
      default: colorRectColor = data.getChordColor(chordNumerator);
    }
  }
  
  void setLogicArtDrawable(boolean boo) {
    logicArt.setDrawable(boo);
  }
  
  void updateLogicArtDrawArea() {
    logicArt.updateDrawArea();
  }
  
  void flashLogicArt() {
    logicArt.flash();
  }
}
