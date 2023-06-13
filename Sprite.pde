public class Sprite {
  PImage image;
  float centerX; //x coord of sprite
  float centerY; //y coord of sprite
  float vx; //velocity in the x direction
  float vy; //velocity in the y direction
  float w; //width if sprite
  float h; //height of sprite
  float gravity = 0.125;
  float terminal = 20; //fastest sprite can go
  
  Platforms currentPlatform = null;
  Coin currentCoin = null;
  Spike currentSpike = null;
  Bird currentBird = null;

  //sprite constructor
  public Sprite(String filename, float scale, float x, float y) {
    image = loadImage(filename); //loading image for sprite
    //scale is for adjusting image size without editing the original image
    w = image.width * scale; //width is image width * set scale (1.0 is original scale)
    h = image.height * scale; //height is image height * set scale (1.0 is original scale)
    centerX = x; //x coord
    centerY = y; //ycoord
    vx = 0;
    vy = 0;
  }

  //drawing the image every frame
  public void display() {
    update();
    image(image, centerX, centerY, w, h);
  }

  //updating the current x and y coord of image
  public void update() {

    //if already falling or jumping, add gravity onto y velocity
    if (vy != 0 && abs(vy) < terminal) {
      vy += gravity;
      //println(gravity);
    }
    //add the movement on to the current x and y positions
    centerX += vx;
    centerY += vy;
  }

  //retrieving the position on the sprite currently
  public float getLeft() {
    return centerX - w/2;
  }
  public float getRight() {
    return centerX + w/2;
  }
  public float getBottom() {
    return centerY + h/2;
  }
  public float getTop() {
    return centerY - h/2;
  }


/**
All Collision methods
**/



  public boolean checkCollision(Platforms p) {
    if (collision(p.centerX-p.w/2, p.centerY-p.h/2, p.w, p.h, centerX-w/2+20, centerY+h/2-10, w-40, 10)) {
      vy = 0;
      centerY = p.centerY - p.h/2 - h/2;
      //println("top"); // top
    } else if (collision(p.centerX-p.w/2, p.centerY-p.h/2, p.w, p.h, centerX-w/2+20, centerY-h/2+10, w-40, h-10)) {
      vx = -vx/2;
      //println("side"); // side
    } else if (collision(p.centerX-p.w/2, p.centerY-p.h/2, p.w, p.h, centerX-w/2+20, centerY-h/2, w-40, 10)) {
      vy = abs(vy)/2;
      //println("bottom"); // bottom
    } else return false;
    return true;
  }
  
  /**
  public boolean checkCollisionBird(Bird b){
        if (collision(b.centerX-b.w/2, b.centerY-b.h/2, b.w, b.h, centerX-w/2, centerY-h/2, w, h)) {
      //print("hit bird");
    } else return false;
    return true;
  } 
  }
  **/

  boolean collision(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {

    // are the sides of one rectangle touching the other?
    //r1x, r1y, r1w, r1y platform
    //r2x, r2y, r2w, r2y player

    if (r1x + r1w >= r2x &&     // r1 right edge past r2 left
      r1x <= r2x + r2w &&       // r1 left edge past r2 right
      r1y + r1h >= r2y &&       // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
      return true;
    }
    return false;
  }













  public boolean checkCollisionCoin(Coin c) {
    if (circleRect(c.centerX-c.radius/2, c.centerY-c.radius/2, c.radius, centerX-w/2, centerY-h/2, w, h)) {
      //print("hit coint");
    } else return false;
    return true;
  } 

  // CIRCLE/RECTANGLE
  boolean circleRect(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

    // temporary variables to set edges for testing
    float testX = cx;
    float testY = cy;

    // which edge is closest?
    if (cx < rx)         testX = rx;      // test left edge
    else if (cx > rx+rw) testX = rx+rw;   // right edge
    if (cy < ry)         testY = ry;      // top edge
    else if (cy > ry+rh) testY = ry+rh;   // bottom edge

    // get distance from closest edges
    float distX = cx-testX;
    float distY = cy-testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );

    // if the distance is less than the radius, collision!
    if (distance <= radius) {
      return true;
    }
    return false;
  }





  public boolean checkCollisionSpike(Spike s) {

    if (triPoint(s.x1, s.y1, s.x2, s.y2, s.x3, s.y3, centerX, centerY+h/2)) {
      //println("hit spike");
    } else if (triPoint(s.x1, s.y1, s.x2, s.y2, s.x3, s.y3, (centerX-w/2)+35, centerY+h/2)) {
      //println("hit spike left");
    } else if (triPoint(s.x1, s.y1, s.x2, s.y2, s.x3, s.y3, (centerX+w/2)-35, centerY+h/2)) {
      //println("hit spike right");
    } else return false;
    return true;
  } 

  // TRIANGLE/POINT
  boolean triPoint(float x1, float y1, float x2, float y2, float x3, float y3, float px, float py) {
    //fill(0,255,0);
    //circle(px, py, 20);
    // get the area of the triangle
    float areaOrig = abs( (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1) );

    // get the area of 3 triangles made between the point
    // and the corners of the triangle
    float area1 =    abs( (x1-px)*(y2-py) - (x2-px)*(y1-py) );
    float area2 =    abs( (x2-px)*(y3-py) - (x3-px)*(y2-py) );
    float area3 =    abs( (x3-px)*(y1-py) - (x1-px)*(y3-py) );

    // if the sum of the three areas equals the original,
    // we're inside the triangle!
    if (area1 + area2 + area3 == areaOrig) {
      //fill(0, 255, 0);
      triangle(x1, y1, x2, y2, x3, y3);
      // println("hit");
      return true;
    }
    //println("no hit");
    return false;
  }
}
