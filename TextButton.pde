
class TextButton extends Button    //TextButton is Button class's child, it inherits Button class features
{ 
  Constants constants = new Constants();

  //Following button attributes are set to a default value as per "Constants" class for convenience while creating an object
  color defaultColor = constants.buttonDefaultColor;
  color highlightColor = constants.buttonHighlightColor;  
  color textColor = constants.textColor;      
  int Curve = constants.rectCurve;
  String Text = "";
  boolean strokeEnabled = false;

  private color buttonColor = defaultColor; // Keep it private

  //Constructors to instanciate button
  TextButton(float pos_X, float pos_Y, float button_width, float button_height, String button_text)
  {
    super.pos.x = pos_X;
    super.pos.y = pos_Y;
    super.Width = button_width;
    super.Height = button_height;
    this.Text = button_text;
  }

  //Constructors to instanciate button with Default size
  TextButton(float pos_X, float pos_Y, String button_text)
  {
    super.pos.x = pos_X;
    super.pos.y = pos_Y;
    Text = button_text;
  }

  //Constructors to instanciate button with Default size with no initial text
  TextButton(float pos_X, float pos_Y)
  {
    super.pos.x = pos_X;
    super.pos.y = pos_Y;
  }

  //Default/Implicit Constructors
  TextButton() {
  }

  void render() {                  //Calling "render" method without a parameter sets button to reactive state by default
    this.render(true);
  }

  void render(Boolean reactive)    // if param- 'reactive' is set false then button will be static and won't change color on hover over.
  {
    if (!hidden) {
      fill(buttonColor);  //Button color
      if(strokeEnabled){
        stroke(highlightColor);  //Default Stroke colo
        strokeWeight(1);
      }
      else
        noStroke();
      rect(pos.x, pos.y, Width, Height, Curve);

      fill(textColor);  //Font color
      textAlign(CENTER, CENTER);  //Text alignment
      textSize(constants.defaultTextSize);    //Set font size
      text(Text, pos.x + Width/2, pos.y+Height/2 - constants.defaultTextSize/12);  //Heuristic adjustments are made to bring the text in the center
      defaultFill();
      if (reactive && super.isMouseOver())
      {
        highlightFill();
      }
    }
  }

  void defaultFill() {
    buttonColor = defaultColor;
  }

  void highlightFill() {
    buttonColor = highlightColor;
  }
}
