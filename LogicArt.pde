class LogicArt {
  boolean logicArtDrawable = false;
  int drawUnit = 4;
  int drawArea = 4;
  List<Integer[]> drawList = new ArrayList<Integer[]>();
  List<Integer[]> colorList = new ArrayList<Integer[]>();
  int margin = 2;
  int maxMapId = data.getMapLength() - 1;
  int rectWidth = data.getRectWidth(maxMapId);
  int rectHeight = data.getRectHeight(maxMapId);
  float w = ((float)(rectWidth - margin) / (float)data.getLogicArtLengthX()) - margin;
  float h = ((float)(rectHeight - margin) / (float)data.getLogicArtLengthY()) - margin;
  
  int alpha = 0;
  boolean isFlashing = false;
  int flashCount = 0;
  int flashTime = 14;
  int flashDecreaseSize = 5;
  color baseColor = BG_COLOR;
  color flashColor = color(255);
  color col = baseColor;
  
  LogicArt() {
    initDrawList();
    initColor();
  }
  
  private void initDrawList() {
    int[][] artData = data.getLogicArtData();
    for(int y=0; y<artData.length; y++) {
      for(int x=0; x<artData[y].length; x++) {
        if(artData[y][x] == 1) {  
          Integer[] arr = {x, y};
          drawList.add(arr);
        }
      }
    }
    Collections.shuffle(drawList);
  }
  
  private void initColor() {
    String[] chordList = data.getChordList(5, 1);
    for(int i=0; i<chordList.length; i++) {
      colorList.add(getRectColor(chordList, i));
    }
  }
  
  Integer[] getRectColor(String[] chordList, int i) {
    String chordNumerator = chordList[i].replaceAll("/.*$", "");
    if(chordNumerator.equals("")) chordNumerator = chordList[i-1].replaceAll("/.*$", "");
    return data.getChordColorInt(chordNumerator);
  }
  
  void drawLogicArt() {    
    int index = 0;
    while(index < drawList.size() && index < drawArea && logicArtDrawable) {
      float x = drawList.get(index)[0];
      float y = drawList.get(index)[1];
      noStroke();
      if(ball.getIsLastTurn() && ball.getSideCount() == 1) fill(BG_COLOR);
      else if(ball.getIsLastTurn() && ball.getSideCount() == 2) fill(BASE_COLOR);
      else fill(colorList.get((int)(index/4)%34)[0], colorList.get((int)(index/4)%34)[1], colorList.get((int)(index/4)%34)[2]);
      rect(x*w+x*margin + margin, y*h+y*margin + margin, w, h);
      
      if(index/4 == drawArea/4 - 1) {
        fill(col, alpha);
        rect(x*w+x*margin + margin, y*h+y*margin + margin, w, h);
      }
      
      fill(BG_COLOR);
      textSize(LOGICART_FONT_SIZE);
      textAlign(CENTER);
      if(index/4 == drawArea/4 - 1) text((int)Math.floor(index/4)+1, x*w+x*margin + 14 + margin, y*h+y*margin + 22 + margin);
      textAlign(LEFT);
      index++;
    }
    
    
    
    if(isFlashing){
      flashCount++;
      alpha -= flashDecreaseSize;
    }
    if(flashCount > flashTime) {
      isFlashing = false;
      col = baseColor;
      flashCount = 0;
      alpha = 0;
    }
  }
  
  void flash() {
    col = flashColor;
    alpha = 100;
    isFlashing = true;
  }
  
  void setDrawable(boolean boo) {
    logicArtDrawable = boo;
  }
  
  void updateDrawArea() {
    drawArea += drawUnit;
  }
}
