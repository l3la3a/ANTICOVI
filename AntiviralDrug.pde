import ddf.minim.*;
import ddf.minim.analysis.*;

class AntiviralDrug{
  int posX;
  int posY;
  int speed;
  int WIDTH=15;
  int HEIGHT=15;
  float costheta;
  float sintheta;
  boolean isCreated;
  boolean isDead;
  boolean collision;
  PImage img;
  int minDistance=20;
  
  AudioPlayer shoot;
  AudioPlayer curing;
  
  AntiviralDrug(int _speed,Minim minim){
    speed = _speed;
    isDead=false;
    isCreated=false;
    collision=false;
    img = new PImage();
    img = loadImage("resource/antiviral.png");
    posX=-500;
    posY=-500;
    
    shoot = minim.loadFile("resource/sound/pop.mp3");
    curing = minim.loadFile("resource/sound/heal.mp3");
    
  }
  void draw(){
    if((!isDead)&&isCreated){
      image(img,posX-(WIDTH/2),posY-(HEIGHT/2));
    }
  }
  void create(int ppx,int ppy, int Mx,int My){
    isDead=false;
    isCreated=true;
    float dst = sqrt(pow(Mx-ppx,2)+pow(My-ppy,2));
    costheta = (Mx-ppx)/dst;
    sintheta = (My-ppy)/dst;

    posX = ppx;
    posY = ppy;
    shoot.play();
  }
  void update(UI ui,int WINDOWWIDTH,int WINDOWHEIGHT,Infected[] people,int peoplesize){
    if(posX>WINDOWWIDTH || posX<0 || posY<0 || posY>WINDOWHEIGHT || collision)
      { isDead = true; 
              posX=-500;
              posY=-500;
            }
      if((!isDead)&&isCreated){
       posX+=speed*costheta;
       posY+=speed*sintheta;

    }
    if(isCreated){ //if AntiviralDrug get out of the window, then AD dies. 
      for(int i=0; i<peoplesize; i++){
        if(!people[i].isCured&&people[i].isAppear){
          if(abs(people[i].posX - posX)<minDistance){
            if(abs(people[i].posY - posY)<minDistance){
              collision=true;
              people[i].isCuring=true;
              posX=-500;
              posY=-500;
              ui.cure++;
              curing.play();
            }
          }
        }
      }
      
    }
  }
  
}
