ArrayList<Shape> shapes;
void setup(){
  size(800,800);
  shapes=new ArrayList<Shape>();
}

void draw(){
  background(255);
  for (Shape shape : shapes){
    shape.update();
    shape.draw();
  }
}

void mouseClicked(){
  switch((int)random(3)){
    case 0:
      shapes.add(new Circle(mouseX,mouseY, random(10,100))); 
      break;
    case 1:
      shapes.add(new Square(mouseX,mouseY, random(10,100))); 
      break;
    case 2:
      shapes.add(new Triangle(mouseX,mouseY, random(10,100))); 
      break;
  }
}

abstract class Shape{
  float x;
  float y;
  float vx;
  float vy;
  color c;
  Shape(float ix, float iy){
    x=ix;
    y=iy;
    vx=random(-100,100)/10.0;
    vy=random(-100,100)/10.0;
    c=color(random(255),random(255),random(255));
  }
  void update(){
    if(x<0||x>width){
        vx*=-1;
    }
    if(y<0||y>width){
        vy*=-1;
    }
    x+=vx;
    y+=vy;
  }
  abstract void draw();
}
class Circle extends Shape{
  float size;
  Circle(float ix, float iy, float isize){
    super(ix,iy); 
    size=isize;
  }
  void draw(){
    fill(c);
    circle(x,y,size);
  }
}
class Square extends Shape{
  float size;
  Square(float ix, float iy, float isize){
    super(ix,iy); 
    size=isize;
  }
  void draw(){
    fill(c);
    square(x-size/2,y-size/2,size);
  }
}
class Triangle extends Shape{
  float size;
  Triangle(float ix, float iy, float isize){
    super(ix,iy); 
    size=isize;
  }
  void draw(){
    fill(c);
    triangle(x-size/2,y,x+size/2,y+size/2,x+size/2,y-size/2);
  }
}
