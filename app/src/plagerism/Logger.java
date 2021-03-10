package plagerism;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
public class Logger{
	public static String logfile="D:/test.txt";

	public static LinkedList<Entry> past;
	public static LinkedList<Entry> future;
	public static boolean futureSafe=false;
	public static String label="typing";
	public static Logger init(){

		return init("D:/test.txt");
	}
	public static Logger setLabel(String l){
		label=l;
		return new Logger();
	}
	public static Logger init(String log){
			logfile=log;
			past=new LinkedList<Entry>();
			future=new LinkedList<Entry>();
			return new Logger();
	}
	public static Logger add(int pos, String log){
		return add(pos,pos,log);
	}
	public static Logger add(int pos, int end, String log){
		
		if(!futureSafe){//the redo que neads cleared
			future.clear();
		}
		past.addFirst(new Entry(pos,end,log,label));

		return new Logger();
	}
	public static Logger save(String currentFileContent){
		try{
			FileWriter logWriter=new FileWriter(logfile,false);
			logWriter.write("{");
			Entry[] writeArray=new Entry[past.size()];
			past.toArray(writeArray);
			logWriter.write("History:[");
			for(int i=writeArray.length-1;i>=0;i--){
				
				writeArray[i].write(logWriter);
				if(i!=0){
					logWriter.write(",");
				}
			}
			logWriter.write("],");
			logWriter.write("Code:\"");
			currentFileContent=currentFileContent.replace("\\","\\\\").replace("\"","\\\"").replace(String.format("%n"),"\\n").replace(String.format("\n"),"\\n");//make file safe for json
		
			logWriter.write(currentFileContent);
			logWriter.write("\"");
			logWriter.write("}");
			logWriter.flush();
			logWriter.close();
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
		return new Logger();
	}
	public static Logger timeTravel(boolean state){//call when travling through time to supress future flushing
		futureSafe=state;
		return new Logger();
	}
	public static Logger redo(){
		
		Entry top=future.pop();
		while(!past.isEmpty()&&!top.landmark){
				past.addFirst(top);
				top=future.pop();
		}
		past.push(top);
		return new Logger();
	}
	
}