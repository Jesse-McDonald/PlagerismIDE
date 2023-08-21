// First I look at the resources provided to try it on my own, then resorted to videos
// I did this assigmentment by watching a video of another person creating the MandelBrot set
// I messed around with the variables to see what changes what
// and chaged some parts to my liking like color, zoom, etc

float len = 500;
float angle = 0;
void setup(){
     size(500,500);
     noStroke();
     fill(59,122,32);
     
}
void draw(){
	background(240,32,45);
	
	angle += 0.008;
//==============Variables=====================
	float w = abs(sin(angle))*5;
	float h = 0.89-(w * height) / width;

// start at negative half the width and height
	float xmin = -w/2;
	float ymin = -h/2;

// use if pixels[] array
	loadPixels();

// max # of iterations
	int maxiterations = 100;

// x and y from min to max
	float xmax = xmin + w;
	float ymax = ymin + h;

//calculate amount we increment x,y for each pixel
	float dx = (xmax-xmin)/ (width);
	float dy = (ymax-ymin)/ (height);    

//initialize y
	float y = ymin;
	for (int j = 0; j < height; j++){
    //initialize x
    float x = xmin;
    	for (int i=0; i < width; i++){
        
// test
        float a = x;
        float b = y;
        int n = 0;
        while (n < maxiterations){
            float aa = a*a;
            float bb = b*b;
            float twoab = 2.0 * a * b;
            a = aa - bb + x;
            b = twoab + y;
            
            if(aa*aa + bb*bb > 16.0){
                break;
            	}
            n++;
        	}
        
        if( n == maxiterations){
            pixels[i+j*width] = color(80,2,70);
        }
        else{
            pixels[i+j*width] = color(sqrt(float(n) / maxiterations));
        	}
        	x += dx;
    	}
    	y += dy;
	}
	updatePixels();
	println(frameRate);
}
