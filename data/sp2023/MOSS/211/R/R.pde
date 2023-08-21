/**
Summary: 
This assignment was completed with the help of a youtube video solving the assignment and the requirements.
*/


// Instance variables initialized and used for execution of the program
int maxIter = 128;
double minRe = -2.5, maxRe = 1;
double minIm = -1, maxIm = 1;
double zoom = 1.0;
boolean leftPressed = false, rightPressed = false;
color[] colors;

// Setup the workspace
void setup() {
    size(960, 540);
    // Array of colors that is used to color the stable and unstable part of the fractal
    colors = new color[] {
        color(0), color(213, 67, 31),
        color(251, 255, 121), color(62, 223, 89),
        color(43, 30, 218), color(0, 255, 247)
    };
}

// Block of code to make the Mandelbrot fractal
void draw() {
    // Conditional statement that executes when mouse buttons are pressed
    if (mousePressed && mouseButton == LEFT && !leftPressed) {
        leftPressed = true;
        zoomWindow(5.0);
        zoom *= 5.0;
    } else if (mousePressed && mouseButton == RIGHT && !rightPressed) {
        rightPressed = true;
        zoomWindow(1.0 / 5);
        zoom /= 5.0;
    }
    // Call load pixels
    loadPixels();
    // For loop that iterates through the width and height and assign block variables
	for(int y = 0; y < height; y++) {
    	for (int x = 0; x < width; x++) {
    		double cr = minRe + (maxRe - minRe) * x / width;
    		double ci = minIm + (maxIm - minIm) * y / height;
    		double re = 0, im = 0;
    		int iter;
    		// Iterates through iter 
    		for (iter = 0; iter < maxIter; iter++) {
        		double tempr = re * re - im * im + cr;
        		im = 2 * re * im + ci;
        		re = tempr;
        		// Conditional that executes and breaks when met
        		if (re * re + im * im > 2 * 2) break;
    		}
    		//pixels[x + y * width] = color(255 - (float) iter / maxIter * 255);
    		int colorCount = colors.length - 1;
    		// iter will be 0 if iter == maxIter
    		if (iter == maxIter) iter = 0;
    		double mu = 1.0 * iter / maxIter;
    		mu *= colorCount;
    		int iMu = (int) mu;
    		color c1 = colors[iMu]; // the color before the value mu
    		color c2 = colors[min(iMu + 1, colorCount)]; // the color right after mu
    		color res = linearInterpolation(c1, c2, mu - iMu);
    		pixels[x + y * width] = res;
    	}
	}
	// Method called to update the pixels
	updatePixels();
	// Text that changes while viewing the Mandebrot fractal
	String iterMsg = "Max Iteration: " + maxIter;
	String zoomMsg = "Zoom " + zoom;
	textSize(20);
	fill(238); // r, g, b
	text(iterMsg, 40, 40, 280, 40);
	text(zoomMsg, 40, 80, 280, 80);
}

// return the color corresponding to c1 + a * (c2 - c1)
// where "a" is a value between 0 and 1
color linearInterpolation(color c1, color c2, double a) {
    double newR = red(c1) + a * (red(c2) - red(c1));
    double newG = green(c1) + a * (green(c2) - green(c1));
    double newB = blue(c1) + a * (blue(c2) - blue(c1));
    return color((float)newR, (float)newG, (float)newB);
}

// Method for when mousewheel is used to navigate through the fractal
void mouseWheel(MouseEvent event) {
    if (event.getCount() > 0) maxIter /= 2;
    if (event.getCount() < 0) maxIter *= 2;
    maxIter = constrain(maxIter, 1, 2048);
}

// Method that executes its code when certain keys, arrow keys, are pressed
void keyPressed() {
    double w = (maxRe - minRe) * 0.3;
    double h = (maxIm - minIm) * 0.3;
    
    if (keyCode == UP) {
        maxIm -= h;
        minIm -= h;
    } else if (keyCode == DOWN) {
        maxIm += h;
        minIm += h;
    } else if (keyCode == LEFT) {
        maxRe -= w;
        minRe -= w;
    } else if (keyCode == RIGHT) {
        maxRe += w;
        minRe += w;
    }
}

// Method that helps to zoom in and zoom out of the fractal
void zoomWindow(double z) {
    // set new center point at mouse point
    double cr = minRe + (maxRe - minRe) * mouseX / width;
   	double ci = minIm + (maxIm - minIm) * mouseY / height;
   	// zoom
   	double tempMinr = cr - (maxRe - minRe) / 2 / z;
   	maxRe = cr + (maxRe - minRe) / 2 / z;
    minRe = tempMinr;
    
    double tempMini = ci - (maxIm - minIm) / 2 / z;
   	maxIm = ci + (maxIm - minIm) / 2 / z;
    minIm = tempMini;
}

// Method used to turn the value of both mouse buttons to false after one click
void mouseReleased() {
    if (leftPressed) leftPressed = false;
    if (rightPressed) rightPressed = false;
}
