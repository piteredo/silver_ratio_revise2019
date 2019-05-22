class Rythme {
  int w = UNIT_WIDTH;
  int h = RYTHME_HEIGHT;
  int barWeight = 1;
  int flagWeight = 3;
  float flag16thPos = 0.5; //0.0~1.0(percent
  color col = BASE_COLOR;
  
  void drawRythme(int type, int x, int y) {
    stroke(col);
    switch(type){
      case 5:
        createRythme0(x, y);
        createRythme1(x + w, y);
        createRythme2(x + w*2, y);
        createRythme3(x + w*3, y);
        createRythme4(x + w*4, y);
        break;
      case 7:
        createRythme0(x, y);
        createRythme1(x + w, y);
        createRythme5(x + w*2, y);
        createRythme1(x + w*3, y);
        createRythme5(x + w*4, y);
        createRythme1(x + w*5, y);
        createRythme6(x + w*6, y);
        break;
    }
    col = BASE_COLOR;
  }

  private void createRythme0(int x, int y){
    strokeWeight(flagWeight);
    line(x+w/2+1, y, x, y); // +1 => adjust
    strokeWeight(barWeight);
    line(x, y, x, y+h);
  }
  
  private void createRythme1(int x, int y){
    strokeWeight(flagWeight);
    line(x-w/2-1, y, x+w/2+1, y);
    strokeWeight(barWeight);
  }
  
  private void createRythme2(int x, int y){
    line(x, y, x, y+h);
    strokeWeight(flagWeight);
    line(x-w/2-1, y, x+w/2+1, y);
    line(x-w/2-1, y+h*flag16thPos, x, y+h*flag16thPos);
    strokeWeight(barWeight);
  }
  
  private void createRythme3(int x, int y){
    strokeWeight(flagWeight);
    line(x-w/2-1, y, x, y);
    strokeWeight(barWeight);
    line(x, y, x, y+h);
  }
  
  private void createRythme4(int x, int y){
    //draw nothing
  }
  
  private void createRythme5(int x, int y){
    strokeWeight(flagWeight);
    line(x-w/2-1, y, x+w/2+1, y);
    strokeWeight(barWeight);
    line(x, y, x, y+h);
  }
  
  private void createRythme6(int x, int y){
    line(x, y, x, y+h);
    strokeWeight(flagWeight);
    line(x-w/2-1, y, x, y);
    line(x-w/2-1, y+h*flag16thPos, x, y+h*flag16thPos);
    strokeWeight(barWeight);
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
