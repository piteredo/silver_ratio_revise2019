class Chord {
  PFont font = createFont(CHORD_FONT, CHORD_FONT_SIZE);
  color col = BASE_COLOR;
  
  void drawChord(String chordName, int x, int y, boolean needToChordRotate) {
    pushMatrix();    
    if(needToChordRotate) {
      rotate(180 * PI/180);
      textAlign(RIGHT);
      x *= -1;
      y *= -1;
      y -= CHORD_FONT_SIZE;
    }    
    fill(col);
    textSize(CHORD_FONT_SIZE);
    textFont(font);
    text(chordName, x, y + CHORD_FONT_SIZE); // +fontSize => originY=0
    col = BASE_COLOR;
    textAlign(LEFT);
    popMatrix();
  }
  
  void setChordNameColor(String chordName) {
    String chordNumerator = chordName.replaceAll("/.*$", "");
    switch(chordNumerator) {
      case "": break;
      case "(NC)": col = BG_COLOR; break;
      default: col = data.getChordBrighterColor(chordNumerator);
    }
  }
  
  void highlight() {
    col = HIGHLIGHT_COLOR;
  }
}
