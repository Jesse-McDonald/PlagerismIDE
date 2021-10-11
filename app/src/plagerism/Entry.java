package plagerism;

import java.io.FileWriter;
import java.util.Base64;
import java.io.IOException;
import java.nio.ByteBuffer;
public class Entry{
		long timeStamp;//when was the edit
		int pos,endPos;//what position did the edit happen at?
		String set;//what was the edit
		String label;//was it typing, copy, cut, or paste (or other) (TCXPO)
		String notes;//random notes, will be used for paste UUIDs
		boolean landmark=false;//if ctrl z will the undo go past here
		public Entry(int pos, int end, String set, String label){
			this.pos=pos;
			endPos=end;
			this.set=set;
			this.label=label;
			timeStamp = System.currentTimeMillis();
			//System.out.println("DEBUG"+" "+ pos+" "+end);
			if(label.equals("T")&&set.equals("")){
				this.set="\\b["+pos+"-"+end+"]";//log backspace hopefully?
				//turns out backspace isnt making it this far?
				
				
			}
			
		}
		public Entry protect(){
			set=set.replace("\\","\\\\").replace("\"","\\\"").replace(String.format("%n"),"\\n").replace(String.format("\n"),"\\n");
			return this;
		}
		public Entry mark(){
			landmark=true;
			return this;
		}
		public boolean isYoung(){
			return (System.currentTimeMillis()-timeStamp)<2000;
		}
		public long limit(long timeStamp){//greatly shorten time stamps to appropriate durration
		//for my use, Years dont matter
		//Months dont really
		//and days barly dont
		//hours matter
		//as do minutes
		//and seconds
		//maybe even tenths
		//but everything smaller is also irrelevent now
		
		long reducer=10*60*60*24*30;
		long tenths=timeStamp/100;
		long month=tenths/reducer;
		long relevent=(tenths-month*reducer);
		//System.out.println(timeStamp);
		
		//System.out.println(tenths);
		//System.out.println(month);
		//System.out.println(relevent);
		
		//should cut timestamp in half at least
		return relevent;
		}
		public String longToBase64(long x) {
			ByteBuffer buffer = ByteBuffer.allocate(Long.BYTES);
			buffer.putLong(x);
			
			return Base64.getEncoder().encodeToString(buffer.array()).replaceAll("^A+", "");
		}
		public String toString(){
			StringBuilder ret=new StringBuilder();

			ret.append("{");
			ret.append("T:");
			ret.append(longToBase64(limit(timeStamp)));
			ret.append(",P:");
			if(pos==endPos){
				ret.append(""+pos);
			}else{
				ret.append(pos+"-"+endPos);
			}
			ret.append(",L:");
			ret.append("\""+label+"\"");
			ret.append(",E:");
			
			ret.append("\""+set+"\"");//make edit safe for json
			
			ret.append("}");
			if(notes!=null&&!notes.isEmpty()){
				ret.append(",N:\""+notes+"\"");
			}
			return ret.toString();
		}
		//public Entry add(String s){
		//	set.append(s);
		//	lastEdit=System.currentTimeMillis();
		//	return this;
		//}
		public Entry write(FileWriter logWriter) throws IOException{
			logWriter.write(this.toString());
			return this;
		}
}
