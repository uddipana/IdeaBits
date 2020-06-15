import processing.serial.*;                                          //For communicating with Arduino
import processing.video.*;

class Frame
{
  ImageButton imageButton;
  TextButton textButton;
  //Constants constants = new Constants();

  private PVector pos = new PVector(0, 0);
  //private String buttonParam;
  
  float W;  //variable to store frame Width
  float H;  //variable to store frame Height
  int Curve = 15;
  int strokeWidth = 10;
  PImage image;  
  Movie movie;

  String buttonText;
  //Todo - Change button offset to alter separation between Image button and Text Button 
  int buttonSeparation;  
  float buttonX;
  float buttonY;
  float buttonW;
  float buttonH;
  Boolean hidden = false;
  boolean isInfoWritten = false;

  // Frame Constructor
  Frame (float pos_X, float pos_Y, float frameWidth, float frameHeight, float buttonHeight, float gap, String text, PImage image, Movie movie)
  {
    pos.x = pos_X;
    pos.y = pos_Y;
    this.W = frameWidth;
    this.H = frameHeight;
    this.buttonH = buttonHeight;
    this.buttonW = W;
    this.buttonText = text;
    this.movie = movie;
    this.movie.loop();    //Video in the frame must be looped

    // Instantiate ImageButton and TextButton in Frame constructor to make it reactive on hovers and clicks
    this.imageButton = new ImageButton(pos.x, pos.y, W, H, image, movie);
    this.textButton = new TextButton(pos.x+strokeWidth/2, pos.y+H+gap, buttonW-strokeWidth, buttonH, buttonText);
    textButton.Curve = strokeWidth;
  }

  void render() // Render the frame
  {
    if (!hidden) {      
      textButton.render(false);  //Buttons needs to be non-reactive first
      imageButton.render(false);
      //Round Edge rectangular mask for Image
      stroke(constants.background);
      strokeWeight(strokeWidth);
      noFill();
      rect(pos.x, pos.y, W, H, Curve);
      
      //Make frame buttons reactive here
      if (this.isMouseOver()){
        highlightState();
        if(!isInfoWritten){
          isInfoWritten = true;
          writeTimeStamp();
          outFile.println("Mouse Hover over "+buttonText+",");
        }
      }
      else{
        defaultState();
        isInfoWritten = false;
      }
    }
  }

  private void calculateTextButtonParams() {
    buttonX = pos.x+5;              // 5 is added to compensate for the reduced image button size due to masking.
    buttonY = pos.y + H + 13.28;
    buttonW = W-10;
    buttonH = 53;
  }

  Boolean isMouseOver()  {
    return this.textButton.isMouseOver() || this.imageButton.isMouseOver();
  }

//  Boolean isMouseOverFrame() {
//    if (mouseX >= pos.x && mouseX <= pos.x + W && mouseY >= pos.y && mouseY <= buttonY+buttonH)
//      return true;
//    return false;
//  }

  Boolean isClicked()  {
    return this.textButton.isClicked() || this.imageButton.isClicked();
  }

  void defaultState()  {
    this.textButton.defaultFill();
    this.imageButton.defaultFill();
  }

  void highlightState()  {
    this.textButton.highlightFill();
    this.imageButton.highlightFill();
  }

  //Hide and UnHide
  void hide() {
    this.hidden = true;
    textButton.hide();
    imageButton.hide();
    if (movie != null) this.movie.stop();
  }
  void unHide() {
    this.hidden = false;
    textButton.unHide();
    imageButton.unHide();
  }
}
