
//Assignment was done by watching a video and help from peer.
//link: https://www.youtube.com/watch?v=fAsaSkmbF5s


void setup() {
  size(1920, 1080);
  colorMode(RGB, 255);
}

void draw() {

  float ca =  0.355534;
  float cb = - 0.337292;

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
        float aa = a*a;
        float bb = b*b;
       
        if (aa + bb > 4.0) {
          break; 
        }
       float twoab = 2.0* a* b;
        a = aa - bb + ca;
        b = twoab + cb;
        n++;
      }
      if (n == maxiterations) {
        pixels[i+j*width] = color(229, 204, 255);
      } else {
       pixels[i+j*width] = color(229,255,204);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}