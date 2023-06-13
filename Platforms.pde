public class Platforms {
  PImage image;
  float centerX; //x coord of platform
  float centerY; //y coord of platform
  float vx; //velocity in the x direction
  float vy; //velocity in the y direction
  float w; //width if platform
  float h; //height of platform


  Spike s;
  Spike currentSpike = null;
  ArrayList<Spike> spike = new ArrayList<Spike>();
  float noOfSpikes = 0;
  float placeOfSpikes = 0;
  float num = 0;
  boolean left = false;
  float slot = 0;

  //platform constructor
  public Platforms(String filename, float scale, float x, float y, boolean isGround) {
    image = loadImage(filename); //loading image for platform
    w = image.width * scale; //width is image width * set scale (1.0 is original scale)
    h = image.height * scale; //height is image height * set scale (1.0 is original scale)
    centerX = x; //x coord
    centerY = y; //ycoord
    vx = 0;
    vy = 0;


    if (!isGround) {
      noOfSpikes = random(0, 3);
      //println(noOfSpikes);
      for (int i = 0; i < noOfSpikes; i++) {
        placeOfSpikes = (int)random(0, 5);
        spike.add(new Spike(((x-w/2)+20)+40*placeOfSpikes, (y-h/2)-30, (x-w/2)+40*placeOfSpikes, y-h/2, ((x+40)-w/2)+40*placeOfSpikes, y-h/2)); 

        /** algorithm I didn't end up using
         float slot1 = (w/2);
         float slot2 = slot1 + (w/5);
         float slot3 = slot2 + (w/5);
         float slot4 = slot3 + (w/5);
         float slot5 = slot4 + (w/5);
         
         num = (int) random(0, 2);
         slot =(int) random(0, 2);
         //println(slot);
         //spike.add(new Spike(((x-w/2)+20), (y-h/2)-30, (x-w/2), y-h/2, ((x+40)-w/2), y-h/2)); //og
         
         if (noOfSpikes==1) {
         //print("1");
         if (num==0) {
         left = true;
         if(slot==0){ 
         spike.add(new Spike(((slot1)+20), (y-h/2)-30, (slot1), y-h/2, ((40)-slot1), y-h/2));
         }
         else{
         spike.add(new Spike(((x-slot2)+20), (y-h/2)-30, (x-slot2), y-h/2, ((x+40)-slot2), y-h/2));
         }
         
         } else {
         left = false;
         if(slot==0){ 
         spike.add(new Spike(((x-slot4)+20), (y-h/2)-30, (x-slot4), y-h/2, ((x+40)-slot4), y-h/2));
         }
         else{
         spike.add(new Spike(((x-slot5)+20), (y-h/2)-30, (x-slot5), y-h/2, ((x+40)-slot5), y-h/2));
         }
         }
         
         
         } else if (noOfSpikes==2) {
         //print("2");
         if (num==0) {
         left = true;
         if(slot==0){ 
         spike.add(new Spike(((x-slot1)+20), (y-h/2)-30, (x-slot1), y-h/2, ((x+40)-slot1), y-h/2));
         }
         else{
         spike.add(new Spike(((x-slot2)+20), (y-h/2)-30, (x-slot2), y-h/2, ((x+40)-slot2), y-h/2));
         }
         
         } else {
         left = false;
         if(slot==0){ 
         spike.add(new Spike(((x-slot4)+20), (y-h/2)-30, (x-slot4), y-h/2, ((x+40)-slot4), y-h/2));
         }
         else{
         spike.add(new Spike(((x-slot5)+20), (y-h/2)-30, (x-slot5), y-h/2, ((x+40)-slot5), y-h/2));
         }
         }
         
         } else if (noOfSpikes==3) {
         //print("3");
         spike.add(new Spike(((x-slot3)+20), (y-h/2)-30, (x-slot3), y-h/2, ((x+40)-slot3), y-h/2));
         } 
         **/
      }
    }
  }


  public void displaySpike() {
    for (Spike spikes : spike) {
      spikes.display();
    }
  }

/**
unused method
**/
  public void collisionsSpike() {
    for (Spike spikes : spike) {
      if (a.checkCollisionSpike(spikes)) {
        a.currentSpike = spikes;
      }
    }
  }

  //
  public void display() {
    image(image, centerX, centerY, w, h);
  }
}
