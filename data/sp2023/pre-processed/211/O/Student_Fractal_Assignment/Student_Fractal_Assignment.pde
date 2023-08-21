// Student Name
// 5/4/2023
// Fractal Assignment
//
// I did this assignment through looking at various examples given in the IDE
// I was interested in user interaction so I got the code from an example that tracks your mouse location
// I also played with various shape outputs and translations and got to an acceptable point
//
// this was really fun and would like to learn more about sketching in the future. 

float theta;   

void setup() {
  size(800, 800);
}

void draw() {
  background(255, 173, 251);
  frameRate(30);
  stroke(142, 92, 444);
  float a = (mouseX / (float) width) * 180f;
  theta = radians(a);
  translate(width/2,height);
  arc(0,0,0,0,0,0);
  translate(0,-300);
  branch(250);

}

void branch(float h) {
  h *= 0.69;
  if (h > 2) {
    pushMatrix();    
    rotate(theta);   
    arc(0, 0, 0, 0, 0, -h);  
    translate(0, -h); 
    branch(h);      
    popMatrix();    
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    ellipse(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}