import beads.*;
import java.util.Arrays;
import ddf.minim.*;

Minim minim;
AudioSample kick;
AudioSample snare;

AudioContext ac;
int pitch;
boolean isBeat;
int beatsPerMeasure;
float beatLength;

int BPM;

int step = 1;

WavePlayer wp;
Gain g;

void setup() {  
  ac = new AudioContext();
  BPM = 140;
  beatsPerMeasure = 16;
  beatLength = 1.0/BPM*60*1000;
  Clock clock = new Clock(ac, beatLength);

  minim = new Minim(this);

  kick = minim.loadSample("707 Kick 1.wav", 512);

  if ( kick == null ) println("Didn't get kick!");

  snare = minim.loadSample("707 Snare 1.wav", 512);
  if ( snare == null ) println("Didn't get snare!");


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

    /*
    if (step >= beatLength) {
     step = 0;
     } else {
     step = step+1;
     }
     */
    step = step +1;


    isBeat = false;
  }
  //  if (step > 15){
  //  step = 0;
  //  }
  countSteps();
  println(step);
}

void onClock(Clock c) {   
  if (c.isBeat()) {      
    //pitch = Pitch.forceToScale((int)random(60, 70), Pitch.dorian, 12);
    //float freq = Pitch.mtof(pitch);

    kick.trigger();
    /*
    WavePlayer wp = new WavePlayer(ac, freq, Buffer.SINE);
     Gain g = new Gain(ac, 1, new Envelope(ac, 0));
     g.addInput(wp);
     ac.out.addInput(g);
     ((Envelope)g.getGainEnvelope()).addSegment(0.1, 100);
     ((Envelope)g.getGainEnvelope()).addSegment(0.1, beatLength - 200);
     ((Envelope)g.getGainEnvelope()).addSegment(0, 100, new KillTrigger(g));
     */
    isBeat = true;
    //    countSteps(step);
  }
}

void countSteps() {
  if (step > beatsPerMeasure) {
    step = 1;
  }
}

