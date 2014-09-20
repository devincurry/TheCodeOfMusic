import themidibus.*;
MidiBus myBus;

int lastBeat;
float beatLength;

int seqW = 1200;
int seqH = 800;
int lightSize = 20;
//float lightPos = seqW/16 + seqW/32;
int lightPos;

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

boolean light00 = false;
boolean light01 = false;
boolean light02 = false;
boolean light03 = false;
boolean light04 = false;
boolean light05 = false;
boolean light06 = false;
boolean light07 = false;
boolean light08 = false;
boolean light09 = false;
boolean light10 = false;
boolean light11 = false;
boolean light12 = false;
boolean light13 = false;
boolean light14 = false;
boolean light15 = false;

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
  size (seqW, seqH);
  colorMode(HSB, 100, 100, 100);
  background (0, 0, 20);

  ellipseMode(CENTER);
  rectMode(CENTER);
  noStroke();
  fill(0, 100, 50);

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
  background (0, 0, 20);

  int steps = 16;
  int scaleNotes = 8;


  for (int i = 0; i < steps; i++) {
    //    velocity = (int)random(70, 127);

    //notes
    checkStep(i);
    int j = (int) random(0, stepArray[i].length - 1);
    Note note = new Note(0, stepArray[i][j], velocity);
    myBus.sendNoteOn(note);
    delay(400); //this is an initial, dirty way of doing this!
    myBus.sendNoteOff(note);
    checkStep(i);

    println (i, j, velocity);
  }
  //    redLights();
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
  /*
  background(0,0,20);
   fill(0, 100, 100);
   lightPos = ((stepNumb+1)*(seqW/16))+(seqW/32);
   ellipse(lightPos, seqH/2, lightSize, lightSize);
   */

  if (stepNumb == 0) {
    //light15 = false;
    light00 = true;
    redLights();

    //    background(0, 0, 20);
    //    ellipse(lightPos*stepNumb+1, seqH/2, lightSize, lightSize);
    //    background(0,0,20);
    if (beat00 == false) {
      velocity = 0;
    } 
    else {
      light00 = false;
      velocity = (int)random(70, 127);
      redLights();
    }
  }

  if (stepNumb == 1) {
    //light00 = false;
    light01 = true;
          redLights();

    if (beat01 == false) {
      velocity = 0;
    } 
    else {
      light01 = false;
      velocity = (int)random(70, 127);
            redLights();

    }
  }

  if (stepNumb == 2) {
    if (beat02 == false) {
      velocity = 0;
    } 
    else {
      light02 = false;
      velocity = (int)random(70, 127);
    }
  }
  if (stepNumb == 3) {
    if (beat03 == false) {
      velocity = 0;
    } 
    else {
            light03 = false;
velocity = (int)random(70, 127);
    }
  }  
  
  if (stepNumb == 4) {
    if (beat04 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 5) {
    if (beat05 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 6) {
    if (beat06 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 7) {
    if (beat07 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 8) {
    if (beat08 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 9) {
    if (beat09 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 10) {
    if (beat10 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 11) {
    if (beat11 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 12) {
    if (beat12 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 13) {
    if (beat13 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 14) {
    if (beat14 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }  
  if (stepNumb == 15) {
    if (beat15 == false) {
      velocity = 0;
    } 
    else {
      velocity = (int)random(70, 127);
    }
  }
}

void redLights() {
  if (light00 == true) {
    //background(0, 0, 20);
    fill(0, 100, 100);
    ellipse(seqW/16, seqH/3, lightSize, lightSize);
  } 
  else {
    //background(0, 0, 20);
    fill(0, 100, 60);
    ellipse(seqW/16, seqH/3, lightSize, lightSize);
  }
    if (light01 == true) {
    //background(0, 0, 20);
    fill(0, 100, 100);
    ellipse(seqW/16, seqH/3, lightSize, lightSize);
  } 
  else {
    //background(0, 0, 20);
    fill(0, 100, 60);
    ellipse((seqW/16)*2, seqH/3, lightSize, lightSize);
  }
    if (light02 == true) {
    //background(0, 0, 20);
    fill(0, 100, 100);
    ellipse((seqW/16)*2, seqH/3, lightSize, lightSize);
  } 
  else {
    //background(0, 0, 20);
    fill(0, 100, 60);
    ellipse((seqW/16)*2, seqH/3, lightSize, lightSize);
  }
}

void exit() {
  println("stop");
  for (int i = 0; i < 127; i++) {
    myBus.sendNoteOff(new Note(0, i, 0));
  }
  super.exit();
}

