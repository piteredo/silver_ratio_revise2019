class WholeNote {
  PFont font = loadFont("Maestro-34.vlw");
  color col = BASE_COLOR;
  
  void drawWholeNote(int x, int y) {
    textFont(font);
    fill(col);
    textAlign(RIGHT);
    text("w", x, y);
    col = BASE_COLOR;
    textAlign(LEFT);
  }
  
  void highlight() {
    col = HIGHLIGHT_COLOR;
  }
}
