import themidibus.*;
MidiBus myBus;

int lastBeat;
float beatLength;

int seqW = 1200;
int seqH = 800;
int lightSize = 20;
//float lightPos = seqW/16 + seqW/32;
int lightPos;

int buttonX1 = seqW/32;
int buttonX;
int buttonY = seqH/2;
int buttonW = seqW/32;
int buttonH = seqH/10;

int buttonHue1 = 2;
int buttonHue2 = 7;
int buttonHue3 = 12;
int buttonHue4 = 17;
int buttonSat = 80;

int buttonBright00;
int buttonBright01;
int buttonBright02;
int buttonBright03;
int buttonBright04;
int buttonBright05;
int buttonBright06;
int buttonBright07;
int buttonBright08;
int buttonBright09;
int buttonBright10;
int buttonBright11;
int buttonBright12;
int buttonBright13;
int buttonBright14;
int buttonBright15;
int buttonDark = 60;
int buttonLight = 100;

int velocity;
int velMin = 80;
int velMax = 127;

//on off for sequencer
/*
boolean beat00 = true;
boolean beat01 = true;
boolean beat02 = true;
boolean beat03 = true;
boolean beat04 = true;
boolean beat05 = true;
boolean beat06 = true;
boolean beat07 = true;
boolean beat08 = true;
boolean beat09 = true;
boolean beat10 = true;
boolean beat11 = true;
boolean beat12 = true;
boolean beat13 = true;
boolean beat14 = true;
boolean beat15 = true;
*/

boolean beat00 = false;
boolean beat01 = false;
boolean beat02 = false;
boolean beat03 = false;
boolean beat04 = false;
boolean beat05 = false;
boolean beat06 = false;
boolean beat07 = false;
boolean beat08 = false;
boolean beat09 = false;
boolean beat10 = false;
boolean beat11 = false;
boolean beat12 = false;
boolean beat13 = false;
boolean beat14 = false;
boolean beat15 = false;

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
  strokeWeight(5);

  /*
  //draw buttons
   //button 00
   stroke(buttonHue1, buttonSat, buttonDark);
   fill(buttonHue1, buttonSat, buttonBright);
   rect(buttonX1, buttonY, buttonW, buttonH);
   
   //button 01
   
   rect(buttonX1+buttonW*2, buttonY, buttonW, buttonH);
   */


  int steps = 16;
  int scaleNotes = 8;


  for (int i = 0; i < steps; i++) {
    //    velocity = (int)random(70, 127);

    //notes
    //buttonX = buttonX1+buttonW*(i+1);

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
  int velocity = (int)random(85, 127);

  Note note = new Note(0, midiNote, velocity);
  myBus.sendNoteOn(note);
  delay(400); //this is an initial, dirty way of doing this!
  myBus.sendNoteOff(note);
}


void checkStep(int stepNumb) {
  buttonX = buttonX1+(buttonW*(stepNumb+1));
  int buttonSpace = buttonW * (stepNumb -1);


  if (stepNumb == 0) {

    if (beat00 == false) {
      velocity = 0;
      buttonBright00 = buttonDark;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright00);
      rect(buttonX1, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright00 = buttonLight;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright00);
      rect(buttonX1, buttonY, buttonW, buttonH);
    }
  }

  if (stepNumb == 1) {

    if (beat01 == false) {
      velocity = 0;
      buttonBright01 = buttonDark;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright01);
      rect(buttonX, buttonY, buttonW, buttonH);
      //      rect(buttonX1+buttonW*(stepNumb+1), buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright01 = buttonLight;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright01);
      rect(buttonX, buttonY, buttonW, buttonH);
      //      rect(buttonX1+buttonW*2, buttonY, buttonW, buttonH);
    }
  }

  if (stepNumb == 2) {
    if (beat02 == false) {
      velocity = 0;
      buttonBright02 = buttonDark;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright02);
      //      rect(buttonX+buttonW, buttonY, buttonW, buttonH);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright02 = buttonLight;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright02);
      //      rect(buttonX+buttonW, buttonY, buttonW, buttonH);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }

  if (stepNumb == 3) {
    if (beat03 == false) {
      velocity = 0;
      buttonBright03 = buttonDark;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright03);
      //      rect(buttonX+buttonW*2, buttonY, buttonW, buttonH);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright03 = buttonLight;
      stroke(buttonHue1, buttonSat, buttonDark);
      fill(buttonHue1, buttonSat, buttonBright03);
      //      rect(buttonX+buttonW*2, buttonY, buttonW, buttonH);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  

  if (stepNumb == 4) {
    if (beat04 == false) {
      velocity = 0;
      buttonBright04 = buttonDark;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright04);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright04 = buttonLight;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright04);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 5) {
    if (beat05 == false) {
      velocity = 0;
      buttonBright05 = buttonDark;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright05);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright05 = buttonLight;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright05);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 6) {
    if (beat06 == false) {
      velocity = 0;
      buttonBright06 = buttonDark;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright06);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright06 = buttonLight;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright06);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 7) {
    if (beat07 == false) {
      velocity = 0;
      buttonBright07 = buttonDark;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright07);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright07 = buttonLight;
      stroke(buttonHue2, buttonSat, buttonDark);
      fill(buttonHue2, buttonSat, buttonBright07);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 8) {
    if (beat08 == false) {
      velocity = 0;
      buttonBright08 = buttonDark;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright08);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright08 = buttonLight;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright08);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 9) {
    if (beat09 == false) {
      velocity = 0;
      buttonBright09 = buttonDark;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright09);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright09 = buttonLight;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright09);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  

  if (stepNumb == 10) {
    if (beat10 == false) {
      velocity = 0;
      buttonBright10 = buttonDark;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright10);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright10 = buttonLight;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright10);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 11) {
    if (beat11 == false) {
      velocity = 0;
      buttonBright11 = buttonDark;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright11);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright11 = buttonLight;
      stroke(buttonHue3, buttonSat, buttonDark);
      fill(buttonHue3, buttonSat, buttonBright11);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 12) {
    if (beat12 == false) {
      velocity = 0;
      buttonBright12 = buttonDark;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright12);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright12 = buttonLight;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright12);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 13) {
    if (beat13 == false) {
      velocity = 0;
      buttonBright13 = buttonDark;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright13);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright13 = buttonLight;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright13);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 14) {
    if (beat14 == false) {
      velocity = 0;
      buttonBright14 = buttonDark;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright14);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright14 = buttonLight;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright14);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    }
  }  
  if (stepNumb == 15) {
    if (beat15 == false) {
      velocity = 0;
      buttonBright14 = buttonDark;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright14);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
    } 
    else {
      velocity = (int)random(velMin, velMax);
      buttonBright14 = buttonLight;
      stroke(buttonHue4, 0, buttonDark);
      fill(buttonHue4, 0, buttonBright14);
      rect(buttonX+buttonSpace, buttonY, buttonW, buttonH);
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

