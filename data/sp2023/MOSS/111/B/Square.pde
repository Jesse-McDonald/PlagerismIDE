class Square extends Shape {
    float side;
    
    Square(float xPos, float yPos) {
        side = random(15, 45);
        x = xPos;
        y = yPos;
        vx = random(-7, 7);
        vy = random(-7, 7);
        colorOfShape = color(random(255), random(255), random(255));
    }
    
    void drawShape() {
        fill(colorOfShape);
        square(x, y, side);
    }
}
