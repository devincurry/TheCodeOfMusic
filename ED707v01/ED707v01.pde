import beads.*;
import java.util.Arrays;
import ddf.minim.*;

Minim minim;
AudioSample kick;
AudioSample snare;
AudioSample hatClosed;
AudioSample hatOpen;
AudioSample crash;
AudioSample clap;
AudioSample rimshot;

AudioContext ac;
int pitch;
boolean isBeat;
int beatsPerMeasure = 4;
int beatsPerBar = beatsPerMeasure*4;

float beatLength;

int BPM;

int step = 1;

WavePlayer wp;
Gain g;

void setup() {  
  ac = new AudioContext();
  BPM = 320;
  //beatsPerMeasure = 4;
  //beatsPerBar = 16;
  beatLength = 1.0/BPM*60*1000;
  Clock clock = new Clock(ac, beatLength);

  minim = new Minim(this);

  kick = minim.loadSample("707 Kick 1.wav", 512);
  if ( kick == null ) println("Didn't get kick!");

  snare = minim.loadSample("707 Snare 1.wav", 512);
  if ( snare == null ) println("Didn't get snare!");

  hatClosed = minim.loadSample("707 Hat_closed.wav", 512);
  if ( hatClosed == null ) println("Didn't get closed hat!");

  hatOpen = minim.loadSample("707 Hat_open.wav", 512);
  if ( hatOpen == null ) println("Didn't get open hat!");

  crash = minim.loadSample("707 Crash.wav", 512);
  if ( crash == null ) println("Didn't get crash!");

  clap = minim.loadSample("707 Clap.wav", 512);
  if ( clap == null ) println("Didn't get the clap!");

  rimshot = minim.loadSample("707 Rimshot.wav", 512);
  if ( rimshot == null ) println("Didn't get rimshot!");

  clock.addMessageListener(
  new Bead() {    
    public void messageReceived(Bead message) { //This is equivalent to 'onBeat' in our previous example
      Clock c = (Clock)message;
      onClock(c);
    }
  }

  ); 
  ac.out.addDependent(clock);
  ac.start();
}

void draw() {
  if (isBeat) {
    background(0);
    int side = (int)random(10, 40);
    int x = (int)random(0, width);
    int y = (int)map(pitch, 60, 70, height, 0);
    rect(x, y, side, side);

    step = step +1;
    //countSteps();
    isBeat = false;
  }
  countSteps();
  //kickDrum();
  println(step);
}

void onClock(Clock c) {   
  if (c.isBeat()) {      
    playKick();
    playSnare();
    playHatClosed();
    playClap();
    isBeat = true;
  }
}

void countSteps() {
  if (step > beatsPerBar) {
    step = 1;
  }
}

void playKick() {
  if (step == 1 || step == 5 || step == 9 || step == 13) {
    kick.trigger();
  }
}

void playSnare() {
  if (step == 5 || step == 13) {
    snare.trigger();
  }
}

void playHatClosed() {
  int a = (int) random(0, 99);
  if (a < 50) {
    hatClosed.trigger();
  } else {
  }
}

void playClap() {
  if (step == 5) {
    int b = (int) random(0, 99);
    if (b < 80) {
      clap.trigger();
    } else {
    }
  }
  if (step == 8) {
    int c = (int) random(0, 99);
    if (c < 50) {
      clap.trigger();
    } else {
    }
  }
  if (step == 13) {
    int d = (int) random(0, 99);
    if (d < 90) {
      clap.trigger();
    } else {
    }
  }
    if (step == 15) {
    int e = (int) random(0, 99);
    if (e < 70) {
      clap.trigger();
    } else {
    }
  }
}

