import themidibus.*;
MidiBus myBus;

int lastBeat;
float beatLength;
int seqW = 800;
int seqH = 800;

int velocity;

//on off for sequencer
boolean beat00 = true;
boolean beat01 = true;
boolean beat02 = false;
boolean beat03 = true;
boolean beat04 = true;
boolean beat05 = true;
boolean beat06 = false;
boolean beat07 = false;
boolean beat08 = true;
boolean beat09 = true;
boolean beat10 = true;
boolean beat11 = false;
boolean beat12 = false;
boolean beat13 = true;
boolean beat14 = false;
boolean beat15 = true;


int [][] stepArray = { 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
  , 
  {
    60, 62, 64, 65, 67, 69, 71, 72
  }
};


void setup() {
  //size (seqW, seqH);
  //background (0);

  lastBeat = millis();
  beatLength = 500;
  MidiBus.list();
  myBus = new MidiBus(this, 1, 2);
}

void draw() {
  /*
  if (millis() - lastBeat > beatLength) {
   lastBeat = millis();
   onBeat();
   }
   */

  int steps = 16;
  int scaleNotes = 8;
  for (int i = 0; i < steps; i++) {
    //    velocity = (int)random(70, 127);
    checkStep(i);
    int j = (int) random(0, stepArray[i].length - 1);
    Note note = new Note(0, stepArray[i][j], velocity);
    myBus.sendNoteOn(note);
    delay(400); //this is an initial, dirty way of doing this!
    myBus.sendNoteOff(note);
    println (i, j, velocity);
  }
}



void onBeat() {
  int midiNote = (int)random(50, 73);
  int velocity = (int)random(80, 127);

  Note note = new Note(0, midiNote, velocity);
  myBus.sendNoteOn(note);
  delay(400); //this is an initial, dirty way of doing this!
  myBus.sendNoteOff(note);
}

void checkStep(int stepNumb) {
  if (stepNumb == 0) {
    if (beat00 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }
  if (stepNumb == 1) {
    if (beat01 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }
  if (stepNumb == 2) {
    if (beat02 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }
    if (stepNumb == 3) {
    if (beat03 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 4) {
    if (beat04 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 5) {
    if (beat05 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 6) {
    if (beat06 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 7) {
    if (beat07 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 8) {
    if (beat08 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 9) {
    if (beat09 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 10) {
    if (beat10 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 11) {
    if (beat11 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 12) {
    if (beat12 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 13) {
    if (beat13 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 14) {
    if (beat14 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  if (stepNumb == 15) {
    if (beat15 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }
  
}

void exit() {
  println("stop");
  for (int i = 0; i < 127; i++) {
    myBus.sendNoteOff(new Note(0, i, 0));
  }
  super.exit();
}

