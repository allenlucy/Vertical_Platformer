//
//Unused class
//
public class Bird {
  PImage image;
  float centerX; //x coord 
  float centerY; //y coord 
  float vx; //velocity in the x direction
  float vy; //velocity in the y direction
  float w; //width
  float h; //height 

  //bird constructor
  public Bird(PImage b, float scale, float x, float y) {
    image = b; //loading image for Bird
    w = image.width * scale; //width is image width * set scale (1.0 is original scale)
    h = image.height * scale; //height is image height * set scale (1.0 is original scale)
    centerX = x; //x coord
    centerY = y; //ycoord
    vx = 0;
    vy = 0;
  }

  //drawing the image every frame

  public void display() {
    image(image, centerX, centerY, w, h);
  }

  public void update() {
    centerX += 1.0;
  }
}
