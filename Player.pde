import ddf.minim.*;
import ddf.minim.analysis.*;

class Player extends Human{
  PImage[] idle_left;
  PImage[] idle_right;

  int WIDTH=68;
  int HEIGHT=83;
  boolean moving;
  boolean pressW;
  boolean pressA;
  boolean pressS;
  boolean pressD;
  boolean hit;
  boolean isDead;
   int speed;
  AntiviralDrug[] antiviruses;
  int antiviralCnt;
  int ANTIVIRAL_SIZE=20;
  int ANTIVIRAL_SPEED=15;
  Minim mim;
  Player(int _posX,int _posY,int _speed,Minim minim){
    posX = _posX;
    posY = _posY;
    speed = _speed;
    moving =false;
    idle_left = new PImage[SEQUENCE_SIZE];
    idle_right = new PImage[SEQUENCE_SIZE];
    run_left = new PImage[SEQUENCE_SIZE];
    run_right = new PImage[SEQUENCE_SIZE];
    pressW=false;
    pressA=false;
    pressS=false;
    pressD=false;
    isDead =false;
    hit = false;
    mim = minim;
    antiviruses = new AntiviralDrug[ANTIVIRAL_SIZE];
    for(int i=0; i<ANTIVIRAL_SIZE; i++){
      antiviruses[i] = new AntiviralDrug(ANTIVIRAL_SPEED,mim);
    }
    antiviralCnt=0;
    
    sequenceInit(idle_left,"player/idle_left/",SEQUENCE_SIZE);
    sequenceInit(idle_right,"player/idle_right/",SEQUENCE_SIZE);
    sequenceInit(run_left,"player/run_left/",SEQUENCE_SIZE);
    sequenceInit(run_right,"player/run_right/",SEQUENCE_SIZE);

  }
  void setAntiviral(int Mx,int My){
    //if(antiviruses[antiviralCnt].isDead){
      antiviruses[antiviralCnt] = new AntiviralDrug(ANTIVIRAL_SPEED,mim);
    //}
    antiviruses[antiviralCnt].create(posX,posY,Mx,My);
    antiviralCnt++;
    if(antiviralCnt==ANTIVIRAL_SIZE){
      antiviralCnt=0;
    }
  }
  void setDirection(int Mx,int My){
    if(Mx>posX){
      direction=true;
    }else{
      direction = false;
    }
  }
  void draw(){
    
    if(moving){
      if(direction){ image(run_right[animation],posX-(WIDTH/2),posY-(HEIGHT/2));
      }else{         image(run_left[animation],posX-(WIDTH/2),posY-(HEIGHT/2));
      }}else{
      if(direction){ image(idle_right[animation],posX-(WIDTH/2),posY-(HEIGHT/2));}
      else{          image(idle_left[animation],posX-(WIDTH/2),posY-(HEIGHT/2));}}
    framePerSecond++;
    if(framePerSecond%2==0){ animation++; }
    if(animation==SEQUENCE_SIZE){ animation =0; }
  }
  void update(int mx,int my){
    setDirection(mx,my);
    if(moving){
      if(pressA&&posX>WIDTH/2){
        posX -= speed;
      }else if(pressD&&posX<600-(WIDTH/2)){
        posX += speed;
      }
      if(pressW&&posY>(HEIGHT/2)+48){
        posY-=speed;
      }else if(pressS&&posY<500-(HEIGHT/2)-27){
        posY+=speed;
      }
    }
  }
  void collide(Infected[] people,int number){
    for(int i=0; i<number ;i++){
      if(!people[i].isCured){
        if(abs(people[i].posX-posX)<(WIDTH/3)*2){
          if(abs(people[i].posY-posY)<(HEIGHT/3)*2){
            hit=true;
          }
        }
      }
    }
  }
  void move(char key){
    if(key=='W'||key=='w'||key=='S'||key=='s'||key=='A'||key=='a'||key=='D'||key=='d'){
        moving =true;
      if(key=='W'||key=='w'){
        pressW=true;
      }else if(key=='S'||key=='s'){
        pressS=true;
      }
      if(key=='A'||key=='a'){
        pressA=true;
        //direction=false;
      }else if(key=='D'||key=='d'){
        pressD=true;
        //direction=true;
      }
    }else{
      moving =false;
      animation =0;
    }
  }
  void stop(char key){
    if(key=='W'||key=='w'){
      pressW=false;
    }
    if(key=='S'||key=='s'){
      pressS=false;
    }
    if(key=='D'||key=='d'){
      pressD=false;
    }
    if(key=='A'||key=='a'){
      pressA=false;
    }
    if(!pressW&&!pressS&&!pressD&&!pressA){
     moving =false; 
    }
  }
}
