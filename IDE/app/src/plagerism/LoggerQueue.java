package plagerism;
import processing.app.Platform;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.security.SecureRandom;
import java.util.Scanner;
import java.io.PrintWriter;
import java.io.StringWriter;

import java.util.UUID;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
public class LoggerQueue{
	public ArrayList<UUID> allInstalls;
	public UUID projectUUID=UUID.randomUUID();
	
	public ArrayList<UUID> infectionStack;
	public  UUID creatorUUID;
	public static UUID installUUID=installID();
	public String lastPasteNote;
	public boolean shield;//a hacky fix to the untraceable mark issue, shield the logger from mark for the entire problem function
	
	private String history=null;//changes from loaded file
	public LinkedList<Entry> past;//undo queue
	public LinkedList<Entry> future;//redo queue
	public boolean futureSafe=false;
	public String label="T";//T for typing, C for copy (unused?), P for paste, X for cut, D for dummy, M for move

	public String deject(String input){
		return ClipboardEncoder.decode(input,this);
	}
	public String inject(String input){
		return ClipboardEncoder.encode(input,this);
	}
	public LoggerQueue addInfection(UUID infection){
		if(!infectionStack.contains(infection)){
			infectionStack.add(infection);
		}
		return this;
	}
	private static UUID installID(){

		Platform.init();
		File installed=null;
		
		try{
			File settingsFolder=Platform.getSettingsFolder();	
			installed=new File(settingsFolder.getAbsolutePath()+"/installID");
		
			if(installed.exists()){
				Scanner s=new Scanner(installed);
				return UUID.fromString(s.nextLine());
		
			}
		}catch(Exception e){
		}
		UUID ret=UUID.randomUUID();
		try{
			PrintWriter pw=new PrintWriter(installed);
			pw.print(ret.toString());
			pw.flush();
			pw.close();
		}catch(FileNotFoundException e){
			
		}
		
	
		return ret;
		
	}
	//public  String uuidStack;//add UUID after first full test
	//public  String projectUUID;
	//you want a uuid for the install, this should be tracked by all projects opened with that install
	//install uuid should also be embeded in pastes
	//you want a uuid for the project, this should be embeded in copy pastes

	public LoggerQueue setLabel(String l){
		label=l;
		return this;
	}
	LoggerQueue(){
		history=null;
		past=new LinkedList<Entry>();
		future=new LinkedList<Entry>();
		allInstalls=new ArrayList<UUID>();
		infectionStack=new ArrayList<UUID>();
		creatorUUID=installUUID;
		allInstalls.add(installUUID);
		infectionStack.add(projectUUID);
	}
	public LoggerQueue add(int pos, String log){
		return add(pos,pos,log);
	}
	/*turns out carrotMoves arent logged
	public LoggerQueue carrotMove(int start, int end){
		if(!futureSafe){//the redo que neads cleared
			future.clear();
		}
		mark();
		past.addFirst(new Entry(start,end,"","M"));
		past.peek().mark();
		return this;
	}
	*/
	
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
		
		Entry insert=new Entry(pos,end,log,label);
		if(label.equals("P")){
			insert.notes=lastPasteNote;
			lastPasteNote="";
		}
		insert.protect();
		//if(pos!=end){
			//insert.mark();
		//}			
		past.addFirst(insert);
	
		return this;
	}
	public LoggerQueue consolidate(){
		LinkedList<Entry> now=new LinkedList<Entry>();//start temprary list to hold current merge
		while(!past.isEmpty()){//if there is stuff in the past
			Entry top=past.pop();//get it
			if(top.landmark){
				past.addFirst(top); 
				break;
			}else{
					now.addFirst(top);//otherwise add it to the queue
			}
		}
		StringBuilder newEdit=new StringBuilder(now.size());//prep string builder for consolkidated edit
		boolean isTyping=false;
		int startPos=0;
		int endPos=-1;
		long startTime=0;
		while(!now.isEmpty()){
			Entry top=now.pop();
			if(top.label.equals("T")){//typing is the only thing that needs consolidating
				//System.out.println("Popped: "+top);
				if(!isTyping){
					startPos=top.pos;
					if(top.pos!=top.endPos){
						endPos=top.endPos;
					}
					startTime=top.timeStamp;
				}
				newEdit.append(top.set);
				isTyping=true;
				
			}else{
				if(isTyping){
	
					if(endPos==-1){
						endPos=startPos;
					}
					Entry insert=new Entry(startPos,endPos,newEdit.toString(),"T");
					//System.out.println("Pushing: "+insert);
					endPos=-1;
					insert.timeStamp=startTime;
					now.addFirst(insert);
					isTyping=false;
					newEdit=new StringBuilder(now.size());
				}		
				past.addFirst(top);
				
			}
		}		
		if(isTyping){
			if(endPos==-1){
				endPos=startPos;
			}
			Entry insert=new Entry(startPos,endPos,newEdit.toString(),"T");
			//System.out.println("last push: "+insert);
			insert.timeStamp=startTime;
			past.addFirst(insert);	
			
		}
		if(!past.isEmpty()){
			past.peek().mark();
		}
		//System.out.println(newEdit);
		return this;
	}
	public static void stackTrace(){
		
		String st="";
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		(new Exception("No exception")).printStackTrace(pw);
		st=sw.toString();
		System.out.println(st);
	}
	public String jsonify(ArrayList in){
		String ret="[";
		for(int i=0;i<in.size();i++){
			if(i!=0){
				ret+=",";
			}
			ret+="\""+in.get(i)+"\"";
		}
		return ret+"]";
	}
	public String toString(){
		consolidate();
		//Logger.save("Micro save");
		StringBuilder ret=new StringBuilder();

		
		
		ret.append("{\"InstallUUIDStack\":"+jsonify(allInstalls)+",\"InfectionStack\":"+jsonify(infectionStack)+",\"ProjectUUID\":\""+projectUUID+"\",\"CreatorUUID\":\""+creatorUUID+"\",");
		ret.append("\"History\":[");
		boolean first=false;
		if(history!=null){
			ret.append(history);
			first=true;
		}
		Entry[] writeArray=new Entry[past.size()];
		past.toArray(writeArray);
		for(int i=writeArray.length-1;i>=0;i--){
			//if(!writeArray[i].label.equals("M")){
				if(first){
					ret.append(",");
				}else{
					first=true;
				}
				ret.append(writeArray[i].toString());
			//}
			
		}
		ret.append("]}");
		return ret.toString();

	}
	public LoggerQueue fromString(String s)throws Exception{
		return fromString(s,false);
	}
	public LoggerQueue fromString(String s,boolean important)throws Exception{
		//{
		//InstallUUIDStack:[],
		//InfectionStack:[],
		//ProjectUUID:"",
		//CreatorUUID:"",
		//History:[{T:"",P:"",L:"",E:""},{T:"",P:"",L:"",E:"",N:""}]
		//}
		
		
		//parse json
		//extract installs
		String lookFor="InstallUUIDStack:[";
		int x=s.indexOf(lookFor)+lookFor.length();
		if(x<lookFor.length()){
			throw new Exception("index error on load");
		}
			
				int y=s.indexOf("]",x);
				String process=s.substring(x,y);
				String[] sub=process.split(",");
				for(String micro: sub){
					try{
						UUID uuid=UUID.fromString(micro.replace("\"",""));
						if(!uuid.equals(allInstalls.get(allInstalls.size()-1))){
								allInstalls.add(uuid);
						}
					
					}catch(IllegalArgumentException e){}
				}
				//extract infection
				lookFor="\"InfectionStack\":[";
				x=s.indexOf(lookFor)+lookFor.length();
				if(x<lookFor.length()){
					throw new Exception("index error on load");
				}
				y=s.indexOf("]",x);
				process=s.substring(x,y);
				sub=process.split(",");
				for(String micro: sub){
					try{
						UUID uuid=UUID.fromString(micro.replace("\"",""));
						if(!uuid.equals(infectionStack.get(infectionStack.size()-1))){
								infectionStack.add(uuid);
						}
					}catch(IllegalArgumentException e){}
				}
				//extract project UUID
				lookFor="\"ProjectUUID\":";
				x=s.indexOf(lookFor)+lookFor.length();
				if(x<lookFor.length()){
					throw new Exception("index error on load");
				}
				y=s.indexOf(",",x);
				process=s.substring(x,y);
				//System.out.println(process);
				projectUUID=UUID.fromString(process.replace("\"",""));
				//extract creator UUID
				lookFor="CreatorUUID:";
				x=s.indexOf(lookFor)+lookFor.length();
				if(x<lookFor.length()){
					throw new Exception("index error on load");
				}
				y=s.indexOf(",",x);
				process=s.substring(x,y);
				creatorUUID=UUID.fromString(process.replace("\"",""));
				//mine history
				if(past.isEmpty()||important){
					lookFor="\"History\":[";

					x=s.indexOf(lookFor)+lookFor.length();
					//if(x>0){//I just realized this will always be true because of the +
					boolean quotesOn=false;
					int i;
					for(i=x;i<s.length();i++){
						char a=s.charAt(i);
						if(a=='"'){
							quotesOn^=true;
						}
						if(!quotesOn){
							if(a=='\\'){
								i++;
							}if(a==']'){
								
								
								//System.out.print(history);
								break;
							}
							
						}
					}
					history=s.substring(x,i);
					//}
				}
			
		
		return this;
	}
	public String skimString(String s){//parse json AND remove comment, then return string without comment
		
		int index1=s.lastIndexOf("\n",s.length()-1);
		int index=s.indexOf("//|",index1);
		String ret=s;
		if(index>=0){
			index=s.indexOf("|{",index+1);
			try{
				
				fromString(s.substring(index));
				
			}catch(Exception e){
				if(s.length()>2){
					history="{T:"+System.currentTimeMillis()+",\"P\":0,\"L\":\"O\",\"E\":\"Error loading file\",\"N\":\""+protect(s)+"\"}";
				}
			}
			ret =s.substring(0,index1);
		}else{
			if(s.length()>2){
				history="{T:"+System.currentTimeMillis()+",\"P\":0,\"L\":\"O\",\"E\":\"Untracked file loaded\",\"N\":\""+protect(s)+"\"}";
			}
		}
		
		return ret;
	}
	
	public LoggerQueue mark(){
		if(!shield){
			consolidate();
			if(!past.isEmpty()){
				past.peek().mark();
			}
		}
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
		if(!future.isEmpty()){
			Entry top=future.pop();
			while(!past.isEmpty()&&!top.landmark){
					past.addFirst(top);
					top=future.pop();
			}
			past.push(top);
		}
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

	public LoggerQueue backspace(int pos, int end){
		add(pos,end,"");
		if(pos==end){
			past.peek().set="\\b";
		}
		return this;
	}
	
	public LoggerQueue delete(int pos, int end){
		add(pos,end,"");
		past.peek().set="\\d";
		return this;
	}
	public String protect(String s){
			return s.replace("\\","\\\\").replace("\"","\\\"").replace(String.format("%n"),"\\n").replace(String.format("\n"),"\\n");
			
		}
}