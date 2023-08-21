class Ball{
    int x, y, vx, vy;
    color c;
    Ball (int x, int y, color c){
        this.x=x;
        this.y=y;
        this.c=c;
    }
    void update() {
        fill(c);
        x += vx;
        y += vy;
        circle(x, y, 20);
        if (y > height) {
    		y = height;
    		vy *= -1;
		}
        vy++;
    }
}
Ball[] balls = new Ball[3];
void setup(){
    size(500, 500);
    balls[0] = new Ball(100, 100, color(255, 0, 0));
    balls[1] = new Ball(200, 200, color(0, 255, 0));
    balls[2] = new Ball(300, 300, color(0, 0, 255));
}
int y = 100;
int vy = 0;
void draw(){
	background(250, 159, 227);
	fill(255, 0, 0);
	for (int i = 0; i < balls.length; i++) {
    	balls[i].update();
	}
}