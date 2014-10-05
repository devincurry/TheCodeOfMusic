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
//AudioSample hatOpen;
//AudioSample crash;
//AudioSample clap;
//AudioSample rimshot;

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
      playHat();
      //hatClosed.trigger();
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

  //  kick = minim.loadSample("707 Kick 1.wav", 512);
  //  if ( kick == null ) println("Didn't get kick!");
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

    //now let's label them:
    //    text((currentMeasure+1) + "." + i, beatPos, -2);
    text(i+1, beatPos, -2);

    //text(beatLength*i/1000 + "s", beatPos, h + 10); 


    //highlight current beat       
    if (i == currentBeat) {

      fill(hue*i, 100, 100);
      noStroke();
      float currentBeat_x = currentBeat * beatWidth;
      rect(currentBeat_x, 0, beatWidth, h);
      //      hatClosed.trigger();
    }
    if (currentMeasure > 0) {
      currentMeasure = 0;
      //playHat();
    }
    //playHat();
    //playKick();
  }   
  /*
  //draw playhead
   //see how 'howFarInMeasure' (a number between 0 and 1) is calculated in the onClock function below.
   stroke(219, 38, 118);
   float playheadPos = map((float)howFarInMeasure, 0, 1, 0, w);
   line(playheadPos, 0, playheadPos, h);
   
   //  for (int j = 0; j < beatWidth; i++){
   //  if (playheadPos == curr){
   //      hatClosed.trigger();
   //  }
   */
  popMatrix();
}

void onClock(Clock c) {
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;

  //calculate how many ticks are in a measure
  float ticksPerMeasure = beatsPerMeasure * c.getTicksPerBeat();
  //get a number between 0 and 1 to tell us how far we are
  howFarInMeasure = (c.getCount()%ticksPerMeasure)/ticksPerMeasure;
  //playHat();
  kickOn = true;
  playKick();
}

void playHat() {
  if (currentBeat < beatsPerMeasure && hatClosedOn) {
    hatClosed.trigger();
    hatClosedOn = !hatClosedOn;
    /*
  if (step == currentBeat && hatClosedOn) {
     hatClosed.trigger();
     hatClosedOn = !hatClosedOn;
     step = step + 1;
     
     if (step > beatsPerMeasure) {
     step = 0;
     } else {
     step = step+1;
     }
     */
    //hatClosedOn = !hatClosedOn;
  } else {
    hatClosedOn = !hatClosedOn;
  }
}

void playKick() {
  //  kickOn = true;
  if (kickOn) {
    if (currentBeat == 0 || currentBeat == 4 || currentBeat == 8 || currentBeat == 12) {
      kick.trigger();
      kickOn = !kickOn;
      //    } else {
      //      kickOn = false;
      //    }
    }
  }
}

void loadSamples() {
  kick = minim.loadSample("707 Kick 1.wav", 512);
  if ( kick == null ) println("Didn't get kick!");

  snare = minim.loadSample("707 Snare 1.wav", 512);
  if ( snare == null ) println("Didn't get snare!");

  hatClosed = minim.loadSample("707 Hat_closed.wav", 512);
  if ( hatClosed == null ) println("Didn't get closed hat!");
}

