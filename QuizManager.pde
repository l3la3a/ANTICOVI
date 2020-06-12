import ddf.minim.*;
import ddf.minim.analysis.*;

class QuizManager{
  
  Quiz[] questions;
  
  int QUESTIONS_LENGTH=9;
  int current;
  int level;
  AudioPlayer quizSong;
  PImage[] quizBackground;
  PImage check; //(36,180)
  int checkHeight = 69;
  int animation;
  AudioPlayer right;
  AudioPlayer wrong;
  boolean delay;
  int delaytime;
  boolean goGame;
  QuizManager(Minim minim){

    questions = new Quiz[QUESTIONS_LENGTH];
    for(int i=0; i<QUESTIONS_LENGTH;i++){
      questions[i]= new Quiz();
      questions[i].setQuiz("resource/quiz/q"+str(i),"resource/quiz/quiz"+str(i),(i%4+1));
    }
    check = new PImage();
    check = loadImage("resource/quiz/check.png");
    level=0;
    animation =0;
    current =0;
    delay=false;
    quizBackground = new PImage[58];
    for(int i=0; i<58; i++){
      quizBackground[i] = new PImage();
      if(i<10){
      quizBackground[i] = loadImage("resource/quizBackground/00"+str(i)+".png");
      }else{
      quizBackground[i] = loadImage("resource/quizBackground/0"+str(i)+".png");
      }
    }
    quizSong = minim.loadFile("resource/sound/quiz.mp3");
    right = minim.loadFile("resource/sound/right.wav");
    wrong = minim.loadFile("resource/sound/wrong.wav");
    quizMixing(questions);
  }
  void draw(){
    image(quizBackground[animation],0,0);
    
    image(questions[current].question,0,0);
    image(questions[current].choices,36,180);
  
  }
  void upate(){
    animation++;
    if(animation==58){
      animation =0;
    }
    if(delay){
      image(check,36,180+(questions[current].answer-1)*69);
      delaytime++;
      if(delaytime==120){
        right = minim.loadFile("resource/sound/right.wav");
        wrong = minim.loadFile("resource/sound/wrong.wav");
        current++;
        delaytime=0;
        delay=false;
        if(current%3==0){
          goGame=true;
        }
      }
    }
  }
  void checkAnswer(int num){
    if(!isAnswerRight(num)){
    }
    delay=true;
  }
  boolean isAnswerRight(int num){
    // judge grade
    if(questions[current].answer==num){
      right.play();
      return true;
    }else{
      wrong.play();
      return false;
    }
  }
  void quizset(){
    quizSong.play();
    quizSong.loop();
  }
  void quizend(){
    quizSong.pause();
  }
  void quizMixing(Quiz[] q){
    Quiz tmp = new Quiz();
    for(int i=0; i<QUESTIONS_LENGTH;i++){
      int NUM = int(random(QUESTIONS_LENGTH));
      tmp=questions[NUM];
      questions[NUM] = questions[0];
      questions[0] = tmp;
    }
  }
}
