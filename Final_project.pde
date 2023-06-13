Sprite a;  //<>//
Platforms p;
Background b;
Coin c;
Background cloud, miniclouds;

//import processing.sound.*;

//SoundFile file;
String audioName = "Enlarged Sky/happynes.mp3";
String path;


int lastFrame;
float gravity = 0.1;
float platformScale = 1.0; //scale of platform
float vx = 0; //velocity of x value
float vy = 0; //velocity of y value
float ax = 0.0; //acceleration of x value
float ay = 0.1; //acceleration of y value

//All arraylists
ArrayList<Platforms> platform = new ArrayList<Platforms>();
ArrayList<Coin> coin = new ArrayList<Coin>();
ArrayList<Background> bg = new ArrayList<Background>();
ArrayList<Bird> bird = new ArrayList<Bird>();

int gainedCoins = 0; //coins collected by the player
int time;
int wait = 10000; //wait for time
float VERTICAL_MARGIN = 400; // if the player goes past this margin the screen will scroll with it
float view_y = 0;
boolean Game = false; //decides if game has started or on loading screen

void setup() {
  
  
  
  //
  //COMMENT HERE TO STOP MUSIC
  //
  /**
  
  //Audio setup
  //Makes sure there is no overlap in audio when game restarts
  loop();
  path = sketchPath(audioName);
  if (file != null) file.stop();
  file = new SoundFile(this, path);
  if (!(file.isPlaying())) {
    file.play();
  }
  */
  //
  //END COMMENT HERE TO STOP MUSIC
  //




  PFont gameBoy = createFont("Enlarged Sky/Early GameBoy.ttf", 100);
  textFont(gameBoy);
  noStroke();
  size(600, 900, P2D);
  imageMode(CENTER);

  //resetting variables to be able to restart the game
  platform.clear();
  coin.clear();
  time = millis();
  gainedCoins = 0;


  a = new Sprite("Enlarged Sky/Enlarged_Sprite.png", 1.0, width/2, height-200); //creating sprite
  a.vx = 0; //setting the velocity of sprite to be 0

  /**
   //arraylists of birds
   for (int i = 1000; i> -7500; i-= 1000) {
   platform.add(new Bird("Enlarged Sky/Bird_Enlarged.png", 1.0, -50, i));
   }
   **/

  //arraylist of platforms
  for (int i = 400; i> -7500; i-= 300) {
    platform.add(new Platforms("Enlarged Sky/Enlarged_Platform.png", 1.0, random(100, width-100), i, false));
  }

  //arraylist of coins
  for (int i = 500; i> -7500; i-= 600) {
    coin.add(new Coin("Enlarged Sky/Enlarged_Coin.png", 1.0, random(50, width-250), i));
  }

  //arraylist of ground inside the platforms class
  PImage image = loadImage("Enlarged Sky/Enlarged_Ground.png");
  float wid = 0+image.width/2;
  float hei = height-image.height/2;
  for (int i = 0; i < width; i+= image.width) {
    platform.add(new Platforms("Enlarged Sky/Full_ground.png", 1.0, wid+i, hei, true));
    // image(image, wid+i, hei); //ground platform
  }

  //background image seperated 
  PImage Sky1 = loadImage("Enlarged Sky/Sky1.png");
  bg.add(new Background(Sky1, 1.0, width/2, 0));
  PImage Sky2 = loadImage("Enlarged Sky/Sky2.png");
  bg.add(new Background(Sky2, 1.0, width/2, -1500));
  PImage Sky3 = loadImage("Enlarged Sky/Sky3.png");
  bg.add(new Background(Sky3, 1.0, width/2, -3000));
  PImage Sky4 = loadImage("Enlarged Sky/Sky4.png");
  bg.add(new Background(Sky4, 1.0, width/2, -4500));
  PImage Sky5 = loadImage("Enlarged Sky/Sky5.png");
  bg.add(new Background(Sky5, 1.0, width/2, -6000));
  PImage Sky6 = loadImage("Enlarged Sky/Sky6.png");
  bg.add(new Background(Sky6, 1.0, width/2, -7500));
  PImage Sky7 = loadImage("Enlarged Sky/Sky7.png");
  bg.add(new Background(Sky7, 1.0, width/2, -9000));

  PImage clouds = loadImage("Enlarged Sky/Full Clouds3.png");
  cloud = new Background(clouds, 1.0, -6000, -3750);
  //PImage cloudmini = loadImage("Enlarged Sky/miniclouds.png");
  //miniclouds = new Background(cloudmini,1.0, -6000, -3750);
}

void draw() {
  if (Game) {
    //background(125);
    //main game
    scroll();
    for (Background b : bg) {
      b.display2();
    }
    cloud.display2();
    cloud.update();
    //miniclouds.display2();
    //miniclouds.updateSlower();
    //paralax clouds
    a.display();
    collide();
    playerOnScreen();
    textAndTime();
  } else {

    //Everything that is on the starting screen
    PImage startingScreen = loadImage("Enlarged Sky/title.png");
    image(startingScreen, width/2, height/2, width, height);
    textSize(24);

    if ((mouseX > width/8 && mouseX < 525) && (mouseY > height/2+150 && mouseY < 675)) {
      fill(55, 80, 100);
      rect(width/8, height/2+150, 450, 75);
      fill(255);
      text("Click Here to Start", width/10+35, height/2+195);
    } else {
      fill(90, 122, 160);
      rect(width/8, height/2+150, 450, 75);
      fill(255);
      text("Click Here to Start", width/10+35, height/2+195);
    }
  }
}

void keyPressed() {
  if (key == 'w' && a.vy == 0) a.vy -= 10;
  if (key == 'a' && a.vx == 0) a.vx = -8;
  if (key == 'd' && a.vx == 0) a.vx = 8;
  if (key == 'r') setup();
  if (key == 'g') Game = true;
}

void keyReleased() {
  if (key == 'a') a.vx = 0;
  if (key == 'd') a.vx = 0;
}

void mousePressed() {
  if (((mouseX > width/8 && mouseX < 525) && (mouseY > height/2+150 && mouseY < 675)) && Game==false) {
    fill(58, 89, 129);
    rect(width/8, height/2+150, 450, 75);
    fill(255);
    text("Click Here to Start", width/10+35, height/2+195);
  }
}

void mouseReleased() {
  if (((mouseX > width/8 && mouseX < 525) && (mouseY > height/2+150 && mouseY < 675)) && Game == false) {
    Game = true;
  } else if ((!((mouseX > width/8 && mouseX < 525) && (mouseY > height/2+150 && mouseY < 675))) && Game == false) {
    fill(90, 122, 160);
    rect(width/8, height/2+150, 450, 75);
    fill(255);
    text("Click Here to Start", width/10+35, height/2+195);
  }
}

/**
 * method that moves the screen if the player goes outside of the vertical boundary
 * shifts everything that isn't the player downwards
 **/
void scroll() {
  float bottomBoundary = view_y + height - VERTICAL_MARGIN;
  if (a.getBottom() > bottomBoundary) {
    view_y += a.getBottom() - bottomBoundary;
  }
  float topBoundary = view_y + VERTICAL_MARGIN;
  if (a.getBottom() <= 800) {
    if (a.getTop() < topBoundary) {
      view_y -= topBoundary - a.getTop();
    }
  }
  translate(0, -view_y);
}

/**
 All collision methods for the arraylists of objects
 **/
void collide() {
  boolean hitSpike = false;
  boolean collided = false;
  //  boolean hitBird = false

  //goes through all the platforms and checks if any of them have collided, if so, assign that platform to current platform
  for (Platforms plat : platform) {
    plat.display();
    plat.displaySpike();

    //checks all the spikes on each platform
    for (Spike s : plat.spike) {
      if (a.checkCollisionSpike(s)) {
        a.currentSpike = s;
        hitSpike = true;
      }
    }
    if (a.checkCollision(plat)) {
      collided = true;
      a.currentPlatform = plat;
    }
    //if did not collide and not falling, add graviy on to vertical speed to make sprite fall
    if (collided == false && a.vy == 0) a.vy += a.gravity;
  }
  //if player hits spike, restart the game
  if (hitSpike == true) setup();

  //if player hits coin, remove it from the arraylist and add 1 to gained coins
  for (int i = 0; i < coin.size(); i++) {
    Coin c = coin.get(i);
    boolean collidedCoin = a.checkCollisionCoin(c);
    if (collidedCoin) {
      gainedCoins++;
      a.currentCoin = c;
      coin.remove(c);
    }
    c.display();
  }
  /** 
   for(Bird b: bird){
   if(a.checkCollisionBird(b)){
   a.currentBird = b;
   hitBird = true;
   }
   if(hitBird == true) setup();
   }
   **/
}

/** 
 Keeping the player on the screen and not going past the edge
 **/
void playerOnScreen() {
  if (a.centerX + (a.w)/2 -20 >= width) {
    a.vx = 0;
    a.centerX = width - a.w/2 +20;
  }
  if (a.centerX - (a.w)/2 + 20< 0) {
    a.vx = 0;
    a.centerX = a.w/2 - 20;
  } 
  if (a.centerY + (a.h)/2 >= height) {
    a.vy = 0;
    a.centerY = (height) - a.h/2;
  }
}

/**
 All text and time on screen in the main game
 **/
void textAndTime() {
  //println(1000/(millis()-lastFrame));
  //lastFrame = millis();

  fill(255);
  textSize(32);
  //ext("Time: " + time/1000, 30, view_y + 50);
  text("Coins: " + gainedCoins + ":14", 30, view_y + 50);

  textSize(30);
  text("Press W to Jump", width/6, height/2+300);
  textSize(25);
  text("Collect all the coins!", width/10, height/2+350);
  textSize(35);
  text("Well Done on", width/8+10, -7750);
  text("Getting up Here", width/8-25, -7700);
  textSize(25);
  text("Press 'r' to Restart", width/8, -7650);

  if (millis() - time >= wait) {
    time = millis();//also update the stored time
  }
}
