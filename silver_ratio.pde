import java.util.*;
import java.math.BigDecimal;

Data data;
Course course;
Map map;
Ball ball;
Label label;
final int FPS = 30;
final int UNIT_WIDTH = 15;
final int SCREEN_WIDTH = 1024;
final int SCREEN_HEIGHT = 768;
final int BALL_SIZE = 12; // diameter
final color BALL_COLOR = color(165);
final int TITLE_WAIT_TIME = 6; // time of title scene (second
final int PRE_WAIT_TIME = 3; // time before ball starts (second
final int END_WAIT_TIME = 7; // time before map updates (second
final color BASE_COLOR = color(175, 175, 175);
final color HIGHLIGHT_COLOR = color(255, 255, 255);
final color BG_COLOR = color(25, 25, 25);
final int RYTHME_HEIGHT = 14;
final int RYTHME_DIST = 15; // dist from rect
final int CHORD_FONT_SIZE = 18;
final String CHORD_FONT = "Yu Gothic bold";
final int CHORD_DIST = 12; // dist from rythme
final int WHOLE_NOTE_DIST_X = 7; // dist from 0
final int WHOLE_NOTE_DIST_Y = CHORD_DIST + 6; // dist from rythme
final int LOGICART_FONT_SIZE = 20;
String scene = "TITLE"; //TITLE => MAIN
int mapId = 0;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {  
  frameRate(FPS);
  strokeCap(SQUARE);
  data = new Data();
  course = new Course();
  map = new Map();
  ball = new Ball();
  label = new Label();
}

void draw() {
  background(BG_COLOR);
  switch(scene) {
    case "TITLE":
      title();
      break;
    case "MAIN":
      course.drawCourse();
      label.drawLabel();
      break;
  }
}

void title() {
  PImage img = loadImage("title_bg.png");
  image(img, 0, 0);
  if(frameCount >= TITLE_WAIT_TIME * FPS) {
    scene = "MAIN";
    frameCount = 0;
  }
}

void updateMapId() {
  if(mapId == 5) stopLoop();
  else mapId++;
}

void stopLoop() {
  noLoop();
}
