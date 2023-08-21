class Triangle extends Shape {
    float scale;
    
    Triangle(float xPos, float yPos) {
        scale = random(15, 45);
        x = xPos;
        y = yPos;
        vx = random(-10, 10);
        vy = random(-10, 10);
        colorOfShape = color(random(255), random(255), random(255));
    }
    
    void drawShape() {
        fill(colorOfShape);
        triangle(x, y, x + scale, y, x + 0.5*scale, y - 0.5*scale);
    }
}
