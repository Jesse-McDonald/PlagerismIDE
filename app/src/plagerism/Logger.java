package plagerism;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.security.SecureRandom;

public class Logger{
	public static String logfile="D:/test.txt";
	//public static String uuidStack;//add UUID after first full test
	//public static String projectUUID;
	//you want a uuid for the install, this should be tracked by all projects opened with that install
	//install uuid should also be embeded in pastes
	//you want a uuid for the project, this should be embeded in copy pastes
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
	
	static String createUUID(){
		SecureRandom random=new SecureRandom();//I know, I know, a bit over kill for a uuid
		byte[] inter=random.generateSeed(16);
		inter[6]=(byte)((inter[6])|0x40);
		inter[6]=(byte)(inter[6]&0x4f);//sets 4 highest bits of 7th byte to 0100 because RFC4122 requires it for some reason
		inter[8]=(byte)(inter[8]|0x80);
		inter[8]=(byte)(inter[8]&0xbf);//sets 2 highest bits of 9th byte to 10 also for no good reason
		
		String ret="";
		for(int i=0;i<16;i++){
			if(i==4||i==6||i==8||i==10){
				ret+='-'; 
			}
			ret+=String.format("%02X",inter[i]);    
		}
		return ret;
	}
	
	
}