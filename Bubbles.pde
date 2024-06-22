// A Bubble class

class Bubble {
  float x, y;
  float diameter;
  String name;
  String tech;
  String descriptor;
  float Ignite;
  float Fellowship;
  String web;

  boolean over = false;

  // Create  the Bubble
  Bubble(float x_, float y_, float diameter_, String s, String t, String w, float i_, float f_, String w_) {
    x = x_;
    y = y_;
    diameter = diameter_;
    name = s;
    tech = t;
    descriptor = w;
    Ignite = i_;
    Fellowship=f_;
    web=w_;
  }

  // CHecking if mouse is over the Bubble
  void rollover(float px, float py) {
    float d = dist(px, py, x, y);
    if (d < diameter/2) {
      over = true;
    } else {
      over = false;
    }
  }

  // Display the Bubble
  void display() {
    stroke(0);
    strokeWeight(2);
    float alpha = 255;
    
    // when mouse on the circle, change transparency and show names
    if (over) {
      fill(0);
      textSize(12);
      textAlign(CENTER);
      text(name, x, y-diameter/2-10);
      alpha=150;
    }


    //Change the color by funding resources
    if (Ignite ==0) {
      if (Fellowship ==0) {
        fill(0, alpha);
      } else {
        fill(158,31,99, alpha);
      }
    } else {
      if (Fellowship == 0){
        fill(85,196,238, alpha);
      } else {
        fill( 121,129,169, alpha);
      }
    }
    


   //draw circles
    ellipse(x, y, diameter, diameter);

    //display constantly

    fill(0);
    textSize(12);
    textAlign(CENTER);
    text(descriptor, x-40, y+diameter/2+10, 80, 60);
  }
}
