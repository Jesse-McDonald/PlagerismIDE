/*Attempted to utilize the USB, but ended up just downloading the IDE. 
*In order to complete this assignmeent, I got helped from my peers 
*I also had searched up the solutions from NatureOfCode.com and CHAT GPT.
*/


class KochSnowflake {
  PVector start;
  PVector end;
  ArrayList<KochSnowflake> lines;

  KochSnowflake(PVector a, PVector b) {
    start = a.get();
    end = b.get();
  }

  void display() {
    stroke(0);
    line(start.x, start.y, end.x, end.y);
  }

  void setup() {
    size(600, 300);
    lines = new ArrayList<KochSnowflake>();
    PVector start = new PVector(0, 200);
    PVector end = new PVector(width, 200);
    lines.add(new KochSnowflake(start, end));
  }

  void draw() {
    background(255);
    for (KochSnowflake l : lines) {
      l.display();
    }
  }

  void generate() {
    ArrayList<KochSnowflake> next = new ArrayList<KochSnowflake>();
    for (KochSnowflake l : lines) {
      PVector a = l.kochA();
      PVector b = l.kochB();
      PVector c = l.kochC();
      PVector d = l.kochD();
      PVector e = l.kochE();

      next.add(new KochSnowflake(a, b));
      next.add(new KochSnowflake(b, c));
      next.add(new KochSnowflake(c, d));
      next.add(new KochSnowflake(d, e));
    }

    lines = next;
  }

  PVector kochA() {
    return start.get();
  }

  PVector kochB() {
    PVector v = PVector.sub(end, start);
    v.div(3);
    v.add(start);
    return v;
  }

  PVector kochC() {
    PVector a = start.get();
    PVector v = PVector.sub(end, start);
    v.div(3);
    v.rotate(-radians(60));
    a.add(v);
    return a;
  }

  PVector kochD() {
    PVector v = PVector.sub(end, start);
    v.mult(2f/3);
    v.add(start);
    return v;
  }

  PVector kochE() {
    return end.get();
  }
}
