import beads.*;
import org.jaudiolibs.beads.*;
import java.util.Arrays;
import ddf.minim.*;

float beatLength;

int x, y, w, h;
PFont f;

int bpm; 
Clock clock;
int beatsPerMeasure;
int stepUnit = 4;

int currentMeasure;
int currentBeat; 
float howFarInMeasure;

int step = 0;

int hue = 5;

AudioContext ac;

Minim minim;
AudioSample kick;
AudioSample snare;
AudioSample hatClosed;
AudioSample c1Note;
AudioSample dNote;
AudioSample eNote;
AudioSample fNote;
AudioSample gNote;
AudioSample aNote;
AudioSample bNote;
AudioSample c2Note;

WavePlayer wp;
Gain g;

boolean hatClosedOn = true;
boolean kickOn = true;

void setup() {

  ac = new AudioContext();
  bpm = 120;

  beatsPerMeasure = 16;

  beatLength = 60000.0/(bpm*stepUnit);
  clock = new Clock(ac, beatLength); 
  clock.setClick(true); 
  clock.addMessageListener(
  new Bead() {
    public void messageReceived(Bead message) {
      Clock c = (Clock)message;
      onClock(c);
    }
  }
  );
  ac.out.addDependent(clock);
  ac.start();

  //interface
  size(400, 200);
  x = 20;
  y = 20;
  w = width - 40;
  h = height - 40;
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);

  minim = new Minim(this);

  loadSamples();

  colorMode(HSB, 100, 100, 100);
}

void draw() {
  background(50);

  pushMatrix();
  translate(x, y);

  noFill();
  stroke(100);
  rect(0, 0, w, h);

  float beatWidth = w/(float)beatsPerMeasure;

  //draw grid lines
  for (int i = 0; i < beatsPerMeasure; i++) {
    stroke(100);
    float beatPos = beatWidth * i;
    line(beatPos, 0, beatPos, h);

    text(i+1, beatPos, -2);

    if (i == currentBeat) {

      fill(hue*i, 100, 100);
      noStroke();
      float currentBeat_x = currentBeat * beatWidth;
      rect(currentBeat_x, 0, beatWidth, h);
    }
    if (currentMeasure > 0) {
      currentMeasure = 0;
    }
  }   

  popMatrix();
}

void onClock(Clock c) {
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;

  //calculate how many ticks are in a measure
  float ticksPerMeasure = beatsPerMeasure * c.getTicksPerBeat();
  //get a number between 0 and 1 to tell us how far we are
  howFarInMeasure = (c.getCount()%ticksPerMeasure)/ticksPerMeasure;

  //  kickOn = true;
  //  if (c.isBeat()) {
  //    playKick();
  //    //playHat();
  //  }

  if (c.isBeat()) {
    playLowNote();
    playMidNote();
    playHiNote();
  }
}

void playHat() {
  hatClosed.trigger();
}

void playKick() {
  if (kickOn) {
    if (currentBeat == 0) {
      c1Note.trigger();
    }
  }
}

void playLowNote() {
  if (currentBeat == 0) {
    c1Note.trigger();
  }
}

void playMidNote() {
  if (currentBeat == 0) {
    eNote.trigger();
  }
}
void playHiNote() {
  if (currentBeat == 0) {
    gNote.trigger();
  }
}

void loadSamples() {
  kick = minim.loadSample("707 Kick 1.wav", 512);
  if ( kick == null ) println("Didn't get kick!");

  snare = minim.loadSample("707 Snare 1.wav", 512);
  if ( snare == null ) println("Didn't get snare!");

  hatClosed = minim.loadSample("707 Hat_closed.wav", 512);
  if ( hatClosed == null ) println("Didn't get closed hat!");

  c1Note = minim.loadSample("C1.wav", 512);
  if ( c1Note == null ) println("Didn't get C1!");

  dNote = minim.loadSample("D.wav", 512);
  if ( dNote == null ) println("Didn't get the D!");

  eNote = minim.loadSample("E.wav", 512);
  if ( eNote == null ) println("Didn't get E!");

  fNote = minim.loadSample("F.wav", 512);
  if ( fNote == null ) println("Didn't get F!");

  gNote = minim.loadSample("G.wav", 512);
  if ( gNote == null ) println("Didn't get G!");

  aNote = minim.loadSample("A.wav", 512);
  if ( aNote == null ) println("Didn't get A!");

  bNote = minim.loadSample("B.wav", 512);
  if ( bNote == null ) println("Didn't get B!");

  c2Note = minim.loadSample("C2.wav", 512);
  if ( c2Note == null ) println("Didn't get C2!");
}

