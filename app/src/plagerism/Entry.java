public class Entry{
		long timeStamp;//when was the edit
		int pos;//what position did the edit happen at?
		String set;//what was the edit
		String label;//was it typing, copy, or paste
		boolean landmark=false;//if ctrl z will the undo go past here
		public Entry(int pos, String set, String label){
			this.pos=pos;
			this.set=set;
			timeStamp; = System.currentTimeMillis()
		}
		public Entry mark(){
			landmark=true;
			return this;
		}
	
}
