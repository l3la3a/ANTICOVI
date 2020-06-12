class Human{

  int posX;
  int posY;
 
  boolean direction;  //true : right, false : left;
  int animation=0;
  int framePerSecond=2;
  PImage[] run_left;
  PImage[] run_right;
    int SEQUENCE_SIZE=14;
  void sequenceInit(PImage[] images, String directory, int length){
    
    for(int i=0; i<length; i++){
      if(i<10){
        images[i] = loadImage("resource/"+directory+"00"+str(i)+".png");
      }else if(i>=10 && i <100){
        images[i] = loadImage("resource/"+directory+"0"+str(i)+".png");
      }else if(length>=100){
        images[i] = loadImage("resource/"+directory+str(i)+".png");
      }
    }
  }
}
