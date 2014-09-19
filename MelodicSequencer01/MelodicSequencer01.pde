import themidibus.*;
MidiBus myBus;

int lastBeat;
float beatLength;
float seqW = 800;
float seqH = 800;

//on off for sequencer
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


int [][] stepArray = { {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72},
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72}, 
  {60, 62, 64, 65, 67, 69, 71, 72} };
  

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
    int j = (int) random(0, stepArray[i].length - 1);
    Note note = new Note(0, stepArray[i][j], 127);
    myBus.sendNoteOn(note);
    delay(400); //this is an initial, dirty way of doing this!
    myBus.sendNoteOff(note);
    println (i,j);

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

void exit() {
  println("stop");
  for (int i = 0; i < 127; i++) {
    myBus.sendNoteOff(new Note(0, i, 0));
  }
  super.exit();
}

