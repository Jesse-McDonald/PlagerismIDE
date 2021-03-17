
import java.security.SecureRandom;
class TmpTst{
	public static void main(String[] args){
		System.out.println(createUUID());
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