import ddf.minim.*;
import ddf.minim.analysis.*;

class Sound{
  
  AudioPlayer hit_s;
  AudioPlayer clear_s;
  AudioPlayer gameOver_s;
  AudioPlayer rightAnswer_s;
  AudioPlayer fail_s;
  
  String BGMname = "resource/sound/zapsplat_chiller.mp3";
  String quizBgmName = "resource/sound/quiz.mp3";

  String clearSound=""; //1
  String gameOverSound=""; //2
  String rightanswerSound=""; //3
  String failSound=""; //4 
  
  void setEffectSound(Minim minim){
      //clear_s = minim.loadFile(clearSound);
      //gameOver_s = minim.loadFile(gameOverSound);
      //rightAnswer_s = minim.loadFile(rightanswerSound);
      //fail_s = minim.loadFile(failSound);
  }
}
