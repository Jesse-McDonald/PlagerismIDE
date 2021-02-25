package plagerism;
import java.io.FileWriter;
import java.io.IOException;
public class Logger{
	public static String logfile="D:/test.txt";
	public static FileWriter logWriter;
	public static Logger init(){
			return init("D:/test.txt");
	}
	
	public static Logger init(String log){
		try{
			if(logWriter!=null){
				
				logWriter.close();
				
			}
			logfile=log;
			logWriter=new FileWriter(logfile);
		}catch(IOException e){}
		return new Logger();
	}
	public static Logger close(String log){
		try{
			logWriter.close();
		}catch(IOException e){}
		return new Logger();
	}
	public static Logger add(String log){
		try{
			logWriter.write(log+"\n");
		}catch(IOException e){}
		return new Logger();
	}
	public static Logger flush(){
		try{
			logWriter.flush();
		}catch(IOException e){}
		return new Logger();
	}
	
}