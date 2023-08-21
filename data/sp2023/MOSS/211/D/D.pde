void setup() {
  size(800, 800);
  colorMode(HSB, 255);  // Use HSB color mode for more interesting colors
  noStroke();           // Turn off stroke for faster rendering
}

void draw() {
  loadPixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      // Convert pixel coordinates to complex number c
      float a = map(x, 0, width, -2.5, 1);
      float b = map(y, 0, height, -1, 1);
      float ca = a;
      float cb = b;
      
      int n = 0;
      
      // Iterate the function z^2 + c until it diverges or the maximum number of iterations is reached
      while (n < 100) {
        float aa = a * a - b * b;
        float bb = 2 * a * b;
        a = aa + ca;
        b = bb + cb;
        
        if (a * a + b * b > 4) {
          break;
        }
        
        n++;
      }
      
      // Set pixel color based on the number of iterations
      if (n == 100) {
        pixels[x + y * width] = color(0);  // Black if it does not diverge
      } else {
        pixels[x + y * width] = color(n % 255, 255, 255);  // Color based on iterations
      }
    }
  }
  
  updatePixels();
}
