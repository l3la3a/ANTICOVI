class Quiz{
  PImage question;
  PImage choices;
  int answer; // right choice
  
  void setQuiz(String _question, String _choices,int _answer){
    question = new PImage();
    question = loadImage(_question+".png");
    choices = loadImage(_choices+".png");
    answer = _answer;
  }
  
}
