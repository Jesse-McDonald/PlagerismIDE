abstract class Shape {
    float x;
    float y;
    float vx;
    float vy;
    color colorOfShape;
    
    abstract void drawShape();
    
      void move() {
        x = x + vx;
        y = y + vy;
        
        if ((x > width) || (x < 0)) {
            vx = -vx;
            x = x + vx;
        }
        if ((y > height) || (y < 0)) {
            vy = -vy;
            y = y + vy;
        }
    }
    
      void velocity(float velocityX, float velocityY) {
          vx = velocityX;
          vy = velocityY;
      }
}
