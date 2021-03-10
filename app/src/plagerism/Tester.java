package plagerism;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
public class Tester{
	public static void main(String[] args) throws FileNotFoundException{
		Logger.init();
		Logger.add(0,"\"");
		Logger.add(1,"h");
		Logger.add(2,"e");
		Logger.add(3,"l");
		Logger.add(4,"l");
		Logger.add(5,"o");
		Logger.mark();
		Logger.add(6," world\"");
		Logger.add(7,"\n");
		Logger.mark();
		Logger.add(8,"\"hello world\"");
		Logger.save("\"hello world\"\n\"hello world\"");
		Scanner echo =new Scanner(new File("D:/test.txt"));
		while(echo.hasNextLine()){
			System.out.println(echo.nextLine());
		}
		System.out.println();
		Logger.undo();
		Logger.save("\"hello world\"\n");
		echo =new Scanner(new File("D:/test.txt"));
		while(echo.hasNextLine()){
			System.out.println(echo.nextLine());
		}
		System.out.println();
		Logger.redo();
		Logger.save("\"hello world\"\n\"hello world\"");
		echo =new Scanner(new File("D:/test.txt"));
		while(echo.hasNextLine()){
			System.out.println(echo.nextLine());
		}
	}
	
}