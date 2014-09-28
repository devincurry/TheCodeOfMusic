PImage logo;

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

boolean kickOn = true;
boolean fouronthefloor = false;
boolean snareOn = true;
boolean hatClosedOn = true;
boolean clapOn = true;
boolean crashOn = true;
boolean rimshotOn = true;

WavePlayer wp;
Gain g;

//int buttonW = 80;
//int buttonH = 150;
int buttonW;
int buttonH;
float buttonY;
int buttons = 6; //how many buttons are there?
int buttonHue = 0;
int buttonLt = 100;
int buttonDk = 50;

void setup() {
  size (800, 800);
  colorMode(HSB, 100, 100, 100);
  background(0, 0, 100);
  noStroke();
  logo = loadImage("ocplogo.jpg");
  image(logo, 0, 0);

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

  if (isBeat) {
    //    background(0);
    //background(random (0, 255));
    int side = (int)random(10, 40);
    int x = (int)random(0, width);
    int y = (int)map(pitch, 60, 70, height, 0);
    //rect(x, y, side, side);

    //step = step + 1;
    //countSteps();
    isBeat = false;
  }
  countSteps();
  //kickDrum();
  println(step);
}

void drawButtons() {
  buttonW = width/(buttons*2);
  buttonH = height/8;
  buttonY = height/4;
  float buttonSpace = buttonW;

  if (kickOn) {
    fill(buttonHue, 100, buttonLt);
    rect (width/(buttons*2), buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect (width/(buttons*2), buttonY, buttonW, buttonH);
  }

  if (snareOn) {
    fill(buttonHue, 100, buttonLt);
    rect (width/(buttons*2)*2+buttonSpace, buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect (width/(buttons*2)*2+buttonSpace, buttonY, buttonW, buttonH);
  }

  if (hatClosedOn) {
    fill(buttonHue, 100, buttonLt);
    rect ((width/(buttons*2)*4)+buttonSpace, buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect ((width/(buttons*2)*4)+buttonSpace, buttonY, buttonW, buttonH);
  }

  if (clapOn) {
    fill(buttonHue, 100, buttonLt);
    rect (width/(buttons*2)*6+buttonSpace, buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect (width/(buttons*2)*6+buttonSpace, buttonY, buttonW, buttonH);
  }

  if (crashOn) {
    fill(buttonHue, 100, buttonLt);
    rect (width/(buttons*2)*8+buttonSpace, buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect (width/(buttons*2)*8+buttonSpace, buttonY, buttonW, buttonH);
  }

  if (rimshotOn) {
    fill(buttonHue, 100, buttonLt);
    rect (width/(buttons*2)*10+buttonSpace, buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect (width/(buttons*2)*10+buttonSpace, buttonY, buttonW, buttonH);
  }
/*
  if (rimshotOn) {
    fill(buttonHue, 100, buttonLt);
    rect (width/(buttons*2)*8+buttonW, buttonY, buttonW, buttonH);
  } else {
    fill(buttonHue, 100, buttonDk);
    rect (width/(buttons*2)*8+buttonW, buttonY, buttonW, buttonH);
  }
  */
}



void onClock(Clock c) {   
  if (c.isBeat()) { 

    if (kickOn) {
      if (fouronthefloor) {
        playKick1();
      } else {
        playKick2();
      }
    } else {
    }

    if (snareOn) {  
      playSnare();
    } else {
    }

    if (hatClosedOn) {
      playHatClosed();
    } else {
    }

    if (clapOn) {
      playClap();
    } else {
    }

    if (crashOn) {
      playCrash();
    } else {
    }

    if (rimshotOn) {
      playRimshot();
    } else {
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
    int y = (int) random(0, 99);
    if (y < 20) {
      kick.trigger();
    }
  }
}

void playSnare() {
  if (step == 5 || step == 13) {
    snare.trigger();
  }
  int z = (int) random(0, 99);
  if (step == 14 || step == 15 || step == 16) {
    if (z < 30) {
      snare.trigger();
    }
  }
}

void playHatClosed() {
  int a = (int) random(0, 99);
  if (a < 70) {
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

void playCrash() {
  if (step == 1) {
    int f = (int) random(0, 99);
    if (f < 20) {
      crash.trigger();
    } else {
    }
  }
}

void playRimshot() {
  int g = (int) random (0, 99);
  if (g < 40) {
    rimshot.trigger();
  } else {
  }
}

