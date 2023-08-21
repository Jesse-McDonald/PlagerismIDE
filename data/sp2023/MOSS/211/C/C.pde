import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import javax.swing.JFrame;

public class MandelbrotSet extends JFrame {

    private final int MAX_ITER = 1000;
    private final double ZOOM = 150;
    private BufferedImage image;

    public MandelbrotSet() {
        super("Mandelbrot Set");
        setBounds(100, 100, 800, 600);
        setResizable(false);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        image = new BufferedImage(getWidth(), getHeight(), BufferedImage.TYPE_INT_RGB);
        int[] colors = new int[MAX_ITER];
        for (int i = 0; i < MAX_ITER; i++) {
            colors[i] = Color.HSBtoRGB(i/256f, 1, i/(i+8f));
        }
        for (int y = 0; y < getHeight(); y++) {
            for (int x = 0; x < getWidth(); x++) {
                double zx = 0;
                double zy = 0;
                double cX = (x - 400) / ZOOM;
                double cY = (y - 300) / ZOOM;
                int iter = MAX_ITER;
                while (zx*zx + zy*zy < 4 && iter > 0) {
                    double tmp = zx*zx - zy*zy + cX;
                    zy = 2.0*zx*zy + cY;
                    zx = tmp;
                    iter--;
                }
                image.setRGB(x, y, iter == 0 ? 0 : colors[iter % MAX_ITER]);
            }
        }
    }

    @Override
    public void paint(Graphics g) {
        g.drawImage(image, 0, 0, this);
    }

    public static void main(String[] args) {
        MandelbrotSet mandelbrot = new MandelbrotSet();
        mandelbrot.setVisible(true);
    }

}

// i found this while googling mandelbrot set code for java
