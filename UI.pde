class UI{

  FlowText flowtext;
  PImage backgroundImg;
  
  PImage[] numbers;
  int level; // (242,6)>(148,6)
  int timer; //60, (287,6)(309,6)
  int count;
  int cure; //(448,472)
  int curegoal; // level1 : 10, level2 : 20, level3 : 30  (514,538)
  boolean game;
  boolean clear;
  boolean gameOver;
  UI(){ 
    flowtext= new FlowText();
    backgroundImg = new PImage();
    backgroundImg = loadImage("resource/UI.png");
    
    numbers = new PImage[10];
    for(int i=0; i<10; i++){
      numbers[i] = new PImage();
      numbers[i] = loadImage("resource/numbers/number_"+str(i)+".png");
    }
    level=0;
    timer=60;
    count =0;
    cure=0;
    level=0;
    game=true;
    clear = false;
    gameOver = false;
  }
  void setGame(int lev){
    timer=60;
    count=0;
    cure=0;
    curegoal=(lev+1)*5;
    level = lev;
  }
  void draw(){
    if(game){
      image(backgroundImg,0,0);
      image(numbers[level+1],148,6);
      if(timer>=10){
        image(numbers[timer/10],287,6);
        image(numbers[timer%10],309,6);
      }else{
        image(numbers[0],287,6);
        image(numbers[timer%10],309,6);
      }
      if(cure>=10){
        image(numbers[cure/10],448,6);
        image(numbers[cure%10],472,6);
      }else{
        image(numbers[0],448,6);
        image(numbers[cure%10],472,6);
      }
      if(curegoal>=10){
        image(numbers[curegoal/10],514,6);
        image(numbers[curegoal%10],538,6);
      }else{
        image(numbers[0],514,6);
        image(numbers[curegoal%10],538,6);
      }
      flowtext.draw();
      flowtext.update();
    }
  }
  void update(){
    count++;
    if(count%60==0){
      timer--;
    }
    if(timer==0){
      game=false;
      gameOver=true;
    }
    if(timer==0){
      gameOver = true;
    }
    if(cure>=curegoal){
      clear=true;
    }
  }

}
