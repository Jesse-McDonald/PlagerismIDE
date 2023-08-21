/**
 * I used a resource that was shared in an ICS discord
 * processing.org/examples/mandelbrot.html
**/
void setup(){
    size(640,360);
}

void draw(){
    background(255,255,255);
    
    float w = 4;
    float h = (w * height) / width;
    float xmin = -w/2;
    float ymin = -h/2;
    loadPixels();
    int maxiterations = 100;
    float xmax = xmin + w;
    float ymax = ymin + h;
    float dx = (xmax - xmin) / (width);
	float dy = (ymax - ymin) / (height);
	float y = ymin;
	for (int j = 0; j < height; j++) {
  		float x = xmin;
 		for (int i = 0; i < width; i++) {

    		// Now we test, as we iterate z = z^2 + c does z tend towards infinity?
    		float a = x;
    		float b = y;
    		int n = 0;
    		float max = 4.0;  // Infinity in our finite world is simple, let's just consider it 4
    		float absOld = 0.0;
    		float convergeNumber = maxiterations; // this will change if the while loop breaks due to non-convergence
    		while (n < maxiterations) {
     	     // We suppose z = a+ib
      			float aa = a * a;
            	float bb = b * b;
    	    	float abs = sqrt(aa + bb);
    	    	if (abs > max) { // |z| = sqrt(a^2+b^2)
    	       // Now measure how much we exceeded the maximum: 
    	    	float diffToLast = (float) (abs - absOld);
    	    	float diffToMax  = (float) (max - absOld);
    	    	convergeNumber = n + diffToMax/diffToLast;
    	    	break;  // Bail
    	      }
      		  float twoab = 2.0 * a * b;
      		  a = aa - bb + x; // this operation corresponds to z -> z^2+c where z=a+ib c=(x,y)
      		  b = twoab + y;
      		  n++;
      		  absOld = abs;
      		 }

      		 // We color each pixel based on how long it takes to get to infinity
      		 // If we never got there, let's pick the color black
      		 if (n == maxiterations) {
      		 	pixels[i+j*width] = color(0);
      		 } else {
      		 // Gosh, we could make fancy colors here if we wanted
      		 float norm = map(convergeNumber, 0, maxiterations, 0, 1);
      		 pixels[i+j*width] = color(map(sqrt(norm), 0, 1, 0, 255));
      		}
      		x += dx;
      	   }
		  y += dy;
		}
		updatePixels();
}