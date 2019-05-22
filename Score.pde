class Score {
  PFont font = loadFont("Maestro-34.vlw");
  int w = 120;
  int scaleHeight = 8;
  //int x = 234 - 40;
  //int y = 335 - 140;
  float noteAX = w/3;
  float noteBX = w/3*2;
  int accidentalMargin = 10;
  
  void drawScore(int x, int y) {
    pushMatrix();
    translate(x, y);
    
    textFont(font);        
    String[] notes = data.getNote(mapId);
    drawLines(notes);
    drawClef();
    drawNotes(notes);
    
    popMatrix();
  }
  
  private void drawClef() {
    fill(BASE_COLOR);
    text("&", 0, scaleHeight*3);
  }
  
  private void drawNotes(String[] notes) { 
    float noteAY = calcNoteYPos(notes[0]) + scaleHeight*3;
    float noteBY = calcNoteYPos(notes[1]) + scaleHeight*3;
    String accidentalA = getAccidental(notes[0]);
    String accidentalB = getAccidental(notes[1]);
    fill(getColor(0, 2));
    text("w", noteAX, noteAY);
    text(accidentalA, noteAX-accidentalMargin, noteAY);
    fill(getColor(1, 3));
    text("w", noteBX, noteBY);    
    text(accidentalB, noteBX-accidentalMargin, noteBY);
  }
  
  private float calcNoteYPos(String note) {
    // 0 = G pos;
    float diff = 0;
    switch(note){
      case "C": diff = 4; break;
      case "E": diff = 2; break;      
      case "F#": diff = 1; break;
      case "G#": diff = 0; break;      
      case "Bb": diff = -2; break;
      case "heigherC": diff = -3; break;
      case "D": diff = -4; break;
      case "heigherE": diff = -5; break;
      case "Ab": diff = -8; break;
    }
    return diff * scaleHeight/2;
  }
  
  private String getAccidental(String note) {
    String result = "";
    switch(note){
      case "F#":
      case "G#":
        result = "#";
        break;
      case "Ab":
      case "Bb":
        result = "b";
        break;
    }
    return result;
  }
  
  private void drawLines(String[] notes) {
    stroke(BASE_COLOR);
    if(notes[0] == "Ab") line(noteAX-5, -scaleHeight*4 + scaleHeight*3, noteAX+20, -scaleHeight*4 + scaleHeight*3);
    if(notes[1] == "Ab") line(noteBX-5, -scaleHeight*4 + scaleHeight*3, noteBX+20, -scaleHeight*4 + scaleHeight*3);
    line(0, -scaleHeight*3 + scaleHeight*3, w, -scaleHeight*3 + scaleHeight*3);
    line(0, -scaleHeight*2 + scaleHeight*3, w, -scaleHeight*2 + scaleHeight*3);
    line(0, -scaleHeight + scaleHeight*3, w, -scaleHeight + scaleHeight*3);
    line(0, scaleHeight*3, w, scaleHeight*3);
    line(0, scaleHeight + scaleHeight*3, w, scaleHeight + scaleHeight*3);
    if(notes[0] == "C") line(noteAX-5, scaleHeight*2+scaleHeight*3, noteAX+20, scaleHeight*2+scaleHeight*3);
    if(notes[1] == "C") line(noteBX-5, scaleHeight*2+scaleHeight*3, noteBX+20, scaleHeight*2+scaleHeight*3);
  }
  
  private color getColor(int scA, int scB) {
    if((ball.getSideCount()==scA || ball.getSideCount()==scB) && ball.getIsMoving()) return HIGHLIGHT_COLOR;
    return BASE_COLOR;
  }
}
