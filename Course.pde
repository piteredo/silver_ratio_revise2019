class Course {  
  int x;
  int y;
  
  Course() {
    int maxMapId = data.getMapLength() - 1;
    int w = data.getRectWidth(maxMapId);
    int h = data.getRectHeight(maxMapId);
    x = (SCREEN_WIDTH - w) / 2;
    y = (SCREEN_HEIGHT - h) / 2;
  }
  
  void drawCourse() {
    pushMatrix();
    translate(x, y);    
    map.drawMap();
    ball.drawBall();
    popMatrix();
  }
  
  int getMapPosX() {
    return x;
  }
  
  int getMapPosY() {
    return y;
  }
}
