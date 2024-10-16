float[] x, y, d;
int N = 10;

void setup () {
  size(400, 200);
  x = new float[N];
  y = new float[N];
  d = new float[N];
  for (int i = 0; i < N; i++) {
    x[i] = 0;
    y[i] = (float)i * height / N;
    d[i] = 20;
  }
}

void draw() {
  background(255);
  fill(255, 50);
  for (int i = 0; i < N; i++) {
    ellipse(x[i], y[i], d[i], d[i]);
    if (x[i] < mouseX) {
      x[i] += random(-1, 2);
    } else {
      x[i] -= random(-1, 2);
    }
    if (y[i] < mouseY) {
      y[i] += random(-1, 2);
    } else {
      y[i] -= random(-1, 2);
    }
  }
}
