
ArrayList<Shape> shapes;
int ballWidth = 90;

void setup() {
  size(640, 360);
  noStroke();

  shapes = new ArrayList<Shape>();
  
    
}

void draw() {
    background(255);
    
    for (int i = 0; i <= shapes.size() - 1; i++) {
        Shape shape1 = shapes.get(i);
        shape1.drawShape();
        shape1.move();
    }
    
    
    
}

void mousePressed() {
    int shapeType = int(random(3));
    float xPos = mouseX;
    float yPos = mouseY;
    
    switch (shapeType) {
        case 0:
    		shapes.add(new Circle(xPos, yPos));
    		break;
    	case 1:
    		shapes.add(new Square(xPos, yPos));
			break;
		case 2: 
			shapes.add(new Triangle(xPos, yPos));
			break;
    }
}