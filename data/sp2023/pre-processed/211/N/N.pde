void setup() {
    size(1000, 1000, P3D);
    noStroke();
}

void draw() {
    lights();
	background(0, 0, 0);
	float camera1 = height / 4.0;
	float fov = mouseX / float(width) * PI/1.25; 
	float camera2 = camera1 / tan(fov / 4.0);
	float aspect = float(width) / float(height);
	if (mousePressed) {
		aspect = aspect / 1.0;
	}

	perspective(fov, aspect, camera2 / 10.0, camera2 * 10.0);

	translate(width / 2 + 30, height / 2.0);
	rotateX(-PI / 6);
	rotateY(PI / 3 + mouseY / float(height) * PI);
	sphere(100);
		fill(245, 99, 15);
		translate(-150, 0, 0);
	sphere (15);
		fill(100, 79, 38);
		translate(-145, 0, 0);
	sphere (25);
		translate(-160, 0, 0);
		fill(165, 108, 55);
	sphere (25);
		translate(-175, 0, 0);
		fill(61, 120, 201);
	sphere (15);
		translate(-190, 0, 0);
		fill(144, 80, 16);
	sphere (40);
		translate(-205, 0, 0);
		fill(188, 136, 84);
	sphere (30);
		fill(229, 184, 139);
}