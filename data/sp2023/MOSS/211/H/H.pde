//Watched a YouTube video by The Coding Train and worked
//with friends to make sure the syntax was correct

void setup() {
  size(640, 480);
  colorMode(RGB, 1);

  
}

void draw() {

  float ca = -.7;
  float cb = .212;

  

  background(255);

  float w = 5;
  float h = (w * height) / width;

  float xmin = -w / 2;
  float ymin = -h / 2;

  loadPixels();

 int maxiterations = 100;

  float xmax = xmin + w;

  float ymax = ymin + h;

  float dx = (xmax - xmin) / width;
  float dy = (ymax - ymin) / height;


  float y = ymin;
  for (int j = 0; j < height; j++) {
    
    float x = xmin;
    for (int i = 0; i < width; i++) {
     
      float a = x;
      float b = y;
      int n = 0;
      while (n < maxiterations) { 
        float aa = a * a;
        float bb = b * b;
       
        if (aa*aa + bb*bb > 4.0) {
          break; // Bail
        }
       float twoab = 2.0 * a * b;
        a = aa - bb + ca;
        b = twoab + cb;
        n++;
      }


      if (n == maxiterations) {
        pixels[i+j*width] = color(0);
      } else {
          float hu = sqrt(float(n)/maxiterations);
       pixels[i+j*width] = color(hu,255,255);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
  println(frameRate);
}