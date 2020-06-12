class Infected extends Human{

  int WIDTH=68;
  int HEIGHT=83;
  int speedX;
  int speedY;
  boolean isAppear;
  boolean upDownDirection;
  PImage[] cured_left;
  PImage[] cured_right;
  PImage[] curing;
  boolean isCuring;
  boolean isCured;
  
  int curingNum;
  int ranX = (int)(random(0,2));
  int ranY = (int)(random(0,2));
  int initX;
  int initY;
  
  Infected(){
    run_left = new PImage[SEQUENCE_SIZE];
    run_right = new PImage[SEQUENCE_SIZE];
    cured_left = new PImage[SEQUENCE_SIZE];
    cured_right = new PImage[SEQUENCE_SIZE];
    curing = new PImage[SEQUENCE_SIZE];
    
    sequenceInit(run_left,"infected/run_left/",SEQUENCE_SIZE);
    sequenceInit(run_right,"infected/run_right/",SEQUENCE_SIZE);
    sequenceInit(curing,"infected/curing/",SEQUENCE_SIZE);
    sequenceInit(cured_left,"infected/cured_left/",SEQUENCE_SIZE);
    sequenceInit(cured_right,"infected/cured_right/",SEQUENCE_SIZE);
    
    posX=-100;
    posY=-100;
    isCured=false;
    isAppear = false;
    curingNum=0;
    
  }
  void update(){
    if(!isCured && isAppear &&!isCuring){
      posX += speedX;
      posY += speedY;
    }
    if(isCured){
      posX -= speedX;
      posY -= speedY;
    }
  }
  void draw(){
    if(!isCured && isAppear &&!isCuring){
      if(direction){
        image(run_right[animation],posX-(WIDTH/2),posY-(HEIGHT/2));
      }else{
        image(run_left[animation],posX-(WIDTH/2),posY-(HEIGHT/2));
      }
    }
    if(isCuring){
      image(curing[curingNum],posX-(WIDTH/2),posY-(HEIGHT/2));
    }
    if(isCured){
       if(direction){
            image(cured_left[animation],posX-(WIDTH/2),posY-(HEIGHT/2));
        }else{
            image(cured_right[animation],posX-(WIDTH/2),posY-(HEIGHT/2));
        }
    }
    framePerSecond++;
    if(isCuring){
      curingNum++;
      if(curingNum==14){
        isCuring=false;
        isCured=true;
        curingNum=0;
      }
    }
    if(framePerSecond%2==0){
      animation++;
    }
    if(animation==SEQUENCE_SIZE){
      animation=0;
    }
  }
  void setPosition(int spdX,int spdY){
    
    // position set
    ranX = (int)(random(0,2));
    ranY = (int)(random(0,2));
    if(ranX==0){
      int tmp = (int)random(0,2);
      if(tmp<0){
        initX = -100;
        initY = (int)random(-100,700);
      }else{
        initX = (int)random(0,300);
        if(ranY==0){
          initY=-100;
        }else{
          initY=500;
        }
      }
    }else{
      int tmp = (int)random(0,2);
      if(tmp<0){
        initX = 700;
        initY = (int)random(-100,700);
      }else{
        initX = (int)random(300,600);
        if(ranY==0){
          initY=-100;
        }else{
          initY=500;
        }
      }
    }
    
    posX = initX;
    posY = initY; 
    if(initX<300){
      direction=true;
      if(spdX<0){speedX = -spdX;}
      else{ speedX = spdX;}
    }else{
      direction=false;
      if(spdX<0){speedX = spdX;}
      else{speedX = -spdX;}
    }
    if(initY<0){
      upDownDirection=false;
      if(spdY<0){speedY = -spdY;}
      else{speedY = spdY;}
    }else{
      upDownDirection=true;
        if(spdY<0){speedY = spdY;}
        else{speedY = -spdY;}
    }
    isAppear=true;
  }
}
