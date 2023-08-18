//if the box renders black, the test is successfull
//if it is red, close all instances of processing and try agian
//if that fails panic
class T extends Thread{
   void run(){
     while(true){
       color(255,0,0);
     }
   }
}
T t;
void setup(){
 t=new T();
 t.start();
}
void draw(){
   background(0); 
}