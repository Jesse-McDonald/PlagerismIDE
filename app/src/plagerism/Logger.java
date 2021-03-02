package plagerism;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
public class Logger{
	public static String logfile="D:/test.txt";
	public static FileWriter logWriter;
	public static LinkedList<Entry> past;
	public static LinkedList<Entry> future;
	public static String label="typing";
	public static Logger init(){
		past=new LinkedList<Entry>();
		future=new LinkedList<Entry>();
		return init("D:/test.txt");
	}
	public static setLabel(String l){
		label=l;
		return new Logger();
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
	public static Logger add(int pos, String log){
		try{
			past.addFirst(new Event(pos,log,label));
		}catch(IOException e){}
		return new Logger();
	}
	public static Logger flush(){
		try{
			logWriter.flush();
		}catch(IOException e){}
		return new Logger();
	}
	public static Logger mark(){
		past.peek().mark();
		return new Logger();
	}
	public static Logger undo(){
		Entry top=past.pop();
		top.mark();
		while(!past.isEmpty()&&!top.landmark){
				future.addFirst(top);
				top=past.pop();
		}
		future.push(top);
		
	}
	public static Logger redo(){
		Entry top=future.pop();
		while(!past.isEmpty()&&!top.landmark){
				past.addFirst(top);
				top=future.pop();
		}
		past.push(top);
	}
	
}