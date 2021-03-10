package plagerism;

import java.io.FileWriter;

import java.io.IOException;
public class Entry{
		long timeStamp;//when was the edit
		int pos,endPos;//what position did the edit happen at?
		String set;//what was the edit
		String label;//was it typing, copy, or paste
		boolean landmark=false;//if ctrl z will the undo go past here
		public Entry(int pos, int end, String set, String label){
			this.pos=pos;
			endPos=end;
			this.set=set;
			this.label=label;
			timeStamp = System.currentTimeMillis();
		}
		public Entry mark(){
			landmark=true;
			return this;
		}
		public Entry write(FileWriter logWriter) throws IOException{
			logWriter.write("{");
			logWriter.write("timestamp:");
			logWriter.write(""+timeStamp);
			logWriter.write(",position:");
			if(pos==endPos){
				logWriter.write(""+pos);
			}else{
				logWriter.write(pos+"-"+endPos);
			}
			logWriter.write(",label:");
			logWriter.write("\""+label+"\"");
			logWriter.write(",edit:");
			
			logWriter.write("\""+set.replace("\\","\\\\").replace("\"","\\\"").replace(String.format("%n"),"\\n").replace(String.format("\n"),"\\n")+"\"");//make edit safe for json
			
			logWriter.write("}");
			return this;
		}
}
