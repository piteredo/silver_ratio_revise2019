class Data{
  int[][] horiRythme = {
    {5},
    {5, 5},
    {7, 5},
    {7, 5, 7, 5},
    {5, 7, 5, 7, 5},
    {5, 7, 5, 7, 5, 5, 7, 5, 7, 5}
  };
  
  int[][] vertRythme = {
    {7},
    {7},
    {5, 7, 5},
    {5, 7, 5},
    {7, 5, 5, 7, 5, 7, 5},
    {7, 5, 5, 7, 5, 7, 5}
  };
  
  String[][][] chordList = {
    {
      {"Bb△7/A", "E△7/G#", "Bb△7/D", "E△7/D#"},
      {"(NC)", "(NC)", "(NC)", "(NC)"},
      {"Ab△7", "D△7", "Ab△7", "D△7"},
      {"Db△7", "G△7", "Db△7", "G△7"},
      {"", "", "", ""}
    },
    {
      {"G△7", "Db△7", "", "G△7", "Db△7", ""},
      {"(NC)", "(NC)", "", "(NC)", "(NC)", ""},
      {"E△7/D#", "Bb△7/D", "", "C△7", "Gb△7/Bb", ""},
      {"", "", "", "", "", ""}
    },
    {
      {"(NC)", "", "(NC)", "", "", "(NC)", "", "(NC)", "", ""},
      {"F#m", "", "Eb/G", "", "", "F#m", "", "Eb/G", "", ""},
      {"F#m", "A/C#", "Cm", "/Bb", "Eb/G", "F#m", "A/C#", "Cm", "/Bb", "Eb/G"},
      {"F#m", "", "Cm", "", "", "F#m", "", "Cm", "", ""},
      {"", "", "", "", "", "", "", "", "", ""}
    },
    {
      
      {"(NC)", "", "", "(NC)", "", "", "", "(NC)", "", "", "(NC)", "", "", ""},
      {"Eb/G", "", "", "F#m", "", "", "", "Eb/G", "", "", "F#m", "", "", ""},
      {"Cm", "/Bb", "Eb/G", "F#m", "/G#", "A", "/B", "Cm", "/Bb", "Eb/G", "F#m", "/G#", "A", "/B"},
      {"B△7", "", "", "F△7/A", "", "", "", "Ab/Gb", "", "", "D/F#", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", ""}
    },
    {
      {"(NC)", "", "", "", "", "(NC)", "", "", "", "", "", "", "F#m", "", "", "", "", "Cm/Eb", "", "", "", "", "", ""},
      {"F#m", "", "", "", "", "Cm/Eb", "", "", "", "", "", "", "F#m", "", "", "", "", "Cm/Eb", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""}
    },
    {
      {"C△7", "", "", "", "", "", "", "Gb△7", "", "", "", "", "", "", "", "", "", "C△7", "", "", "", "", "", "", "Gb△7", "", "", "", "", "", "", "", "", ""},
      {"C", "Eb△7", "F6", "G", "Em", "Am", "Am/G", "Gb△", "Bbm", "B△", "A△", "Db/Ab", "Db/F", "Gb△7", "Ebm", "Ebm/Db", "B△", "C", "Eb△7", "F6", "G", "Em", "Am", "Am/G", "Gb△", "Bbm", "B△", "A△", "Db/Ab", "Db/F", "Gb△7", "Ebm", "Ebm/Db", "B△"},
      {"C△7", "", "", "", "", "", "", "Gb△7", "", "", "", "", "", "", "", "", "", "C△7", "", "", "", "", "", "", "Gb△7", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""}    }
  };
  
  HashMap<String, Integer[]> chordColorMap = new HashMap<String, Integer[]>() {
    {
      put("Ab△7", new Integer[]{150, 0, 0});
      put("Ab", new Integer[]{150, 0, 0});
      put("D△7", new Integer[]{190, 155, 0});
      put("D", new Integer[]{190, 155, 0});
      
      put("E△7", new Integer[]{20, 125, 115});      
      put("Bb△7", new Integer[]{0, 60, 140});
      put("C△7", new Integer[]{35, 125, 170});
      put("C", new Integer[]{35, 125, 170});
      put("Gb△7", new Integer[]{100, 50, 100});
      put("Gb△", new Integer[]{100, 50, 100});
      
      put("F#m", new Integer[]{160, 80, 20});
      put("Eb", new Integer[]{20, 125, 115});
      put("Eb△7", new Integer[]{20, 125, 115});
      put("A", new Integer[]{150, 0, 0});
      put("A△", new Integer[]{150, 0, 0});
      put("Cm", new Integer[]{35, 125, 170});
      
      put("B△7", new Integer[]{180, 60, 155});
      put("F△7", new Integer[]{90, 155, 60});
      put("F6", new Integer[]{90, 155, 60});
      
      put("G", new Integer[]{160, 80, 20});      
      put("Em", new Integer[]{90, 90, 90});
      put("Am", new Integer[]{109, 55, 55});      
      put("Bbm", new Integer[]{20, 125, 115});      
      put("Db", new Integer[]{190, 155, 0});
      put("Ebm", new Integer[]{90, 90, 90});
      put("B△", new Integer[]{150, 45, 135});
      
      
      put("Db△7", new Integer[]{186, 167, 29}); // NOT USE      
      put("G△7", new Integer[]{45, 105, 196}); // NOT USE
    }
  };
  
  String[][] WholeNote = {
    {"w", "w", "w", "w"},
    {"w", "w", "", "w", "w", ""},
    {"w", "", "w", "", "", "w", "", "w", "", ""},
    {"w", "", "", "w", "", "", "", "w", "", "", "w", "", "", ""},
    {"w", "", "", "", "", "w", "", "", "", "", "", "", "w", "", "", "", "", "w", "", "", "", "", "", ""},
    {"w", "", "", "", "", "", "", "w", "", "", "", "", "", "", "", "", "", "w", "", "", "", "", "", "", "w", "", "", "", "", "", "", "", "", ""}
  };
  
  String[][] note = {
    {"C", "F#"},
    {"F#", "heigherC"},
    {"E", "Bb"},
    {"Bb", "heigherE"},
    {"G#", "D"},
    {"D", "Ab"}
  };
  
  int[] turnLength = {12, 9, 6, 7, 4, 5};
  
  Integer[][] chordChangeMapId = {
    // starts from 0
    {4, 6, 10, 12},
    {2, 3, 9},
    {1, 3, 5, 6},
    {1, 2, 4, 7},
    {1, 4},
    {1, 4, 5}
  };
  
  Integer[] wholeNoteStartMapId = {10, 7, 5, 6, 3, 4}; // starts from 0
  
  String[] startPos = {"LEFT_TOP", "RIGHT_TOP", "LEFT_TOP", "RIGHT_TOP", "LEFT_TOP", "RIGHT_TOP"};
  
  int[] bpm = {390, 390, 410, 410, 440, 440};
  
  int[][] logicArt = {
    {1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1},
    {1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1},
    {1,1,1,0,0,0,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,1},
    {1,1,0,0,1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1,0,0,1,1},
    {1,1,0,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,0,1,1},
    {0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0},
    {1,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,1},
    {1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1},
    {1,1,0,0,1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1,0,0,1,1},
    {1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1},
    {1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1},
    {1,1,1,1,1,1,0,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1},
    {1,1,0,0,1,0,0,1,0,0,1,0,0,1,1,0,0,1,0,0,1,0,0,1,0,0,1,1},
    {1,0,0,1,1,0,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,0,1,1,0,0,1},
    {1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  };
  
  
  //----------------------
  
  
  int getMapLength() {
    return turnLength.length;
  }
  
  int[] getRythmeList(String type, int mapId) {
    if(type == "HORI") return horiRythme[mapId];
    else return vertRythme[mapId];
  }
  
  int getUnitLengthOfSide(String type, int mapId) {
    int result = 0;
    switch(type){
      case "HORI":
        for(int i=0; i<horiRythme[mapId].length; i++) {
          result += horiRythme[mapId][i];
        };
        break;
      case "VERT":
        for(int i=0; i<vertRythme[mapId].length; i++) {
          result += vertRythme[mapId][i];
        };
        break;
    }    
    return result;
  }
  
  int getRectWidth(int mapId) {
    return UNIT_WIDTH * getUnitLengthOfSide("HORI", mapId);
  }
  
  int getRectHeight(int mapId) {
    return UNIT_WIDTH * getUnitLengthOfSide("VERT", mapId);
  }
  
  int getRectSizeByDirName(String dirName, int mapId) {
    return UNIT_WIDTH * getUnitLengthOfSide(dirName, mapId);
  }
  
  String[] getChordList(int mapId, int chordListId) {
    return chordList[mapId][chordListId];
  }
  
  String[] getNote(int mapId) {
    return note[mapId];
  }
  
  int getTurnLength(int mapId) {
    return turnLength[mapId];
  }
  
  Integer[] getChordChangeMapId(int mapId) {
    return chordChangeMapId[mapId];
  }
  
  int getWholeNoteStartMapId(int mapId) {
    return wholeNoteStartMapId[mapId];
  }
  
  String getStartPos(int mapId) {
    return startPos[mapId];
  }
  
  int getBpm(int mapId) {
    return bpm[mapId];
  }
  
  int[][] getLogicArtData() {
    return logicArt;
  }
  
  int getLogicArtLengthX() {
    return logicArt[0].length;
  }
  
  int getLogicArtLengthY() {
    return logicArt.length;
  }
  
  color getChordColor(String chordName) {
    Integer[] colorArr = chordColorMap.get(chordName); //R,G,B
    return color(colorArr[0], colorArr[1], colorArr[2]);
  }
  
  color getChordBrighterColor(String chordName) {
    int add = 20;
    Integer[] colorArr = chordColorMap.get(chordName); //R,G,B
    return color(colorArr[0]+add, colorArr[1]+add, colorArr[2]+add);
  }
  
  Integer[] getChordColorInt(String chordName) {
    return chordColorMap.get(chordName); //R,G,B
  }
}
