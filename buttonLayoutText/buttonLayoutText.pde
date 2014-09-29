int squares = 16;
float x;

void setup() {
  size(1000, 800);
  fill(0,255,180);
  int y = height/2;
  int w = width/(squares*2);
  int h = 100;
  pushMatrix();
  translate(w/2, 0);
  for (int i = 0; i < squares; i++) {
    x = w*2*i;
    rect(x, y, w, h);
  }
  popMatrix();
}

void draw() {
}

