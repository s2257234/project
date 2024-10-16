/*ゲーム遷移の画面、的の動き、的の色が戻る、壁の反射、
   制限時間の表示の処理を加えました。*/

int score = 0;
int time = 30;
boolean gameStatus = false;

class Ball {
     float x;
     float y;
     float size;
     float red = 255;
     float green = 255;
     float blue = 0;
     float vx;
     float vy;
     
     
     Ball(float initX, float initY, float initSize, float initVx, float initVy) {
       x = initX;  y = initY;  size = initSize;
       vx = initVx; vy = initVy;
     }
     
     void show() {
       fill(red, green, blue);
       ellipse(x, y, size, size);
    }
     
     void update() {
       
       x += vx;
       y += vy;
       
       if (y - size/2 < 0 || y + size/2 > height) {  //壁に当たったら反射させる
         vy = -vy;
       }
     }
  }

class Target {
  float x;
  float y;
  float size;
  float red = 255;
  float green = 0;
  float blue = 0;
  float speed = 3;
  int colorbacktime = 0;  //  的にボールが当たってから色が変わるまでの時間
  float theta = random(0, TWO_PI); //的の角度
  

  Target(float initX, float initY, float initSize) {
    x = initX;
    y = initY;
    size = initSize;
  }
  
  void update(Ball ball) {
    float d = dist(ball.x, ball.y, x, y);

    if (d < (ball.size / 2 + size / 2)) {
      red = 0;
      blue = 255;
      score += 1;
      colorbacktime = 60; //色が戻るまでの時間
    }
    
    if (colorbacktime > 0) {
      colorbacktime--;
    } else{
      red = 255;
      blue = 0;
    }
    y = 200 + 100 * sin(0.05 * x + theta);
    x += speed;
    if(x < 150 || x > 550) {
      speed = -speed;
      x = random(150, 550);//的をxが150～550の間でランダムに移動する
      speed = random(1, 5);  //的のスピードをランダムに変える
    }
    
  }

  void show() {
    fill(red, green, blue);
    ellipse(x, y, size, size);
  }
}

ArrayList<Ball> balls = new ArrayList<Ball>();
 Ball ball = new Ball(50, 200, 30, 1, 0);
 Target[] targets = new Target[9];

void setup() {
  size(600, 400);
  frameRate(30);
  
  for (int i = 0; i < targets.length; i++) {
    targets[i] = new Target(350, 50 + i * 40, 10);
  }
  
}

  void GameScreen() {
    ball.update();
    ball.show();
  }
  void draw() {
  background(255);
 for(int i = 0; i < targets.length; i++){
   targets[i].update(ball);
   targets[i].show();
 }
 
 fill(0);
 textSize(32);
 text("Score: " + score, 24, 24);
 text("Limit: " + time, 24, 50); //制限時間の表示
 
   if(frameCount % 30 == 0 && time > 0) {
     time --;
   
 }
 
 if(time == 0) { 
   background(255);
   text("Game Finish", width/2 - 50, height/2);
   fill(255, 0, 0);
   text("Score: " + score, width/2 - 50, height/2 - 50);
   noLoop();
 }
 
 if(gameStatus == false) {
   gameStarted();
 }else {
   GameScreen();
 }
}

void gameStarted() {
  background(255);
  textSize(32);
  fill(255, 0, 0);
  text("Click Game Start", width/2-100, height/2);
}

void mousePressed() {
  float vx = mouseX - 50;
  float vy = mouseY - 200;
  float r = 1 / sqrt(vx * vx + vy * vy); 
  ball = new Ball(50, 200, 30, vx * r * 12, vy * r * 12);
  gameStatus = true;
}
