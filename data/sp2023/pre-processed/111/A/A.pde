
//list of shapes with associated variables for speed and size

float shape1X, shape1Y, shape1SpeedX, shape1SpeedY, shape1Size;
float shape2X, shape2Y, shape2SpeedX, shape2SpeedY, shape2Size;
float shape3X, shape3Y, shape3SpeedX, shape3SpeedY, shape3Size;
  
  // Define the boundaries of the screen
  float minX, minY, maxX, maxY;
  
  public void settings() {
    size(800, 600);
  }
  
  public void setup() {
    
    // Initialize the shapes
    shape1X = random(width);
    shape1Y = random(height);
    shape1SpeedX = random(2, 5);
    shape1SpeedY = random(2, 5);
    shape1Size = random(20, 50);
    
    shape2X = random(width);
    shape2Y = random(height);
    shape2SpeedX = random(2, 5);
    shape2SpeedY = random(2, 5);
    shape2Size = random(20, 50);
    
    shape3X = random(width);
    shape3Y = random(height);
    shape3SpeedX = random(2, 5);
    shape3SpeedY = random(2, 5);
    shape3Size = random(20, 50);
    
    // Set the boundaries of the screen
    minX = 0;
    minY = 0;
    maxX = width;
    maxY = height;
  }
  
  public void draw() {
    
    // Clear the screen
    background(255);
    
    // Move and draw the first shape
    shape1X += shape1SpeedX;
    shape1Y += shape1SpeedY;
    fill(255, 0, 0);
    ellipse(shape1X, shape1Y, shape1Size, shape1Size);
    
    // Move and draw the second shape
    shape2X += shape2SpeedX;
    shape2Y += shape2SpeedY;
    fill(0, 255, 0);
    rect(shape2X, shape2Y, shape2Size, shape2Size);
    
    // Move and draw the third shape
    shape3X += shape3SpeedX;
    shape3Y += shape3SpeedY;
    fill(0, 0, 255);
    triangle(shape3X, shape3Y, shape3X - shape3Size/2, shape3Y + shape3Size, shape3X + shape3Size/2, shape3Y + shape3Size);
    
    // Check for collisions with the screen boundaries and bounce the shapes off them
    if (shape1X < minX || shape1X > maxX) {
      shape1SpeedX *= -1;
    }
    if (shape1Y < minY || shape1Y > maxY) {
      shape1SpeedY *= -1;
    }
    
    if (shape2X < minX || shape2X > maxX - shape2Size) {
      shape2SpeedX *= -1;
    }
    if (shape2Y < minY || shape2Y > maxY - shape2Size) {
      shape2SpeedY *= -1;
    }
     if (shape3X < minX || shape3X > maxX - shape3Size) {
      shape3SpeedX *= -1;
    }
    if (shape3Y < minY || shape3Y > maxY - shape3Size) {
      shape3SpeedY *= -1;
    }}
