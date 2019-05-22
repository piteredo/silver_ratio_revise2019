class Ball {
  int x = 0;
  int y = 0;
  color baseColor = BALL_COLOR;
  color flashColor = HIGHLIGHT_COLOR;
  color col = baseColor;
  boolean isFlashing = false;
  int flashCount = 0;
  int flashTime = 6;
  int unitCount = 0;
  int sideCount = 0;
  int turnCount = 0;
  int turnLength = 0;
  int rythmeCount = 0;
  int preCounter = 0;
  String[] dirList = new String[4];
  int[] unitLengthList = new int[4];
  int[] pastSideList = {0, 0, 0, 0}; // past count each side
  boolean preWaitable = false;
  boolean preCountable = false;
  boolean isMovable = false;
  boolean isMoving = false;
  boolean endWaitable = false;
  boolean mapUpdatable = false;
  
  void drawBall() {
    String startPos = data.getStartPos(mapId);
    int horiUnitLength = data.getUnitLengthOfSide("HORI", mapId);
    int vertUnitLength = data.getUnitLengthOfSide("VERT", mapId);
    int bpm = data.getBpm(mapId);
    float distPerFrame = calcDistPerFrame(bpm);    
    float framePerUnit = calcFramePerUnit(distPerFrame);
    
    if(mapUpdatable) { // (6) MAP_UPDATE (or end
      updateMapId(); // of root
      mapUpdatable = false;
    }
    else if(endWaitable) { // (5) END_COUNT
      waitEndCount();
    }
    else if(isMovable) { // (4) MOVE_LOOP
      if(frameCount <= 1 && sideCount == 0 && turnCount == 0) moveFirstAction();
      moveLoop(startPos, horiUnitLength, vertUnitLength, distPerFrame, framePerUnit);      
      updateUnitCount(distPerFrame);
      if(unitCount >= unitLengthList[sideCount]) updateSideCount();
    }
    else if(preCountable) { // (3) PRE_COUNT
      preCount(framePerUnit);
      drawPreCounter();
    }
    else if(preWaitable) { // (2) WAIT_COUNT
      waitPreCount();
      drawPreCounter();
    }
    else { // (1) INIT
      initTurnLength();
      initDirList(startPos);
      initMoveType(startPos, horiUnitLength, vertUnitLength);
      resetPastSideList();
      turnCount = 0;
      preWaitable = true;
    }    
    displayBall();
  }
  
  private float calcDistPerFrame(int bpm) {
    float beatPerSecond = bpm / 60;
    float distPerSecond = beatPerSecond * UNIT_WIDTH;
    return distPerSecond / FPS;
  }
  
  private float calcFramePerUnit(float distPerFrame) {
    return UNIT_WIDTH / distPerFrame;
  }
  
  private void initTurnLength() {
    turnLength = data.getTurnLength(mapId);
  }
  
  private void initDirList(String startPos) {
    // startPos => LEFT_TOP pr RIGHT_TOP
    String evenDir = "HORI";
    String oddDir = "VERT";
    if(startPos == "RIGHT_TOP") {
      evenDir = "VERT";
      oddDir = "HORI";
    }
    dirList[0] = evenDir;
    dirList[1] = oddDir;
    dirList[2] = evenDir;
    dirList[3] = oddDir;
  }
  
  private void initMoveType(String startPos, int horiUnitLength, int vertUnitLength) {
    // startPos => LEFT_TOP pr RIGHT_TOP
    switch(startPos){
      case "LEFT_TOP":
        initPos(0, 0);
        initUnitLengthList(horiUnitLength, vertUnitLength);
        break;
      case "RIGHT_TOP":
        initPos(UNIT_WIDTH * horiUnitLength, 0);
        initUnitLengthList(vertUnitLength, horiUnitLength);
        break;
    }
  }
  
  private void initPos(int startX, int startY) {
    x = startX;
    y = startY;
  }
  
  private void initUnitLengthList(int evenSum, int oddSum) {
    // array => {even, odd, even, odd}
    unitLengthList[0] = evenSum;
    unitLengthList[1] = oddSum;
    unitLengthList[2] = evenSum;
    unitLengthList[3] = oddSum;
  }
  
  private void displayBall() {
    fill(col);
    if(isFlashing) flashCount++;
    if(flashCount > flashTime) {
      isFlashing = false;
      col = baseColor;
      flashCount = 0;
    }
    noStroke();
    ellipse(x, y, BALL_SIZE, BALL_SIZE);
  }
  
  private void waitPreCount() {
    if(frameCount >= PRE_WAIT_TIME * FPS) {
      preWaitable = false;
      preCountable = true;
      frameCount = 0;
    }
  }
  
  private void preCount(float framePerUnit) {
    final int beat = 4;
    if(frameCount >= framePerUnit * beat) {      
      flashBall();
      preCounter++;
      if(preCounter > 4) {
        preCounter = 0;
        preCountable = false;
        isMovable = true;
      }
      frameCount = 0;
    }
  }
  
  private void drawPreCounter() {
    fill(BASE_COLOR);
    noStroke();
    int rx = 6;
    int ry = 6;      
    int rw = 14;
    int rh = 14;
    int margin = 5;
    int col1 = BASE_COLOR;
    int col2 = BASE_COLOR;
    int col3 = BASE_COLOR;
    int col4 = BASE_COLOR;
    switch(preCounter) {
      case 1:
        col1 = HIGHLIGHT_COLOR;
        break;
      case 2:
        col1 = HIGHLIGHT_COLOR;
        col2 = HIGHLIGHT_COLOR;
        break;
      case 3:
        col1 = HIGHLIGHT_COLOR;
        col2 = HIGHLIGHT_COLOR;
        col3 = HIGHLIGHT_COLOR;
        break;
      case 4:
        col1 = HIGHLIGHT_COLOR;
        col2 = HIGHLIGHT_COLOR;
        col3 = HIGHLIGHT_COLOR;
        col4 = HIGHLIGHT_COLOR;
        break;
    }
    if(data.getStartPos(mapId) == "RIGHT_TOP") {
      int maxX = data.getRectWidth(mapId);
      fill(col1);
      rect(maxX-rx-rw-margin-rw, ry, rw, rh);
      fill(col2);
      rect(maxX-rx-rw, ry, rw, rh);
      fill(col3);
      rect(maxX-rx-rw-margin-rw, ry+rh+margin, rw, rh);
      fill(col4);
      rect(maxX-rx-rw, ry+rh+margin, rw, rh);
    } else {
      fill(col1);
      rect(rx, ry, rw, rh);
      fill(col2);
      rect(rx+rw+margin, ry, rw, rh);
      fill(col3);
      rect(rx, ry+rh+margin, rw, rh);
      fill(col4);
      rect(rx+rw+margin, ry+rh+margin, rw, rh);
    }
  }
  
  private void moveFirstAction() {
    isMoving = true;
    flashBall();
    map.flashArea();
  }
  
  private void moveLoop(String startPos, int horiUnitLength, int vertUnitLength, float distPerFrame, float framePerUnit) {
    // startPos => LEFT_TOP pr RIGHT_TOP
    int s = sideCount;
    int rectWidth = data.getRectWidth(mapId);
    int rectHeight = data.getRectHeight(mapId);
    if(startPos == "RIGHT_TOP") s = (s + 1) % 4; // LEFT=>0, 1, 2, 3  RIGHT=>1, 2, 3, 0
    switch(s){
      case 0:
        x = Math.min( (int)Math.floor(distPerFrame * frameCount), rectWidth);
        y = 0;
        break;
      case 1:
        x = UNIT_WIDTH * horiUnitLength;
        y = Math.min( (int)Math.floor(distPerFrame * frameCount), rectHeight);
        break;
      case 2:
        x = Math.max( (int)Math.floor(distPerFrame * (horiUnitLength * framePerUnit - frameCount)), 0);
        y = UNIT_WIDTH * vertUnitLength;
        break;
      case 3:
        x = 0;
        y = Math.max( (int)Math.floor(distPerFrame * (vertUnitLength * framePerUnit - frameCount)), 0);
        break;
    }
  }
  
  private void updateUnitCount(float distPerFrame) {
    unitCount = (int)Math.floor((frameCount * distPerFrame) / UNIT_WIDTH);
    
    int[] rythmeList = data.getRythmeList(dirList[sideCount], mapId);
    int rythmeCountOfPastSide = countRythmeSumOfPastSide(sideCount);
    int rythmeSumOfPastUnit = countRythmeSumOfPastUnit(rythmeList, rythmeCountOfPastSide);    
    int rythmeSumOfSide = rythmeSumOfPastUnit + rythmeList[rythmeCount-rythmeCountOfPastSide];    
    if(unitCount >= rythmeSumOfSide) {
      updateRythmeCount();
    }
  }
  
  private int countRythmeSumOfPastSide(int s) {
    int result = 0;
    for(int pr=s-1; pr>=0; pr--){
      int[] pastRythmeList = data.getRythmeList(dirList[pr], mapId);
      result += pastRythmeList.length;
    }
    return result;
  }
  
  private int countRythmeSumOfPastUnit(int[] rythmeList, int rythmeCountOfPastSide) {
    int result = 0;
    for(int i = rythmeCount-1-rythmeCountOfPastSide; i>=0; i--) {
      result += rythmeList[i];
    }
    return result;
  }
  
  private void updateRythmeCount() {
    if(turnCount < data.getWholeNoteStartMapId(mapId)) {
      flashBall();
      map.flashArea();
      if(mapId == data.getMapLength()-1 && turnCount >= 1) {
        map.updateLogicArtDrawArea();
        map.flashLogicArt();
      }
      if(mapId == 4 && turnCount == 2) map.updateGradationColor();
    }
    rythmeCount++;
  }
  
  private void flashBall() {
    col = flashColor;
    isFlashing = true;
  }
  
  private void updateSideCount() {    
    updatePastSideList(sideCount);
    sideCount++;    
    if(sideCount == 4) {
      updateTurnCount();
      rythmeCount = 0;
      sideCount = 0;
    }
    unitCount = 0;
    frameCount = 0;
  }
  
  private void updatePastSideList(int s) {
    pastSideList[s]++;
  }
  
  private void updateTurnCount() {
    turnCount++;
    if(turnCount >= turnLength) {
      isMovable = false;
      isMoving = false;
      endWaitable = true;
    }
  }
  
  private void resetPastSideList() {
    for(int i=0; i<pastSideList.length; i++) pastSideList[i] = 0;
  }
  
  private void waitEndCount() {    
    if(frameCount >= END_WAIT_TIME * FPS) {
      endWaitable = false;
      mapUpdatable = true;
      preCounter = 0;
      frameCount = 0;
    }
  }
  
  boolean getIsMoving() {
    return isMoving;
  }
  
  int[] getPastSideList() {
    return pastSideList;
  }
  
  int getTurnCount() {
    return turnCount;
  }
  
  int getSideCount() {
    return sideCount;
  }
  
  int getRythmeCount() {
    return rythmeCount;
  }
  
  int getUnitCount() {
    return unitCount;
  }
  
  boolean getIsLastTurn() {
    return turnCount + 1 == turnLength;
  }
  
  boolean getEndWaitable() {
    return endWaitable;
  }
}
