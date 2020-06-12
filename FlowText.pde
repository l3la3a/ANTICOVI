class FlowText{

  PImage background;
  PImage icon;
  PImage[] txts;
  int TXTSIZE=5;
  int posX;
  int posY;
  int currentText;
  int time; // circular 600
  
  FlowText(){
    background = new PImage();
    background = loadImage("resource/Txtbackground.png");
    posX=600;
    posY=27;
    txts = new PImage[TXTSIZE];
    for(int i=0; i<TXTSIZE; i++){
      txts[i] = new PImage();
      txts[i] = loadImage("resource/txt/txt_"+str(i)+".png");
    }
  }
  void draw(){
      image(background,0,500-posY);
      image(txts[currentText],posX,500-posY);
  }
  void update(){
   time++;
   if(time%600==0){
     time=0;
     currentText++;
     if(currentText==TXTSIZE){
       currentText=0;
     }
       posX=600;
   }
   posX-=2;
  
  }
  
}
