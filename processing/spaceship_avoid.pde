/*追加要素1：マウスをクリックしたら、宇宙船からビームが発射される。
ビームは徐々に伸びていき、隕石に当たると最初の長さに戻る。
追加要素2：黄色のアイテムが出現し、当たると残り時間が増加する。*/

////////////////////////////
// 宇宙船(プレーヤー)のクラス
class Player {
  float x, y, speed; // 宇宙船の x と y 座標、移動スピード
  int shield; // 宇宙船のシールド数
  boolean invincibleStatus;// 無敵モードの状態
  int invincibleTime = 5000; // ミリ秒単位で無敵状態が続く時間
  float invincibleStartTime;// 無敵モード開始時間
  boolean meteoVisible = true; // 隕石の表示状態
  boolean beam = false; //ビームを表示
  float beamlength = 30; //ビームの長さ
  // ----- new 命令が実行されたときに呼ばれる関数
  Player() {
    x = 50; // 初期位置(x)
    y = height / 2; // 初期位置(y) 画面の高さの半分
    speed = 10; // 移動スピード
    resetSpaceship(); // 宇宙船の初期化手続きを別途定義し、呼び出す形とする
  }

  // ----- 宇宙船の各変数を初期化する手続きを new 命令から独立させる
  void resetSpaceship() { // 教科書では reset()としている
    x = 50; // 初期位置(x)
    y = height / 2; // 初期位置(y)
    speed = 10; // 移動スピード
    shield = 10; // シールド数
    invincibleStatus = false; // 無敵モードをリセット
  }

  // ----- 宇宙船を描く
  void drawSpaceship() { // 教科書では draw() としている
    pushMatrix();
    translate(x, y);
    stroke(0);
    if ( invincibleStatus == true ) { // 無敵モードの場合、色を青に
      fill(80, 80, 255);
    } else {
      fill(200);
    }
    triangle(0, 0, 60, 20, 3, 20);
    fill(50);
    rect(0, 10, 20, 6);
    popMatrix();

    // 画面上方にシールドの残数を描く
    for ( int i = 0; i < shield; i++ ) {
      fill(100, 255, 100);
      rect(width / 2 + 12 * i, 10, 10, 20);
    }
  }

  void updateSpaceship() { // 教科書では update() としている
    if (up == true && y-speed > 0) y -= speed;
    if (down == true && y+speed+20 < height) y += speed;
    if (left == true && x-speed > 0) x -= speed;
    if (right == true && x+speed+50 < width ) x += speed;
    if (invincibleStatus == true && invincibleStartTime + invincibleTime < millis() ) { // もし、無敵モードの時間を超過した場合
      invincibleStatus = false; // 無敵モードを解除
    }
  }
  // ----- 宇宙船に隕石が当たったかどうかの判定
  boolean hit(float tx, float ty, float tSize) {
    float r = tSize / 3.5; // 当たり判定の範囲を隕石の 3.5 分の 1 とする
    if (x < tx + r && tx - r < x + 60 && y < ty + r && ty - r < y + 20) {
      if (invincibleStatus == false) { // 無敵モードではない場合シールドを削減
        shield--;
        if (shield < 0) {
          status = 4;
        }
      }
      return true;
    } else {
      return false;
    }
  }
  // ----- 宇宙船にアイテムに接触したかどうかの判定
  boolean contact(float tx, float ty, float tSize) {
    float r = tSize / 3.5; // 当たり判定の範囲をアイテムの 3.5 分の 1 とする
    if (x < tx + r && tx - r < x + 60 &&
      y < ty + r && ty - r < y + 20) {
      return true;
    } else {
      return false;
    }
  }
  //// ----- ビームと隕石の当たり判定
  boolean beamHit(float bx, float by, float blength) {
   for (int i = 0; i < mN; i++) {
    if(bx < meteor[i].x + meteor[i].size && bx + blength > meteor[i].x && by < meteor[i].y + meteor[i].size && by > meteor[i].y) {
      meteor[i].resetMeteorite();//隕石をリセット
      return true;
       }
     }
  return false;
}

  void activateInvincible() {  // 無敵状態を有効化するメソッド
    invincibleStatus = true;
  }
  
  void drawBeam() {
    if (beam) {
      stroke(255, 0, 0); // ビームの色を赤に設定
      strokeWeight(3); // ビームの太さ
      line(x+20, y+10, x+20 + beamlength, y+10); // 宇宙船からビームを描く
    }
  }
  
  void shootBeam() {
    beam = true;
    beamlength = 100; // ビームの初期長さ
  }
  void updateBeam() {
    if (beam) {
      beamlength += 10; // ビームの長さを増加させる
      if (beamlength > width) {
        beam = false; // ビームが画面外に出たら無効にする
        beamlength = 30; // ビームの長さを初期化
      }
    }
  }
}

// ----- キーを押したときに呼ばれる関数
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP ) up = true;
    if (keyCode == DOWN ) down = true;
    if (keyCode == LEFT ) left = true;
    if (keyCode == RIGHT ) right = true;
  } 
}
  void mousePressed() {
      player.shootBeam(); //スペースキーでビームを発射
    
  }
  
// ----- キーを離したときに呼ばれる関数
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP ) up = false;
    if (keyCode == DOWN ) down = false;
    if (keyCode == LEFT ) left = false;
    if (keyCode == RIGHT ) right = false;
  }
}

/////////////
//隕石 1 個のクラス
class Meteorite {
  float x, y, speed, size; // 座標、移動速度、大きさ
  boolean crashed; // false=移動中の状態, true=宇宙船に衝突した状態

  // --- new 命令が実行されたときに呼ばれる関数
  Meteorite() {
    resetMeteorite();
  }

  // --- 隕石の各変数を初期化する
  void resetMeteorite() { // 教科書では reset() としている
    x = random(width, 2 * width); // 初期位置(x): 画面右端から画面外(画面サイズの 2 倍)の範囲
    y = random(height); //初期位置(y): 画面の上端から下端の範囲
    speed = random(2, 20); //移動スピード
    size = random(10, 30); //大きさ
    crashed = false; // 隕石の状態
    player.meteoVisible = true; // 隕石の表示状態
  }

  // --- 隕石を描く
  void drawMeteorite() { // 教科書では draw() としている
    if (player.meteoVisible) {
      stroke(0);
      fill(235, 130, 80);
      ellipse(x, y, size, size); // 隕石を描く
      if ( crashed == true ) { // 衝突状態ならば爆発を表す円を描く
        noStroke();
        fill(255, 255, 0, 100);
        ellipse(x+random(-20, 20), y+random(-20, 20), size, size);
        ellipse(x+random(-20, 20), y+random(-20, 20), size, size);
      }
    }
  }

  // --- 隕石の移動
  void updateMeteorite() { // 教科書では update() としている
    x -= speed; // 隕石を(speed)分だけ左に移動
    if ( x < -size ) resetMeteorite();//隕石の位置 x が左端に達したらリセット
    if ( crashed == false ) { // 隕石が衝突状態でなければ...
      crashed = player.hit(x, y, size); // プレーヤーとの衝突判定を行う
    } else { // 衝突状態の場合...
      if ( size > 0 ) { // 隕石の大きさが 0 より大きい場合...
        size -= 4; // 隕石の大きさを小さくする
      } else { // 隕石の大きさが 0 以下になったら...
        resetMeteorite(); // 隕石をリセット
      }
    }
  }
}

////////////
//// アイテムのクラス
class Item {
  float x, y, speed, size=10; // 座標、移動速度、大きさ
  int colorR, colorG, colorB; // アイテムの色(RGB)
  boolean contacted; // false=移動中の状態, true=宇宙船に接触した状態
  // 隕石では crashed としていたものを contacted に変更
  int counterToErase; // 接触時の描画を行う(非表示とするまでの)フレーム数
  boolean appeared; //// false=このアイテムが画面に出現していない
  // --- new 命令が実行されたときに呼ばれる関数
  Item() {
    resetItem();
  }
  // --- アイテムの各変数を初期化する
  void resetItem() {
    x = random(width, 2 * width); // 初期位置(x): 画面右端から画面外(画面サイズの 2 倍)の範囲
    y = random(height); // 初期位置(y): 画面の上端から下端の範囲
    speed = random(2, 20); // 移動スピード
    contacted = false; // アイテムの接触状態の初期値を非接触に設定
    appeared = false; // アイテムの出現状態の初期値を非出現に設定
    counterToErase = 5; // 接触後、非表示にするまでのフレーム数を設定
  }
  // --- アイテムを描く
  void drawItem() {
    if ( contacted == false ) { //アイテムが非接触の状態であればアイテムを描く
      stroke(0);
      fill(colorR, colorG, colorB);
      ellipse(x, y, size, size); // アイテムを描く
    } else { // 接触状態ならば接触したことを表す円を描く
      noStroke();
      fill(0, 255, 255, 100);
      ellipse(x, y, 6 * (5-counterToErase), 6 * (5-counterToErase));
    }
  }
  // --- アイテムの取得(接触した際の処理)
  void getItem() {
    // 汎用的なアイテムではアイテムを取得した際に何もしない
  }
  // --- アイテムの移動(更新)
  boolean updateItem() { // 更新後、アイテムが存在するかどうかを返す
    x -= speed; // アイテムを(speed)分だけ左に移動
    if ( x < -size ) {
      resetItem(); // アイテムの位置 x が左端に達したらリセットし、
      return false; // そのアイテムが無くなったことを返す
    }
    if ( contacted == false ) { // アイテムが接触状態でなければ...
      contacted = player.contact(x, y, size); // プレーヤーとの接触判定を行う
      if ( contacted == true ) { // プレーヤーと新たに接触した場合...
        getItem(); // アイテムを取得
      }
      return true; // アイテムが存在中であることを返す
    } else { // 接触状態の場合...
      if ( counterToErase > 0 ) { // 非表示までのカウンターが 0 より大きい場合...
        counterToErase--; // カウンターの値を 1 だけ小さくし、
        return true; // アイテムが存在中であることを返す
      } else { // カウンターの値が 0 以下になったら...
        resetItem(); // アイテムをリセットし、
        return false; // アイテムが無くなったことを返す
      }
    }
  }
}


////////////
//// アイテム 1(シールド)、1 個のクラス
class Item_1 extends Item { // 汎用的なアイテムを継承
  Item_1() { // アイテム 1 のコンストラクタ
    super.colorR = 130;
    super.colorG = 235;
    super.colorB = 80;
  }
  // --- アイテムの取得(接触した際の処理)
  @Override
    void getItem() {
    player.shield++; //シールドを 1 つ増やす
  }
}

////////////
//// アイテム 2(無敵)、1 個のクラス
class Item_2 extends Item { // 汎用的なアイテムを継承
  Item_2() { // アイテム 1 のコンストラクタ
    super.colorR = 0;
    super.colorG = 0;
    super.colorB = 255;
  }
  // --- アイテムの取得(接触した際の処理)
  @Override
    void getItem() {
    player.invincibleStatus = true;
    player.invincibleStartTime = millis(); 
  }
}


////////////
//// アイテム 3(全消滅)、1 個のクラス
class Item_3 extends Item { // 汎用的なアイテムを継承
  Item_3() { // アイテム 1 のコンストラクタ
    super.colorR = 255;
    super.colorG = 0;
    super.colorB = 0;
  }
  // --- アイテムの取得(接触した際の処理)
  @Override
    void getItem() {
    background(100, 100, 255);
    for (int i = 0; i < mMax; i++) meteor[i].resetMeteorite(); //隕石をリセット
  }
}

////////////
//// アイテム 4(残り秒数が増加)、1 個のクラス
class Item_4 extends Item { // 汎用的なアイテムを継承
  Item_4() { // アイテム 1 のコンストラクタ
    super.colorR = 255;
    super.colorG = 255;
    super.colorB = 0;
  }
  // --- アイテムの取得(接触した際の処理)
  @Override
    void getItem() {
     travelTime += 5000;
  }
}

class Back {
  float[] x, y, speed;
  int sN;
  // ----- new 命令が実行されたときに呼ばれる関数
  Back() {
    sN = 100; // 星の数を 100 にする
    x = new float[sN]; // 各星の x 座標値を入れる配列を用意
    y = new float[sN]; // 各星の y 座標値を入れる配列を用意
    speed = new float[sN]; // 各星の移動速度を入れる配列を用意
    for (int i = 0; i < sN; i++ ) {
      x[i] = random( width );
      y[i] = random( height );
      speed[i] = random(1);
    }
  }
  // ----- 星空を描く関数
  void drawStars() { // 教科書では draw() としている
    background(0, 0, 100); // 暗めの青色で塗りつぶす
    noStroke();
    fill(255);
    for ( int i = 0; i < sN; i++ ) {
      ellipse( x[i], y[i], 2, 2 );
    }
  }
  // ----- 星空を移動する関数
  void updateStars() { // 教科書では update() としている
    for (int i=0; i < sN; i++ ) {
      x[i] -= speed[i];
      if ( x[i] < -2 ) x[i] += width; // x 座標が左端に達したら右端に移動
    }
  }
}
////////////////////////////////////////////////////
boolean up, down, left, right; // キー操作用の変数
Back back; // 背景(星空)
Player player; // 宇宙船用変数
Meteorite[] meteor; // 隕石用配列変数
int mMax = 50; // 隕石の最大数
int mN = 0; //画面に登場させる隕石の数
Item[] items; // アイテム(汎用)用配列変数
int iMax = 4;// アイテムの最大数
float r; // アイテムを出現させる確率の計算のための乱数の格納用
int status = 1; // ゲームの現在の状態番号(1:オープニング状態
float travelTime = 60000; // ゴール到達までの制限時間(ミリ秒)
float startTime; // ゲームプレイ開始時刻

void setup() {
  size(600, 300); // 画面サイズの設定→変数 width と height も自動でセットされる
  frameRate(15); // フレームレート(ゲームスピード)
  noCursor();// マウスカーソルを非表示
  player = new Player(); // 宇宙船を初期化
  meteor = new Meteorite[mMax]; // 隕石の配列を作る
  for (int i = 0; i < mMax; i++) {
    meteor[i] = new Meteorite(); // 個々の隕石の初期化
  }
  items = new Item[iMax]; // アイテム用の配列を作る
  back = new Back(); // 背景の初期化
}

// ----- ゲームのメインルーチン
void draw() {
  if ( status == 1 ) opening(); // オープニング状態
  else if ( status == 2 ) gamePlay(); // ゲームプレイ状態
  else if ( status == 3 ) gameClear(); // ゲームクリア状態
  else if ( status == 4 ) gameOver(); // ゲームオーバー状態
  
  player.drawSpaceship(); // 宇宙船を表示
  player.drawBeam(); // ビームを表示
  player.updateBeam(); // ビームの状態を更新
  
//----ビームが隕石に当たった場合、隕石をリセットして消去
  if (player.beam) {
    boolean hit = player.beamHit(player.x + 60, player.y + 10, player.beamlength);
    if (hit) {
      player.beamlength = 100; // ビームの長さを初期化
    }
  }
}

// ----- スペースキーが押されたときの処理
void pressSpaceKey() {
  if ( keyPressed == true && key == ' ' ) {
    player.resetSpaceship(); // 宇宙船(プレーヤー)のリセット
    for (int i = 0; i <mMax; i++ ) meteor[i].resetMeteorite(); // 個々の隕石のリセット
    for (int i = 0; i <iMax; i++ ) items[i] = null; // アイテムの配列の要素をリセット
  startTime = millis();
  status = 2; // ゲームプレイ状態(2)に変更
  }
}

// ----- オープニング状態のときの処理
void opening() {
  back.updateStars(); // 背景の星を移動
  back.drawStars(); // 背景の星を表示
  player.updateSpaceship(); // 宇宙船を移動
  player.drawSpaceship(); // 宇宙船を表示
  // オープニング用の文字表示
  fill(255, 255, 0);
  textSize(30);
  textAlign(CENTER, CENTER);
  text( "SPACE TRAVELER", width/2, height/2 );
  text( "PRESS SPACE KEY TO START", width/2, height/2+50 );
  pressSpaceKey();// スペースキーが押されたらゲーム開始
   if ( keyPressed == true && key == ' ' ) {
      startTime = millis(); // ゲームの開始時刻を記録
      status = 2; // プログラムの状態をゲームプレイ状態(2)にする
   } 
}


void gamePlay() {
  back.updateStars(); // 背景の星を移動
  back.drawStars(); // 背景の星を表示
  player.updateSpaceship();
  player.drawSpaceship();
  for (int i = 0; i < mN; i++ ) {
    meteor[i].updateMeteorite(); // 隕石を移動
    meteor[i].drawMeteorite(); // 隕石を表示
  }

  // アイテムに関する処理
  for (int i = 0; i < iMax; i++ ) { // アイテムの個数分だけアイテムの処理を実行
    if ( items[i] != null ) {
      // 配列にアイテムが格納されている(null ではない=アイテムが出現状態)の場合...
        items[i].updateItem();// アイテムを移動し、存在を確認
        items[i].drawItem(); // アイテムが存在中はアイテムを表示
      } else {
        // 配列にアイテムが格納されていない(=アイテムが未出現状態)の場合...
        r = random(400);
        if ( r < 2 ) { // 200 分の 1 の確率でアイテムを出現に設定
          items[i] = new Item_1();
        } else if ( r < 3 ) { // 400 分の 1 の確率でアイテム 2 を出現に設定
          items[i] = new Item_2();
        } else if ( r < 4 ) { // 400 分の 1 の確率でアイテム 3 を出現に設定
          items[i] = new Item_3();
         }else if ( r < 5 ) { // 400 分の 1 の確率でアイテム 4 を出現に設定
          items[i] = new Item_4();
         }
      }
    }

    
    // プレイ経過時間が設定した時間以上になったらゲームクリア状態(3)にする
    float elapsedTime = millis() - startTime; // 開始時刻からの経過時間の算出
    if ( elapsedTime >= travelTime ) status = 3; // 一定時間以上になったら状態を変更
    // ゲームクリアまでの残りの時間を表示
    fill(100, 255, 100);
    textSize(20);
    textAlign(RIGHT, TOP);
    int remain = (int)(travelTime - elapsedTime) / 1000;
    text(remain, width - 50, 10);
    // 時間の経過とともに隕石の個数が増えるよう、隕石数を更新する
    mN = (int)(mMax * elapsedTime / travelTime);
  }

  // ----- ゲームクリア状態のときの処理
  void gameClear() {
    // ゲームクリア表示
    fill(255, 255, 0, 10);
    textSize(30);
    textAlign(CENTER, CENTER);
    text( "GAME CLEAR", width/2, height/2);
    text( "YOUR SCORE="+player.shield, width/2, height/2+50);
    text( "PRESS SPACE KEY TO RESTART", width/2, height/2+100);
    pressSpaceKey();
  }
  // ----- ゲームオーバー状態のときの処理
  void gameOver() {
    // 画面が徐々に白くなるように透明度 5 で繰り返し塗りつぶす
    fill(255, 5);
    rect(0, 0, width, height);
    // ゲームオーバーの表示
    fill(0, 0, 255, 10);
    textSize(30);
    textAlign(CENTER, CENTER);
    text( "GAME OVER", width/2, height/2 );
    text( "PRESS SPACE KEY TO RESTART", width/2, height/2+50 );
    pressSpaceKey();
  }
