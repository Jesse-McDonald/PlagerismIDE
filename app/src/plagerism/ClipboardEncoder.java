package plagerism;
import java.util.ArrayList;
import java.util.UUID;
class ClipboardEncoder{
	char ec=0x200B;//zero width space, only detectable by the arrow keys
	String Ec=""+ec;
	public ArrayList<UUID> allInstalls;
	public UUID projectUUID;
	
	public ArrayList<UUID> infectionStack;
	public UUID creatorUUID;
	public UUID installUUID;
	public int integrity;//0 nothing gathered,1 part of creatorUUID, 2 part of project uuid, 3 part of install uuid, 4 part of infectionStack, 5 part of allInstalls, 6 data is fine
	public int fractional;//bytes into fractional value
	private ClipboardEncoder(){//wow, I have never made all constructors private before.  Exciting!
		infectionStack=new ArrayList<UUID>();
		allInstalls=new ArrayList<UUID>();
	}
	private String repeat(String base, int n){
		String ret="";
		for(int i=0;i<n;i++){
			ret+=base;
		}
		
		return ret;
	}
	public static String encode(String base, LoggerQueue data){
		ClipboardEncoder use=new ClipboardEncoder();
		use.init(data);
		return use._encode(base);
	}
	
	public void init(LoggerQueue data){
		allInstalls=data.allInstalls;
		projectUUID=data.projectUUID;
		infectionStack=data.infectionStack;
		creatorUUID=data.creatorUUID;
		installUUID=data.installUUID;
	}
	
	//sentinal, Char,8ec,char,char,pattern,char,char,8ec,char,char,repeat
	//          ^  look to start ^         ^  look for end  ^ 
	//reset to 0 at start of pattern
	//ORDER
	//installUUID ProjectUUID creatorUUID infectionStack allInstalls
	public String _encode(String base){
		int firstChar=-1;
		int lastChar=-1;
		for(int i = 0; i < base.length(); i++){//find first and last non whitespace character.  Safer for paste.
			if(!Character.isWhitespace(base.charAt(i))){
				if(firstChar==-1){
					firstChar=i;
				}
				lastChar=i;
			}
		}
		if(firstChar==-1){
			return base;
		}
		byte[]all=new byte[16*(allInstalls.size()+infectionStack.size()+3)+2];
		int i=0;
		byte[] uuid=UUIDAdapter.getBytesFromUUID(installUUID);
		for(int j=0;j<16;i++,j++){
			all[i]=uuid[j];
		}
		uuid=UUIDAdapter.getBytesFromUUID(projectUUID);
		for(int j=0;j<16;i++,j++){
			all[i]=uuid[j];
		}
		uuid=UUIDAdapter.getBytesFromUUID(creatorUUID);
		for(int j=0;j<16;i++,j++){
			all[i]=uuid[j];
		}
		all[i]=(byte)(infectionStack.size()&0xFF);
		i++;
		for(int k=0;k<(infectionStack.size()&0xFF);k++){
			uuid=UUIDAdapter.getBytesFromUUID(infectionStack.get(k));
			for(int j=0;j<16;i++,j++){
				all[i]=uuid[j];
			}
		}
		all[i]=(byte)(allInstalls.size()&0xFF);
		i++;;
		for(int k=0;k<(allInstalls.size()&0xFF);k++){
			uuid=UUIDAdapter.getBytesFromUUID(allInstalls.get(k));
			for(int j=0;j<16;i++,j++){
				all[i]=uuid[j];
			}
		}
		int flips=lastChar-firstChar;
		if(flips<6){//nit even enough flips to even encode a header/footer
		
			return base;
		}else{
			
			BitArray bits=new BitArray(all);
			//System.out.println(bits);
			String header=base.substring(0,firstChar+1)+repeat(Ec,8)+base.substring(firstChar+1,firstChar+3);
			String dataLayer=base.substring(firstChar+3,lastChar-3);
			int j=0;
			i=0;
			int c=0;
			boolean state=false;
			String dataReturn="";
			while(true){//the exit condition is fairly advanced 
				if(i<bits.size()){
					if(bits.get(i)==state){
						dataReturn+=ec;
					}else{
						if(j<dataLayer.length()){
							state=bits.get(i);
							dataReturn+=dataLayer.charAt(j);
							dataReturn+=ec;
							j++;
						}else{
							break;//out of characters to encode WITH
						}
					}
					i++;
				}else{
					if(j+4<dataLayer.length()){//repeat
						i=0;
						c++;
						dataReturn+=dataLayer.charAt(j);
						j++;
						dataReturn+=dataLayer.charAt(j);
						j++;
						dataReturn+=repeat(Ec,8);
						dataReturn+=dataLayer.charAt(j);
						j++;
						dataReturn+=dataLayer.charAt(j);
						j++;
					}else{//not enough character left to encode repeat flag
						break;
					}
				}
			}
			String footer=base.substring(lastChar-3,lastChar-1)+repeat(Ec,8)+base.substring(lastChar-1,base.length());
			//System.out.println("\""+header+"[]"+dataReturn+"[]"+footer+"\"");
			return header+dataReturn+footer;
		}
		/* I decited to just go for it, if we run out of room revert state
		if(flips<8+iflips){//install pattern is most important
			
		}else if(flips<8+iflips+pflips){//project second most imporntant
			
		}else if(flips<8+iflips+pflips+cflips){//creator third most
		
		}else if(flips<8+tflips){//if we cant encode everything, repeat the 3 for as long as possible
			
		}else{//we have enough room to encode everything, go for it
			
		}
		*/

	}
	//0,1 installUUID,2 ProjectUUID,3 creatorUUID,4 infectionStack,5 allInstalls,6
	private static boolean partialUUIDMatch(UUID a, UUID b, int bytes){
		if(bytes<0){
			return true;
		}
		return false;
	}
	public static String decode(String base, LoggerQueue data){
		ClipboardEncoder use=new ClipboardEncoder();
		String ret=use._decode(base);
			String note="";
		
		if(use.integrity!=0){
			byte sameInstall=0;
			byte sameProject=0;
			byte sameCreator=0;
			//ok ok, what are we going to do....
			if(use.integrity==1){
				if(partialUUIDMatch(data.installUUID,use.installUUID,use.fractional)){
						sameInstall=1;
				}else{
					sameInstall=-1;
				}
				
			}else if(use.integrity>1){
				if(data.installUUID.equals(use.installUUID)){
					sameInstall=2;
				}else{
					sameInstall=-2;
					data.addInfection(use.installUUID);
				}
			}
			if(use.integrity==2){
				if(partialUUIDMatch(data.projectUUID,use.projectUUID,use.fractional)){
						sameProject=1;
				}else{
					sameProject=-1;
				}
				
			}else if(use.integrity>2){
				if(data.projectUUID.equals(use.projectUUID)){
					sameProject=2;
				}else{
					sameProject=-2;
					data.addInfection(use.projectUUID);
				}
			}
			if(use.integrity==3){
				if(partialUUIDMatch(data.projectUUID,use.projectUUID,use.fractional)){
						sameProject=1;
				}else{
					sameProject=-1;
				}
				
			}else if(use.integrity>3){
				if(data.creatorUUID.equals(use.creatorUUID)){
					sameCreator=2;
				}else{
					sameCreator=-2;
					data.addInfection(use.creatorUUID);
				}
			}
			if(sameProject>0){
				note="internal paste;";
			}else if(sameCreator>0){
				note="paste from project with same creator;";
			}else if(sameInstall>0){
				note="paste from project on same machine;";
			}
			
			if(sameProject==-1){
				note+="Paste from project with UUID fragment "+use.projectUUID.toString()+" "+use.fractional+" bytes long;";
			}else if(sameProject==-2){
				note+="Paste from project with UUID "+use.projectUUID.toString()+";";
			}
			if(sameInstall==-1){
				note+="Paste from install with UUID fragment "+use.projectUUID.toString()+" "+use.fractional+" bytes long;";
			}else if(sameInstall==-2){
				note+="Paste from install with UUID "+use.projectUUID.toString()+";";
			}
			if(sameCreator==-1){
				note+="Paste from creator with UUID fragment "+use.projectUUID.toString()+" "+use.fractional+" bytes long;";
			}else if(sameCreator==-2){
				note+="Paste from creator with UUID "+use.projectUUID.toString()+";";
			}
			
			if(use.integrity==4){
				for(int i=0;i<use.fractional/16&&i<use.infectionStack.size();i++){
					data.addInfection(use.infectionStack.get(i));
				}
			}else if(use.integrity>4){
				for(int i=0;i<use.infectionStack.size();i++){
					data.addInfection(use.infectionStack.get(i));
				}
			}
			if(use.integrity==5){
				for(int i=0;i<use.fractional/16&&i<use.allInstalls.size();i++){
					data.addInfection(use.allInstalls.get(i));
				}
			}else if(use.integrity>5){
				for(int i=0;i<use.allInstalls.size();i++){
					data.addInfection(use.allInstalls.get(i));
				}
			}
		}else{
			if(ret.length()>8){
				note="Paste from noncoded source";
			}
			
		}
		data.lastPasteNote=note;
		return ret;
	}
	public String _decode(String base){
		int c=0;
		String ret=base.replace(Ec,"");
		String working="";//I am treating the bits as a string so that I can use string operations on them.
		//it is more data efficient to use bits, but I dont get .indexOf on that
		for(int i=0;i<base.length();i++){
			if(base.charAt(i)==ec){
				working+='1';
			}else{
				working+='0';
			}
		}
		boolean superBreak=false;
		int starDex=working.indexOf("01111111100");
		if(starDex<0){
			integrity=0;
			//System.out.println(starDex);
			//System.out.println(working);
			return ret;
		}
		starDex+=11;
		int enDex=working.indexOf("00111111110",starDex);
		if(enDex<0){
			enDex=working.length();
		}

		working=working.substring(starDex,enDex);
		//System.out.println(working);
		for(int i=0;i<working.length();i++){
			if(working.charAt(i)=='1'){
				c++;
			}
		}
		byte[] bytes=new byte[c/8+1];
		BitArray bits=new BitArray(bytes);
		boolean state=false;
		int j=0;
		for(int i=0;i<working.length();i++){
			if(working.charAt(i)=='1'){
				bits.set(j,state);
				j++;
			}else{
				state^=true;
			}
		}
		if(!superBreak){
				integrity=1;
			}
		
		//System.out.println();
		//System.out.println(bits);
		bytes=bits.internal;
		byte[] uuid=new byte[16];
		j=0;
		for(int i=0;i<16;i++){
			if(j>=bytes.length){
				superBreak=true;
				fractional=i-1;
				break;
			}
			uuid[i]=bytes[j];
			j++;
		}
		installUUID=UUIDAdapter.getUUIDFromBytes(uuid);
		if(!superBreak){
				integrity=2;
			}
		uuid=new byte[16];
		for(int i=0;i<16;i++){
			if(j>=bytes.length){
				superBreak=true;
				fractional=i-1;
				break;
			}
			uuid[i]=bytes[j];
			j++;
		}
		if(!superBreak){
				integrity=3;
			}
		projectUUID=UUIDAdapter.getUUIDFromBytes(uuid);
		uuid=new byte[16];
		for(int i=0;i<16;i++){
			if(j>=bytes.length){
				superBreak=true;
				fractional=i-1;
				break;
			}
			uuid[i]=bytes[j];
			j++;
		}
		creatorUUID=UUIDAdapter.getUUIDFromBytes(uuid);
		if(!superBreak){
				integrity=4;
			}
		if(j<bytes.length){
			int count=bytes[j]&0xFF;
			
			//System.out.println(count);
			j++;
			infectionStack=new ArrayList<UUID>();
			for(int k=0;k<count&&!superBreak;k++){
				uuid=new byte[16];
				for(int i=0;i<16;i++){
					if(j>=bytes.length){
						superBreak=true;
						fractional=(i-1)+(k*16);//16 bytes in a uuid,  and we are in the k uuid
						break;
					}
					uuid[i]=bytes[j];
					j++;
				}
				infectionStack.add(UUIDAdapter.getUUIDFromBytes(uuid));
			}
			
		}
		if(!superBreak){
				integrity=5;
			}
		if(j<bytes.length){
			int count=bytes[j]&0xFF;
			//System.out.println(count);
			j++;
			allInstalls=new ArrayList<UUID>();
			for(int k=0;k<count&&!superBreak;k++){
				uuid=new byte[16];
				for(int i=0;i<16;i++){
					if(j>=bytes.length){
						superBreak=true;
						fractional=(i-1)+(k*16);//16 bytes in a uuid,and we are in the k uuid
						break;
					}
					uuid[i]=bytes[j];
					j++;
				}
				allInstalls.add(UUIDAdapter.getUUIDFromBytes(uuid));
			}
			
		}
		if(!superBreak){
				integrity=6;
			}
		return ret;
	}
	
}