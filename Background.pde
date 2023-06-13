public class Background {
  PImage image;
  float centerX; //x coord 
  float centerY; //y coord 
  float vx; //velocity in the x direction
  float vy; //velocity in the y direction
  float w; //width
  float h; //height 

  //platform constructor
  public Background(PImage b, float scale, float x, float y) {
    image = b; //loading image for platform
    w = image.width * scale; //width is image width * set scale (1.0 is original scale)
    h = image.height * scale; //height is image height * set scale (1.0 is original scale)
    centerX = x; //x coord
    centerY = y; //ycoord
    vx = 0;
    vy = 0;
  }

  //drawing the image every frame

  public void display2() {
    image(image, centerX, centerY, w, h);
  }

  /** public void display1(){
   PImage newSky = image.get(width/2, height - 3869, width, height);
   image(newSky, 0, 0);
   }
   **/

  //updating the current x and y coord of image
  public void update() {
    centerX += 0.5;
  }
  
  public void updateSlower() {
    centerX += 0.15;
  }
}
