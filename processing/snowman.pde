float speed = 350.0;

void setup() {
  size(400, 400, P3D);
}

void draw() {
  background(255);
  noStroke();
  lights();
  float kakudoH = 360.0*((float)mouseX/width-0.5);
  float kakudoV = 180.0*((float)mouseY/height-0.5);
  float dx = speed * sin(radians(kakudoH));
  float dy = speed * sin(radians(kakudoV));
  float dz = -speed * cos(radians(kakudoH));
  camera(200+dx, 200+dy, dz,  200, 200, 0, 0, 1, 0);
  
  pushMatrix();
  translate(220, 160);
  rotateZ(60);
  fill(255, 0, 0); 
  box(50, 50, 50);
  popMatrix();
  
  pushMatrix();
  translate(200, 200);
  fill(255);
  sphere(40);
  popMatrix();
  
  pushMatrix();
  translate(200, 280);
  fill(255);
  sphere(60);
  popMatrix();
  
  pushMatrix();
  translate(260, 250);
  rotateY(radians(250));
  rotateX(100);
  fill(139, 69, 19); 
  box(10, 10, 70);
  popMatrix();
  
  pushMatrix();
  translate(140, 250);
  rotateY(radians(100));
  rotateX(100);
  fill(139, 69, 19); 
  box(10, 10, 70);
  popMatrix();
}
  
