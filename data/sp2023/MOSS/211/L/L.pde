class Torus {
  float x, y, z;
  float radius, tubeRadius;
  float rotationSpeed;
  
  Torus(float x, float y, float z, float radius, float tubeRadius, float rotationSpeed) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.tubeRadius = tubeRadius;
    this.rotationSpeed = rotationSpeed;
  }
  
  void update() {
    y += 1;  // Move the torus down the screen
    rotateX(rotationSpeed);  // Rotate around the x-axis
    rotateY(rotationSpeed);  // Rotate around the y-axis
  }
  
  void display() {
    pushMatrix();
    translate(x, y, z);
    fill(255, 0, 0);  // Set the fill color to red
    drawTorus(radius, tubeRadius);
    popMatrix();
  }
}

ArrayList<Torus> toruses;
int numToruses = 10;

void setup() {
  size(800, 600, P3D);  
  
  toruses = new ArrayList<Torus>();
  
  for (int i = 0; i < numToruses; i++) {
    float x = random(width);
    float y = random(-height, 0);
    float z = random(-200, 200);
    float radius = random(50, 150);
    float tubeRadius = random(10, 50);
    float rotationSpeed = random(0.01, 0.05);
    
    Torus torus = new Torus(x, y, z, radius, tubeRadius, rotationSpeed);
    toruses.add(torus);
  }
}

void draw() {
  background(0,0,200);  
  
  lights(); 
  
  for (Torus torus : toruses) {
    torus.update();
    torus.display();
    
    // Reset torus position if it goes below the screen
    if (torus.y > height) {
      torus.y = random(-height, 0);
    }
  }
}

void drawTorus(float radius, float tubeRadius) {
  int numVertices = 60;  // Number of vertices around the torus
  
  for (int i = 0; i < numVertices; i++) {
    float theta = map(i, 0, numVertices, 0, TWO_PI);  // Angle around the torus
    
    beginShape(QUAD_STRIP);
    for (int j = 0; j <= numVertices; j++) {
      float phi = map(j, 0, numVertices, 0, TWO_PI);  // Angle along the tube
      
      float x = (radius + tubeRadius * cos(phi)) * cos(theta);
      float y = (radius + tubeRadius * cos(phi)) * sin(theta);
      float z = tubeRadius * sin(phi);
      
      vertex(x, y, z);
      
      x = (radius + tubeRadius * cos(phi)) * cos(theta + 0.1);
      y = (radius + tubeRadius * cos(phi)) * sin(theta + 0.1);
      z = tubeRadius * sin(phi);
      
      vertex(x, y, z);
    }
    endShape();
  }
}