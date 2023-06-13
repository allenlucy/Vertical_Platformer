public class Coin {
  PImage image;
  float centerX; //x coord
  float centerY; //y coord 
  float radius;

  //platform constructor
  public Coin(String filename, float scale, float x, float y) {
    image = loadImage(filename); //loading image for platform
    radius = image.width * scale; //width is image width * set scale (1.0 is original scale)
    centerX = x; //x coord
    centerY = y; //ycoord
    vx = 0;
    vy = 0;
  }

  //drawing the image every frame
  public void display() {
    image(image, centerX, centerY, radius, radius);
  }
}
