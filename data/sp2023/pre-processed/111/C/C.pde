import java.util.ArrayList;

abstract class Shape {
  protected float x, y, vx, vy;
  protected int c;

  public Shape(float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.c = color((int) random(256), (int) random(256), (int) random(256));
  }

  public abstract void draw();

  public void update() {
    x += vx;
    y += vy;

    if (x < 0 || x > width) {
      vx = -vx;
    }
    if (y < 0 || y > height) {
      vy = -vy;
    }
  }
}

class Square extends Shape {
  private float size;

  public Square(float x, float y, float vx, float vy, float size) {
    super(x, y, vx, vy);
    this.size = size;
  }

  public void draw() {
    fill(c);
    rect(x, y, size, size);
  }
}

class Circle extends Shape {
  private float radius;

  public Circle(float x, float y, float vx, float vy, float radius) {
    super(x, y, vx, vy);
    this.radius = radius;
  }

  public void draw() {
    fill(c);
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}

class Triangle extends Shape {
  private float size;

  public Triangle(float x, float y, float vx, float vy, float size) {
    super(x, y, vx, vy);
    this.size = size;
  }

  public void draw() {
    fill(c);
    float halfSize = size / 2;
    triangle(x - halfSize, y + halfSize, x, y - halfSize, x + halfSize, y + halfSize);
  }
}

ArrayList<Shape> shapes;

void setup() {
  size(500, 500);
  shapes = new ArrayList<Shape>();
}

void draw() {
  background(255);

  for (Shape shape : shapes) {
    shape.update();
    shape.draw();
  }
}

void mouseClicked() {
  float x = mouseX;
  float y = mouseY;
  float vx = random(-5, 5);
  float vy = random(-5, 5);
  int type = (int) random(3);
  Shape shape;

  switch (type) {
    case 0:
      shape = new Square(x, y, vx, vy, random(50, 100));
      break;
    case 1:
      shape = new Circle(x, y, vx, vy, random(50, 100));
      break;
    case 2:
      shape = new Triangle(x, y, vx, vy, random(50, 100));
      break;
    default:
      shape = new Circle(x, y, vx, vy, random(50, 100));
  }

  shapes.add(shape);
}
