class Label {
  Score score;
  int x;
  int y;
  int w = 120;
  int h = 204;
  int tcX; // turn counter
  int tcY;
  final int distX = 90; // dist from mapX end
  final int bpmDiffY = -20;
  final int ratioDiffY = 90;
  final int approxDiffY = ratioDiffY + 30;
  final int root2DiffY = approxDiffY + 23;
  final int diffDiffY = root2DiffY + 23;
  final int fontSize = 12;
  final int bpmFontSize = 14;
  final int turnCountFontSize = 18;
  final int ratioFontSize = 44;
  PFont font = createFont("Yu Gothic bold", fontSize);
  PFont ratioFont = createFont("Yu Gothic", fontSize);
  PFont musicFont = loadFont("Maestro-26.vlw");
  
  Label() {
    score = new Score();
  }

  void drawLabel() {
    pushMatrix();    
    int mapX = course.getMapPosX();
    int mapY = course.getMapPosY();
    int mapW = data.getRectWidth(mapId);
    int mapH = data.getRectHeight(mapId); // ?
    int ratioX = data.getUnitLengthOfSide("HORI", mapId);
    int ratioY = data.getUnitLengthOfSide("VERT", mapId);
    switch(data.getStartPos(mapId)){
      case "RIGHT_TOP":
        ratioX = data.getUnitLengthOfSide("VERT", mapId);
        ratioY = data.getUnitLengthOfSide("HORI", mapId);
        break;
    }
    initCounterPos(mapX, mapY, mapW, mapH);
    drawCount();    
    if((ball.getTurnCount() <= 0 || mapId != data.getMapLength()-1) && (mapId != 4 || !ball.getEndWaitable())) {
      initPos(mapX, mapY, mapW, mapH);
      drawBpm();
      drawScore();
      drawRatio(ratioX, ratioY);
      float approx = drawApprox(ratioX, ratioY);
      float root2 = drawRoot2();
      drawDiff(root2, approx);
    }    
    popMatrix();
  }
  
  private void initCounterPos(int mapX, int mapY, int mapW, int mapH) {
    tcY = mapY - turnCountFontSize + 2;
    switch(data.getStartPos(mapId)) {
      case "LEFT_TOP":
        tcX = mapX - 5;        
        textAlign(RIGHT);
        break;
      case "RIGHT_TOP":
        tcX = mapX + mapW + 5;
        textAlign(LEFT);
        break;
    }    
  }
  
  private void drawCount() {
    int turnCount = ball.getTurnCount();
    int turnLength = data.getTurnLength(mapId);
    fill(BASE_COLOR);
    textFont(font);
    textSize(turnCountFontSize);
    if(turnCount < turnLength) text((turnCount+1) + "/" + turnLength, tcX, tcY);
  }
  
  private void initPos(int mapX, int mapY, int mapW, int mapH) {
    switch(mapId) {
      case 0:
      case 1:
      case 2:
      case 3:
        setPosSide(mapX, mapY, mapW);
        break;
      case 4:
      case 5:
        setPosCenter(mapX, mapY, mapW, mapH);
        break;
    }    
  }
  
  private void setPosSide(int mapX, int mapY, int mapW) {
    x = mapX + mapW + distX;
    y = mapY;
  }
  
  private void setPosCenter(int mapX, int mapY, int mapW, int mapH) {
    x = mapX + (mapW / 2) - (w/2);
    y = mapY + (mapH / 2) - (h/2);
  }
  
  private void drawBpm() {
    int bpm = data.getBpm(mapId);
    fill(BASE_COLOR);
    textAlign(LEFT);
    textFont(musicFont);
    text("x", x, y + bpmDiffY);
    textFont(font);
    textSize(bpmFontSize);
    text("= " + bpm, x+17, y + bpmDiffY);
  }
  
  private void drawScore() {
    textAlign(LEFT);
    score.drawScore(x, y); // y=0(origin
  }
  
  private void drawRatio(int ratioX, int ratioY) {
    textFont(ratioFont);
    textSize(ratioFontSize);
    textAlign(LEFT);
    String textX = String.valueOf(ratioX);
    String textY = String.valueOf(ratioY);
    if(ratioX<10) textX = "0" + ratioX;
    if(ratioY<10) textY = "0" + ratioY;
    
    fill(getColor(0, 2));
    text(textX, x, y + ratioDiffY);
    
    fill(BASE_COLOR);
    text(":", x+55, y + ratioDiffY);
    
    fill(getColor(1, 3));
    text(textY, x+75, y + ratioDiffY);
  }
  
  private float drawApprox(int ratioX, int ratioY) {
    float approx = (float)Math.max(ratioX, ratioY) / (float)Math.min(ratioX, ratioY);
    textAlign(LEFT);
    textFont(font);
    textSize(fontSize);
    fill(BASE_COLOR);
    String txt = "[RATIO]  1 : " + String.valueOf(approx);
    if(mapId >= 1) txt += "...";
    text(txt, x, y + approxDiffY);
    return approx;
  }
  
  private float drawRoot2() {
    final float root2 = (float)Math.sqrt(2);
    textAlign(LEFT);
    textFont(font);
    textSize(fontSize);
    fill(BASE_COLOR);
    text("[√2]  " + root2 + "...", x, y + root2DiffY);
    return root2;
  }
  
  private void drawDiff(float root2, float approx) {
    float diff = Math.abs(root2 - approx);
    textAlign(LEFT);
    textFont(font);
    textSize(fontSize);
    fill(BASE_COLOR);
    text("[DIFF]  " + BigDecimal.valueOf(diff).setScale(7, BigDecimal.ROUND_HALF_UP) + "...", x, y + diffDiffY);
  }  
  
  private color getColor(int scA, int scB) {
    if((ball.getSideCount()==scA || ball.getSideCount()==scB) && ball.getIsMoving()) return HIGHLIGHT_COLOR;
    return BASE_COLOR;
  }
}
