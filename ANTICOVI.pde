
import ddf.minim.*;
import ddf.minim.analysis.*;


PImage background;
PImage img;
PImage[] imgs;
int time;
Player player;
Infected infected;
Infected[] patients;
UI ui;
int PATIENTS_SIZE=20;
int len; 
int WINDOW_WIDTH=600;
int WINDOW_HEIGHT=500;
int scene;
PImage lose;
PImage win;
PImage introImg;

Sound soundManager;

Minim minim;
AudioPlayer song;
QuizManager quiz;

void setup(){
  size(600,500);
  soundManager = new Sound();
  minim = new Minim(this);
  background = new PImage();
  lose = new PImage();
  win = new PImage();
  lose = loadImage("resource/lose.png");
  win = loadImage("resource/win.png");
  background = loadImage("resource/background.png");
  introImg = loadImage("resource/intro.png");
  time=0;
  player = new Player(WINDOW_WIDTH/2,WINDOW_HEIGHT/2,5,minim);
  infected = new Infected();
  patients = new Infected[PATIENTS_SIZE];
  for(int i=0; i<PATIENTS_SIZE; i++){
    patients[i] = new Infected();
  }
  len = 0;

  infected.setPosition((int)(random(3,6)),(int)(random(3,6)));
  
  song = minim.loadFile(soundManager.BGMname);
  song.play();
  song.loop();
  soundManager.setEffectSound(minim);
  scene   = 3;

  //ui.clear=true;
}

void draw(){
  if(scene==0){
    if(!ui.gameOver){
      time++;
      image(background,0,0);
      player.update(mouseX,mouseY);
      player.draw();
      infected.update();
      infected.draw();
      player.collide(patients,len);
      if(player.hit==true){
        //if collision happen, what would it does 
        ui.gameOver=true;
      }
      if(time%30==0){
        int tmp = (int)random(0,2);
        if(tmp==0){
          patients[len] = new Infected();
          patients[len].setPosition((int)random(2,6),(int)(random(2,6)));
          len++;
          if(len==PATIENTS_SIZE){
            len=0;
          }
        }
      }
        for(int i=0; i<PATIENTS_SIZE; i++){
        if(patients[i].isAppear){
            patients[i].update();
            patients[i].draw();
         }
      }
      for(int i=0; i<player.ANTIVIRAL_SIZE;i++){
        if(player.antiviruses[i].isCreated){
            player.antiviruses[i].draw();
            player.antiviruses[i].update(ui,WINDOW_WIDTH,WINDOW_HEIGHT,patients,PATIENTS_SIZE);
        }
      }
      ui.update();
      ui.draw();
      if(ui.clear){
        quiz.quizset();
        song.pause();
        if(ui.level==2){
          scene=2;  
        }else{
        scene=1;
      }
      }
    }else{
      image(lose,0,0);
      song.pause();
    }
  }else if(scene==1){
    //quiz
    quiz.draw();
    quiz.upate();
    if(quiz.goGame){
       quiz.quizend();
        scene=0;
       //if you click restart
        player.posX=300;
        player.posY=250;
        for(int i=0; i<PATIENTS_SIZE;i++){
          patients[i].posX=-100;
          patients[i].posY=-100;
          patients[i].isCured=false;
          patients[i].isAppear = false;
        }
        for(int i=0; i<20; i++){
          player.antiviruses[i].isDead=true;
        }
        player.hit=false;
        ui.cure=0;
        ui.timer=60;
        ui.game=true;
        ui.gameOver=false;
        ui.clear=false;
        song.play();
        ui.level++;
        if(ui.level==3){
          scene=2;
        }else{
        ui.setGame(ui.level);
        }
        quiz.goGame=false;
      scene=0;
    }
  }else if(scene==2){
    image(win,0,0);
  }else if(scene==3){
    image(introImg,0,0);
  
  }

}
void mousePressed(){
  if(scene==0){
    if(!ui.gameOver){
      player.setAntiviral(mouseX,mouseY);
    }else{
      //if you click restart
      player.posX=300;
      player.posY=250;
      for(int i=0; i<PATIENTS_SIZE;i++){
        patients[i].posX=-100;
        patients[i].posY=-100;
        patients[i].isCured=false;
        patients[i].isAppear = false;
      }
      for(int i=0; i<20; i++){
        player.antiviruses[i].isDead=true;
      }
      player.hit=false;
      ui.cure=0;
      ui.timer=60;
      ui.game=true;
      ui.gameOver=false;
      song.play();
    }
  }else if(scene==3){
      scene=0;
      ui = new UI();
      ui.setGame(0);
      quiz = new QuizManager(minim);
  }
}

void keyPressed(){
  if(scene==0){
    player.move(key);
  }else if(scene==1){
    if(key=='J'||key=='j'){
      quiz.quizend();
      scene=0;
       //if you click restart
        player.posX=300;
        player.posY=250;
        for(int i=0; i<PATIENTS_SIZE;i++){
          patients[i].posX=-100;
          patients[i].posY=-100;
          patients[i].isCured=false;
          patients[i].isAppear = false;
        }
        for(int i=0; i<20; i++){
          player.antiviruses[i].isDead=true;
        }
        player.hit=false;
        ui.cure=0;
        ui.timer=60;
        ui.game=true;
        ui.gameOver=false;
        ui.clear=false;
        song.play();
        ui.level++;
        ui.setGame(ui.level);
      }else if(key=='1'||key=='2'||key=='3'||key=='4'){
        if(key=='1'){
        quiz.checkAnswer(1);}else if(key=='2'){
        quiz.checkAnswer(2);}else if(key=='3'){
        quiz.checkAnswer(3);}else if(key=='4'){
        quiz.checkAnswer(4);}
        }
      }
    }
  

void keyReleased() {
  player.stop(key);
}
