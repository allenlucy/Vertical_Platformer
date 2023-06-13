public class Spike {
  float x1, x2, x3;
  float y1, y2, y3;

  //spike constructor
  public Spike(float x1, float y1, float x2, float y2, float x3, float y3) {
    this.x1 = x1;
    this.y1 = y1;

    this.x2 = x2;
    this.y2 = y2;

    this.x3 = x3;
    this.y3 = y3;

    display();
  }

  //drawing the image every frame
  public void display() {
    stroke(90, 122, 160);
    fill(225);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}
