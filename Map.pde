class Map {
  Area area;
  WholeNote wholeNote;
  Rythme rythme;
  Chord chord;
  int rythmeX = 0;
  int rythmeY = -RYTHME_HEIGHT - RYTHME_DIST;
  int chordX = 0;
  int chordY = rythmeY - CHORD_FONT_SIZE - CHORD_DIST;
  int wholeNoteX =  -WHOLE_NOTE_DIST_X;
  int wholeNoteY = rythmeY - WHOLE_NOTE_DIST_Y;
  int sideOfChordRotate = 2; // HORI=>2, VERT=>1
  String[] dirList = new String[4];  
  int[] chordListIdList = {0, 0, 0, 0}; // each sides
  
  Map() {
    area = new Area();
    wholeNote = new WholeNote();
    rythme = new Rythme();
    chord = new Chord();
  }
  
  void drawMap() {
    String startPos = data.getStartPos(mapId);
    pushMatrix();
    
    area.drawArea();
    
    initDirList(startPos);
    initRotation(startPos);
    initChordList();
    
    for(int s=0; s<4; s++) { // count SIDE
      int[] rythmeList = data.getRythmeList(dirList[s], mapId);
      boolean needToAddWholeNote = checkNeedToAddWholeNote(s);
      int pastRythmeCount = countPastRythme(s);
      int chordListId = chordListIdList[s];
      String[] chordList = data.getChordList(mapId, chordListId);
      boolean needToChordRotate = checkNeedToChordRotate(s);
      
      if(needToAddWholeNote) {
        if(ball.getSideCount() == s && ball.getIsMoving()) wholeNote.highlight();
        wholeNote.drawWholeNote(wholeNoteX, wholeNoteY);
      }
      
      for(int r=0; r<rythmeList.length; r++) {
        drawRythme(r, rythmeList[r], pastRythmeCount, chordList, needToChordRotate);
      }
      rythmeX = 0;
      chordX = 0;
      rotateSide(dirList[s], 90);
    }    
    popMatrix();
  }
  
  private int countPastRythme(int s) {
    int result = 0;
    for(int pr=s-1; pr>=0; pr--){
      int[] pastRythmeList = data.getRythmeList(dirList[pr], mapId);
      result += pastRythmeList.length;
    }
    return result;
  }
  
  private void drawRythme(int r, int rythmeType, int pastRythmeCount, String[] chordList, boolean needToChordRotate) {
    //rythmeType => 5 or 7    
    int allRythmeCount = pastRythmeCount + r;
    String chordName = chordList[allRythmeCount];
    if(mapId==5 && ball.getTurnCount()>=1 && ball.getTurnCount()<4) {
      rythme.setChordNameColor(chordName);
      chord.setChordNameColor(chordName);
    }
    if(ball.getRythmeCount() == allRythmeCount && ball.getIsMoving()) {
      rythme.highlight();
      chord.highlight();
      area.updateRectColor(chordName);
    }    
    rythme.drawRythme(rythmeType, rythmeX, rythmeY);
    chord.drawChord(chordName, chordX, chordY, needToChordRotate);    
    for(int u=0; u<rythmeType; u++) countUnit();  // count UNIT
  }
  
  private void countUnit() {
    rythmeX += UNIT_WIDTH;
    chordX += UNIT_WIDTH;
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
  
  private void initRotation(String startPos) {
    sideOfChordRotate = 2;
    if(startPos == "RIGHT_TOP") {
      sideOfChordRotate = 1;
      rotateSide(dirList[1], 90);
    }
  }
  
  private void rotateSide(String dir, int degree) {
    int horiSize = data.getRectWidth(mapId);
    if(dir == "VERT") horiSize = data.getRectHeight(mapId);
    translate(horiSize, 0);
    rotate(degree * PI/180);
  }
  
  private void initChordList() {
    int[] ballPastSideList = ball.getPastSideList();
    Integer[] chordChangeMapId = data.getChordChangeMapId(mapId);
    for(int i=0; i<ballPastSideList.length; i++) {
      int chordListId = 0;
      int past = ballPastSideList[i];
      for(int j=0; j<chordChangeMapId.length; j++) {
        int changePoint = chordChangeMapId[j];
        if(past >= changePoint) chordListId++;
      }
      chordListIdList[i] = chordListId;
    }
  }
  
  private boolean checkNeedToChordRotate(int currentSide) {
    return currentSide == sideOfChordRotate;
  }
  
  private boolean checkNeedToAddWholeNote(int currentSide) {
    int[] ballPastSideList = ball.getPastSideList();
    int wholeNoteStartMapId = data.getWholeNoteStartMapId(mapId);
    return ballPastSideList[currentSide] >= wholeNoteStartMapId && ballPastSideList[currentSide] < data.getTurnLength(mapId);
  }
  
  void flashArea() {
    area.flash();
  }
  
  void setLogicArtDrawable(boolean boo) {
    area.setLogicArtDrawable(boo);
  }
  
  void updateLogicArtDrawArea() {
    area.updateLogicArtDrawArea();
  }
  
  void flashLogicArt() {
    area.flashLogicArt();
  }
  
  void updateGradationColor() {
    area.updateGradationColor();
  }
}
