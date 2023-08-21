/*
	How I completed the assignemnt:
	I utilized https://processing.org/reference/ for information. Otherwise I did it on my own.
	(I've offered this code to classmates so it could hopefully still be useful in the plagiarism detection research)
*/

import java.util.ArrayList;
import java.lang.Math;

abstract class Shape {
    //this const is used as the divisor with size to alter the rate of velocity in respects to how large a shape is (i.e. larger shapes should take longer to slow down). Making it smaller may result in larger shapes speeding up instead of slowing down.
    final float SLOW = 1001;
    //this const is used to determine the initial velocity of a shape in respects to how large it is (i.e. smaller shapes should come out faster).
    final float FAST = 20;
    //this const determines the rate at which shapes slow. SLRATE - (size / SLOW) must be a value over 1, otherwise shapes will speed up instead of slowing down.
    final float SLRATE = 1.05;
    
    int posx;
    int posy;
    int col = int(random(#000000, #FFFFFF));
    int size = int(random(10, 50));
    float vx = random(-25, 25) * (FAST/float(size));
    float vy = random(-25, 25) * (FAST/float(size));
    
    //initial generation function
    public void gen() {
        posx = mouseX;
        posy = mouseY;
        this.updraw();
    }

    //update function is used to do the math on velocity and edge detection. The actual drawing of the shape is left to each subclass's implementation of the abstract updraw function.
    public void update() {
        posx += vx;
        posy += vy;
        
        //bring vx and vy closer to 0
        //trying to make this respect size and momentum (larger shapes take longer to slow down) but the effect is negligible
        float slowval = size / SLOW;
        
        vx = vx / (SLRATE - slowval);
        vy = vy / (SLRATE - slowval);
        
        //detect edges, bouncing causes a slight loss in velocity
        if (posy > height) {
            posy = height;
            vy = (vy * -1)/SLRATE;
            vx = vx / SLRATE;
        } else if (posy < 0) {
            posy = 0;
            vy = (vy * -1)/SLRATE;
            vx = vx / SLRATE;
        }
        if (posx > width) {
            posx = width;
            vx = (vx * -1)/SLRATE;
            vy = vy / SLRATE;
        } else if (posx < 0) {
            posx = 0;
            vx = (vx * -1)/SLRATE;
            vy = vy / SLRATE;
        }
        
        //don't let vx and vy drop to 0
        //I can't figure out an elegant way to prevent the shapes from completely stopping without also messing up their trajectory slightly, I'm sure there's a simple answer I'm not seeing
        if (Math.abs(vx) <= 1) {
            vx = vx * SLRATE;
        }
        if (Math.abs(vy) <= 1) {
            vy = vy * SLRATE;
        }
        fill(col);
        
    }
    
    //abstract method to draw the shape
    abstract void updraw();
}

class Square extends Shape {
    public void updraw() {
        square(posx, posy, size);
    }
}
class Circle extends Shape {
    public void updraw() {
        circle(posx, posy, size);
    }
}

class Triangle extends Shape {
    //used to slightly randomize the triangle point positions and make them all look more unique
    int randint1 = int(random(-10,10));
    int randint2 = int(random(-10,10));
    int randint3 = int(random(-10,10));
    
    public void updraw() {
        triangle(posx+randint1, posy-size+randint1, posx-size+randint2, posy+size+randint2, posx+size+randint3, posy+size+randint3);
    }
}

//arraylist of shapes to iterate over in draw()
ArrayList<Shape> shapes = new ArrayList<Shape>();

void setup(){
    size(500,500);
}

void draw(){
	background(#FFFFFF);
	for (int i = 0; i < shapes.size(); i++){
    	shapes.get(i).update();
    	shapes.get(i).updraw();
	}
}

void mouseClicked() {
    int seed = int(random(3));
    Shape x;
    if (seed == 0) {
        x = new Triangle();
    } else if (seed == 1) {
        x = new Circle();
    } else {
        x = new Square();
    }
    x.gen();
    shapes.add(x);
}																				