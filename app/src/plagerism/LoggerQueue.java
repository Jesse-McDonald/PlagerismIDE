package plagerism;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.security.SecureRandom;

import java.io.PrintWriter;
import java.io.StringWriter;
public class LoggerQueue{
	//public  String uuidStack;//add UUID after first full test
	//public  String projectUUID;
	//you want a uuid for the install, this should be tracked by all projects opened with that install
	//install uuid should also be embeded in pastes
	//you want a uuid for the project, this should be embeded in copy pastes
	public LinkedList<Entry> past;
	public LinkedList<Entry> future;
	public boolean futureSafe=false;
	public String label="T";//T for typing, C for copy (unused?), P for paste, X for cut, D for dummy
	
	public LoggerQueue setLabel(String l){
		label=l;
		return this;
	}
	public LoggerQueue(){
		past=new LinkedList<Entry>();
		future=new LinkedList<Entry>();
	}
	public  LoggerQueue add(int pos, String log){
		return add(pos,pos,log);
	}
	public  LoggerQueue add(int pos, int end, String log){
		//Logger.setLabel("queue");
		//Logger.add(pos,end,log);
		//Logger.setLabel("typing");
		if(!past.isEmpty()){
			Entry top=past.peek();
			if(!futureSafe){//the redo que neads cleared
				future.clear();
			}
			if(!top.landmark&&!top.isYoung()){
				consolidate();
			}
		}
		past.addFirst(new Entry(pos,end,log,label));

		return this;
	}
	public LoggerQueue consolidate(){
		LinkedList<Entry> now=new LinkedList<Entry>();
		while(!past.isEmpty()){//take off top edits
			Entry top=past.pop();
			if(top.landmark){
				past.addFirst(top);
				break;
			}else{
					now.addFirst(top);
			}
		}
		StringBuilder newEdit=new StringBuilder(now.size());
		boolean isTyping=false;
		int startPos=0;
		long startTime=0;
		while(!now.isEmpty()){
			Entry top=now.pop();
			if(top.label.equals("T")){//typing is the only thing that needs consolidating
				if(!isTyping){
					startPos=top.pos;
					startTime=top.timeStamp;
				}
				newEdit.append(top.set);
				isTyping=true;
			}else{
				if(isTyping){
					Entry insert=new Entry(startPos,startPos,newEdit.toString(),"T");
					insert.timeStamp=startTime;
					now.addFirst(insert);
					isTyping=false;
					newEdit=new StringBuilder(now.size());
				}		
				past.addFirst(top);
			}
		}		
		if(isTyping){
			Entry insert=new Entry(startPos,startPos,newEdit.toString(),"T");
			insert.timeStamp=startTime;
			past.addFirst(insert);	
		}
		System.out.println(newEdit);
		past.peek().mark();
		return this;
	}
	public String toString(){
		//Logger.save("Micro save");
		StringBuilder ret=new StringBuilder();

		Entry[] writeArray=new Entry[past.size()];
		past.toArray(writeArray);
		//String st="";
		//StringWriter sw = new StringWriter();
		//PrintWriter pw = new PrintWriter(sw);
		//(new Exception("No exception")).printStackTrace(pw);
		//st=sw.toString();
		ret.append("{InstallUUIDStack:[\"NotYetImplimented\"],ProjectUUIDStack:[\"NotYetImplimented\"],");
		ret.append("History:[");
		for(int i=writeArray.length-1;i>=0;i--){
			
			ret.append(writeArray[i].toString());
			if(i!=0){
				ret.append(",");
			}
		}
	ret.append("]}");
		return ret.toString();

	}
	public LoggerQueue fromString(String s){
		//parse json
		return this;
	}
	public String skimString(String s){
		int index1=s.lastIndexOf("\n",s.length()-1);
		int index=s.indexOf("//|",index1);
		String ret=s;
		if(index>0){
				index=s.indexOf("|{",index+1);
				fromString(s.substring(index));
				ret =s.substring(0,index1);
		}
		//parse json AND remove comment, then return string without comment
		
		return ret;
	}
	
	public LoggerQueue mark(){
		consolidate();
		return this;
	}
	public LoggerQueue undo(){
		mark();
		Entry top=past.pop();
		while(!past.isEmpty()&&!top.landmark){
				future.addFirst(top);
				top=past.pop();
		}
		future.push(top);
		return this;
	}
	public LoggerQueue timeTravel(boolean state){//call when travling through time to supress future flushing
		futureSafe=state;
		return this;
	}
	public LoggerQueue redo(){
		
		Entry top=future.pop();
		while(!past.isEmpty()&&!top.landmark){
				past.addFirst(top);
				top=future.pop();
		}
		past.push(top);
		return this;
	}
	//probiably dont need
	//also, probiably just use java.util.UUID
	public static String createUUID(){
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