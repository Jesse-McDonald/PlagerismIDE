package plagerism;
class BitArray{
	byte[] internal;
	public BitArray(byte[] init){
		reset(init);
	}
	public void reset(byte[] set){
		internal=set;
	}
	public void set(int i,boolean v){
		byte target=internal[i/8];
		byte iSub=(byte)(7-(i%8));
		byte mask=(byte)(1<<iSub);
		if(v){
			target=(byte)(target|mask);//bit setting
		}else{
			target=(byte)(target&(~mask));//bit smashing
		}
		internal[i/8]=target;
	}
	public boolean get(int i){
		byte target=internal[i/8];
		byte iSub=(byte)(7-(i%8));
		byte mask=(byte)(1<<iSub);
		return (target&mask)!=0;
	}

	public int length(){
		return size();
	}
	public int size(){
		return internal.length*8;
	}
	
	public byte[] toArray(){
		return internal;
	}
	public int flips(){
		int f=0;
		boolean side=false;
		for(int i=0;i<length();i++){
			if(get(i)!=side){
				side^=true;
				f++;
			}
		}
		return f;
	}
	public String toString(){
		String ret="";
		for(int i=0;i<internal.length;i++){
				ret+=String.format("%8.8s", Integer.toBinaryString(internal[i]&0xFF)).replace(' ', '0');
		}
		return ret;
	}
}