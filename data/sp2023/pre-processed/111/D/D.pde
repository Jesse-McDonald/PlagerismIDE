import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;

void setup(){
    size(500,500);
}
int y=100;
int vy=0;
void draw(){
	background(255,255,255);

    int x1, y1;
    boolean full;

		void paintComponent(Graphics g) {
        super.paintComponent(g);
        int shape;
        shape = (int)(Math.random() * 4);
    }

    ScreenSaver1() {
        t = new Timer(500, this);
        t.setDelay(500);
        t.start();
        frame.setUndecorated(true);
        frame.addKeyListener(new KeyHandler());
        frame.add(this);
        rectangle = GraphicsEnvironment.getLocalGraphicsEnvironment()
        .getDefaultScreenDevice().getDefaultConfiguration().getBounds();
        frame.setSize(rectangle.width, rectangle.height);
        frame.setVisible(true);
        full = true;
    }


class KeyHandler extends KeyAdapter {
    public void keyPressed(KeyEvent e) {
        if (e.getKeyChar() == 'x') {
            System.out.println("Exiting");
            System.exit(0);
        }
        else if (e.getKeyChar() == 'r') {
            System.out.println("Change background color");
            setBackground(new Color((int)(Math.random() * 256), (int)(Math.random() * 256), (int)(Math.random() * 256)));
            repaint();
        }
        else if (e.getKeyChar() == 'z') {
            System.out.println("Resizing");
            frame.setSize((int)rectangle.getWidth() / 2, (int)rectangle.getHeight());
        }
    }

}

private void makeLine(Graphics g) {
    int x = (int)(Math.random() * rectangle.getWidth());
    int y = (int)(Math.random() * rectangle.getHeight());
    int x1 = (int)(Math.random() * 100);
    int y1 = (int)(Math.random() * 100);
    g.setColor(new Color((int)(Math.random() * 256), (int)(Math.random() * 256), (int)(Math.random() * 256) ));
    g.drawLine(x, y, x1, y1);
}

private void makeRect(Graphics g) {
    int x = (int)(Math.random() * rectangle.getWidth());
    int y = (int)(Math.random() * rectangle.getHeight());
    int width = (int)(Math.random() * 100);
    int height = (int)(Math.random() * 100);
    g.setColor(new Color((int)(Math.random() * 256), (int)(Math.random() * 256), (int)(Math.random() * 256) ));
    g.drawRect(x, y, width, height);
}

private void makeOval(Graphics g) {
    int x = (int)(Math.random() * rectangle.getWidth());
    int y = (int)(Math.random() * rectangle.getHeight());
    int width = (int)(Math.random() * 100);
    int height = (int)(Math.random() * 100);
    g.setColor(new Color((int)(Math.random() * 256), (int)(Math.random() * 256), (int)(Math.random() * 256) ));
    g.drawOval(x, y, width, height);
}

private void makeRoundRect(Graphics g) {
    int x = (int)(Math.random() * rectangle.getWidth());
    int y = (int)(Math.random() * rectangle.getHeight());
    int width = (int)(Math.random() * 100);
    int height = (int)(Math.random() * 100);
    int arcWidth = (int)(Math.random() * width);
    int arcHeight = (int)(Math.random() * height);
    g.setColor(new Color((int)(Math.random() * 256), (int)(Math.random() * 256), (int)(Math.random() * 256) ));
    g.drawRoundRect(x, y, width, height, arcWidth, arcHeight);
}

public static void main(String[] args) 

}
