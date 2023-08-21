class Circle extends Shape {
    float radius;
    
    Circle(float xPos, float yPos) {
        radius = random(15, 45);
        x = xPos;
        y = yPos;
        vx = random(-3, 3);
        vy = random(-3, 3);
        colorOfShape = color(random(255), random(255), random(255));
    }
    
    void drawShape() {
        fill(colorOfShape);
        circle(x, y, radius);
    }
}