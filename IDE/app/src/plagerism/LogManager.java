package plagerism;
import java.util.HashMap;

public class LogManager{
	public static HashMap<String,LoggerQueue> logs=new HashMap<String,LoggerQueue>();
	public static LoggerQueue makeLog(String name){
		LoggerQueue ret=logs.get(name);
		if(ret==null){
			ret=new LoggerQueue();
			logs.put(name,ret);
		}
		return ret;
	}
	public static void rename(String oldName,String newName){
		if(!oldName.equals(newName)){
			LoggerQueue place=makeLog(oldName);
			logs.put(newName,place);
			remove(oldName);
		}
	}
	public static void remove(String name){
		logs.remove(name);
	}
	public static void set(String name, LoggerQueue in){
		logs.put(name,in);
	}
}