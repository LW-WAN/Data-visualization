// An Array of Bubble objects
Bubble[] bubbles;
// A Table object
Table table;
// A scale parameter for zoom in and out
float scale=0.5;
// Boolean for zoomIn and Out
float zoomSpeed=1.05;
//mouse rolling event for zoom in and out
float e=0;
//Paramters to show the location of the panel
boolean panUp=false;
boolean panDown=false;
boolean panRight=false;
boolean panLeft=false;
float panx=2234;
float pany=1704;
//float panx=1400;
//float pany=900;
float panSpeed=30;
//actually mouse position
float mx;
float my;


void setup() {
  size(3600, 2000);
  loadData();
}

void draw() {
  translate(1400,900);
  scale (scale);
  translate(-panx, -pany);
  background(255);


  // Display all bubbles
  for (Bubble b : bubbles) {
    b.display();
    mx=(mouseX-1400)/scale+panx;
    my=(mouseY-900)/scale+pany;
    b.rollover(mx,my);
  }
  //stage indicator
  //stage 1
  noFill();
  stroke(0,255,255);
  rect(50,50,300,1650,28);
  textAlign(LEFT);
  fill(0);
  textSize(28);
  text("Stage 1", 55, 1690);
  //stage 2
  noFill();
  stroke(0,204,204);
  rect(550,75,1000,1600,28);
  text("Stage 2", 555, 1665);
  //stage 3
  noFill();
  stroke(0,153,153);
  rect(1750,250,600,1200,28);
  text("Stage 3", 1755, 1440);
  //stage 4
  noFill();
  stroke(0,102,102);
  rect(2550,350,750,1000,28);
  text("Stage 4", 2555, 1340);


  ///zoomin and out function
  if (e==1) {
    scale*=zoomSpeed;
    e=0;
  }
  if (e==-1) {
    scale/=zoomSpeed;
    e=0;
  }
  ///move pan
  if (panUp) {
    pany-=panSpeed;
  }
  if (panDown) {
    pany+=panSpeed;
  }
  if (panRight) {
    panx+=panSpeed;
  }
  if (panLeft) {
    panx-=panSpeed;
  }

  //legend
  textAlign(LEFT);
  fill(0);
  textSize(18);
  text("No CTL Funding", width-100, 920);
  text("Innovation Acceleration", width-100, 940);
  text("Fellowship", width-100, 960);
  text("Both", width-100, 980);
  fill(0);
  noStroke();

    
  circle(width-115, 915, 20);
  fill(85,196,238);
  circle(width-115, 935, 20);
  fill(158,31,99);
  circle(width-115, 955, 20);
  fill( 121,129,169);
  circle(width-115, 975, 20);
  //instruction for using mouse and keyboard
  textSize(25);
  text("Please use your mouse and keyboard to navigate the map", width-120,1010);
}

void loadData() {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  table = loadTable("Data.csv", "header");

  // The size of the array of Bubble objects is determined by the total number of rows in the CSV
  bubbles = new Bubble[table.getRowCount()];

  // You can access iterate over all the rows in a table
  int rowCount = 0;
  for (TableRow row : table.rows()) {
    // You can access the fields via their column name (or index)
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    float d = row.getFloat("diameter");
    String n = row.getString("Inventor(s)");
    String t = row.getString("Technology Sector");
    String w = row.getString("Short descriptor");
    float i = row.getFloat("Ignite");
    float f=row.getFloat("Fellowship");
    String l=row.getString("link");
    // Make a Bubble object out of the data read
    bubbles[rowCount] = new Bubble(x, y, d, n, t, w, i, f, l);
    rowCount++;
  }
}

///read key input
void keyPressed() {
  if (keyCode==UP||keyCode=='W') {
    panUp=true;
    panDown=false;
  }
  if (keyCode==DOWN||keyCode=='S') {
    panDown=true;
    panUp=false;
  }
  if (keyCode==RIGHT||keyCode=='D') {
    panRight=true;
    panLeft=false;
  }
  if (keyCode==LEFT||keyCode=='A') {
    panLeft=true;
    panRight=false;
  }
}
void keyReleased() {
  if (keyCode==UP||keyCode=='W') {
    panUp=false;
  }
  if (keyCode==DOWN||keyCode=='S') {
    panDown=false;
  }
  if (keyCode==RIGHT||keyCode=='D') {
    panRight=false;
  }
  if (keyCode==LEFT||keyCode=='A') {
    panLeft=false;
  }
}


  void mousePressed() {

    for (Bubble b : bubbles) {
      b.rollover(mx, my);
      if (b.over) {
        link(b.web);
      }
    }
  }

  ///mouse roll event
  void mouseWheel(MouseEvent event) {
    e = event.getCount();
  }



  //draw arrows on the graph
  void drawArrow(int cx, int cy, int len, float angle) {
    pushMatrix();
    translate(cx, cy);
    rotate(radians(angle));
    line(0, 0, len, 0);
    line(len, 0, len - 8, -8);
    line(len, 0, len - 8, 8);
    popMatrix();
  }
