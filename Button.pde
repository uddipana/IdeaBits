/**
 * General class for buttons
 * @Attribures-
 *    Size
 *    Coordinates
 *    buttonID
 *    
 * @Functions-
 *    Click events
 *    MouseOver and mouse off
 *    hide and unHide
 */
                            
class Button {
  protected PVector pos = new PVector(0, 0);    //"protected" restricts the scope of PVector pos to only Button class and it's children
  //To create default size of button in case dimension is not provided
  float Width = constants.defaultButtonWidth;   
  float Height = constants.defaultButtonHeight;
  protected Boolean clicked = false;
  protected Boolean pressed = false;
  protected Boolean hoverOver = false;
  protected Boolean hidden = false;
  Integer buttonID;                           //For arduino

  //set button size to over write default size
  void setSize(float w, float h) {
    this.Width = w;
    this.Height = h;
  }

  //to be used to check if the button has been clicked
  Boolean isClicked()  
  {
    this.updateClick();
    return clicked;
  }

  //Update click status on button
  private void updateClick()  
  {
    if (mousePressed && mouseButton==LEFT && !pressed && !hidden) {
      pressed = true;
      if (this.isMouseOver()) {
        clicked = true;
        isMouseClicked = false;
        delay(100);    // Delay added to restrict redundant clicks
        //System.out.println("Button Clicked");
      }
    } else {
      clicked = false;
      pressed = false;
    }
  }  
  Boolean isMouseOver() {
    if (mouseX >= pos.x && mouseX <= pos.x + Width && mouseY >= pos.y && mouseY <= pos.y + Height)
      return true;
    return false;
  }

  //To hide and unhide any button
  void hide() {
    this.hidden = true;
  }
  void unHide() {
    this.hidden = false;
  }

  //set button param
  void setButtonID(int ID) {
    this.buttonID = ID;
  }
  
  //get button param
  int getButtonParam() {
    return this.buttonID;  //returns null if ID is not set
  }
}
