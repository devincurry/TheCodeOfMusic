PImage logo;
PFont font;

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

boolean kickOn = false;
boolean fouronthefloor = false;
boolean snareOn = false;
boolean hatClosedOn = false;
boolean clapOn = false;
boolean crashOn = false;
boolean rimshotOn = false;

WavePlayer wp;
Gain g;

int buttonW;
int buttonH;
float buttonY;
int buttons = 6; //how many buttons are there?
int buttonHue = 0;
int buttonLt = 100;
int buttonDk = 50;

int textX;
int textY;
int textHeight = 36;

void setup() {
  size (800, 800);
  colorMode(HSB, 100, 100, 100);
  background(0, 0, 100);
  noStroke();
  logo = loadImage("ocplogo.jpg");  
  image(logo, 0, 0);

  textX = width/4;
  textY = height/2;
  fill(0, 0, 0);
  font = loadFont("PerfectDOSVGA437-48.vlw");
  textFont(font, 36);
  textAlign(LEFT);
  text("Press the number keys!", textX, textY);
  text(" ", textX, textY + textHeight);
  text("1 = Kick", textX, textY + (textHeight*2));
  text("2 = Snare", textX, textY + (textHeight*3));
  text("3 = Closed Hi Hat", textX, textY + (textHeight*4));
  text("4 = Handclap", textX, textY + (textHeight*5));
  text("5 = Crash", textX, textY + (textHeight*6));
  text("6 = Rimshot", textX, textY + (textHeight*7));
  text("0 = Four On The Floor!", textX, textY + (textHeight*8));

  ac = new AudioContext();
  BPM = 420;
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
  image(logo, 0, 0);
  drawButtons();
  fill(0, 0, 100);
  rect(width-300, 0, 300, 130);
  fill(0, 100, 100);
  text("STEP", width-170, 110);
  text(step, width-80, 110);

  if (isBeat) {
    int side = (int)random(10, 40);
    int x = (int)random(0, width);
    int y = (int)map(pitch, 60, 70, height, 0);
    isBeat = false;
  }
  countSteps();
}

void drawButtons() {
  int buttonX = width/(buttons*2);
  buttonW = width/(buttons*2);
  buttonH = height/8;
  buttonY = height/4;
  float buttonSpace = buttonW/2;

  pushMatrix();
  translate(buttonSpace, 0);

  fill(buttonHue, 100, kickOn ? buttonLt : buttonDk);
  rect (buttonX*0, buttonY, buttonW, buttonH);

  fill(buttonHue, 100, snareOn ? buttonLt : buttonDk);
  rect (buttonX*2, buttonY, buttonW, buttonH);

  fill(buttonHue, 100, hatClosedOn ? buttonLt : buttonDk);
  rect (buttonX*4, buttonY, buttonW, buttonH);

  fill(buttonHue, 100, clapOn ? buttonLt : buttonDk);
  rect (buttonX*6, buttonY, buttonW, buttonH);

  fill(buttonHue, 100, crashOn ? buttonLt : buttonDk);
  rect (buttonX*8, buttonY, buttonW, buttonH);

  fill(buttonHue, 100, rimshotOn ? buttonLt : buttonDk);
  rect (buttonX*10, buttonY, buttonW, buttonH);

  popMatrix();

  if (fouronthefloor) {
    fill(0, 100, 100);
    textAlign(CENTER);
    textFont(font, 48);

    text("FOUR ON THE FLOOR IN EFFECT!", width/2, height-height/14);
  } else {
    fill(0, 0, 100);
    textAlign(CENTER);
    textFont(font, 48);

    text("FOUR ON THE FLOOR IN EFFECT!", width/2, height-height/14);
  }
}

void onClock(Clock c) {   
  if (c.isBeat()) { 

    if (kickOn) {
      if (fouronthefloor) {
        playKick1();
      } else {
        playKick2();
      }
    }

    if (snareOn) {  
      playSnare();
    }

    if (hatClosedOn) {
      playHatClosed();
    }

    if (clapOn) {
      playClap();
    }

    if (crashOn) {
      playCrash();
    }

    if (rimshotOn) {
      playRimshot();
    }

    isBeat = true;
    step = step + 1;
  }
}

void countSteps() {
  if (step > beatsPerBar) {
    step = 1;
  }
}

void playKick1() {
  if (step == 1 || step == 5 || step == 9 || step == 13) {
    kick.trigger();
  }
}

void playKick2() {
  if (step == 1 || step == 9 || step == 13) {
    kick.trigger();
  }
  if (step == 4 || step == 12 || step == 16) {
    if (random(0,1) < .2) {
      kick.trigger();
    }
  }
}

void playSnare() {
  if (step == 5 || step == 13) {
    snare.trigger();
  }
  if (step == 14 || step == 15 || step == 16) {
    if (random(0,1) < .3) {
      snare.trigger();
    }
  }
}

void playHatClosed() {
  if (random(0,1) < .7) {
    hatClosed.trigger();
  }
}

void playClap() {
  if (step == 5) {
    if (random(0,1) < .8) {
      clap.trigger();
    }
  }
  if (step == 8) {
    if (random(0,1) < .5) {
      clap.trigger();
    }
  }
  if (step == 13) {
    if (random(0,1) < .9) {
      clap.trigger();
    }
  }
  if (step == 15) {
    if (random(0,1) < .7) {
      clap.trigger();
    }
  }
}

void playCrash() {
  if (step == 1) {
    if (random(0,1) < .25) {
      crash.trigger();
    }
  }
}

void playRimshot() {
  if (random(0,1) < .4) {
    rimshot.trigger();
  }
}

void keyPressed() {
  if ( key == '1' ) {
    kickOn = !kickOn;
  }

  if (key == '2' ) {
    snareOn = !snareOn;
  }

  if (key == '3' ) {
    hatClosedOn = !hatClosedOn;
  }

  if (key == '4' ) {
    clapOn = !clapOn;
  }

  if (key == '5' ) {
    crashOn = !crashOn;
  }

  if (key == '6' ) {
    rimshotOn = !rimshotOn;
  }

  if (key == '0' ) {
    fouronthefloor = !fouronthefloor;
  }
}

class Instrument {
  float x, y, w, h;
  AudioSample sound;
  boolean playing;

  Instrument(String soundfile, float _x, float _y) {
    x = _x;
    y = _y;
    playing = false;
    sound = minim.loadSample(soundfile, 512);
  }

  void toggle() {
    playing = !playing;
  }

  void go() {
    if (playing) {
      sound.trigger();
    }
  }
}

