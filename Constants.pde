
class Constants
{
  // *********************** OverAll Configuration ***********************
  
  boolean preLoadData = false;    //Set true if you want to load data for all example pages at the time of program loading itself.
  int maximumPDFInMemory = 1;     //values must range from 1 to 10. Set the value as 2 if quicker switching between tabs is required. Set the value as 1 if RAM is limited
  
  
  
  
  
  //Window Attributes
  int windowWidth = displayWidth;
  int windowHeight = windowWidth*9/16;    //To maintain 16:9 aspect ratio
  
  //Button Attributes
  color buttonDefaultColor = color(66, 133, 177);
  color buttonHighlightColor = color(50, 101, 135);   //Hover over and click colours
  int rectCurve = 15;      //diameter of curve of rounded edge buttons
  //To create default size of button in case dimension is not provided
  int defaultButtonWidth = windowWidth/9; 
  int defaultButtonHeight = windowHeight/18;
  
  //Text Attributes
  PFont font_light = createFont("fonts//Roboto-Light.ttf",64);
  PFont font_regular = createFont("fonts//Roboto-Regular.ttf",64);
  PFont font_bold = createFont("fonts//Roboto-Bold.ttf",64);
  color textColor = color(255,255,255);
  color background = color(246);
  int headerTextSize = windowHeight/18;    //The top title
  int defaultTextSize = windowHeight/32;
  float colourTableTextSize = defaultTextSize/1.5;
  
  //Common Attributes for Home page and Example Page
  String bend = "Bend";  //1
  String fold = "Fold";  //4
  String pull = "Pull";  //5
  String squeeze = "Squeeze";  //3
  String stretch = "Stretch";  //2
  
  //ExamplePage attributes
  float epHeaderPosX, epHeaderPosY;
  
  //MediaPlayer attribute
  float bottomPanelHeight = 70;  //============ CHANGE AS REQUIRED ============= //TODO Height of Bottom Panel Height
  String playTimeFormat = "00:00 / 00:00";
  
  
  //PhotoVIewer attr
  color thumbnailBackgroundColor = color(230);
  color photoviewerBackgroundColor = background;
  int oneScrollWheelValue = 150; 
  float imageDetailTextSize = colourTableTextSize;
  color imageDetailTextColor = buttonDefaultColor;
  
  //PDF Viewer Attributes        //TODO - change the color as per requirement
  color scrollBarColor = color(150);
  color scrollBarButtonColor =color(255);
  color scrollBarFillColor = color(0);
  
  //Color-Table Attr
  PVector colorTablePosition = new PVector(0,0);
  float colorTableWidth;
  
  float radioButtonWidth;
  
  
  float a, b, c, d, e, f, g, h, i, j;
  float A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P;
  
  {
    A=-2961.0/8699;
    B=40149.0/139184;
    C=-604.0/8699;
    D=1600.0/8699;
    E=1820.0/8699;
    F=-11907.0/139184;
    G=2080.0/8699;
    H=-1701.0/17398;
    I=1820.0/8699;
    J=-11907.0/139184;
    K=520.0/8699;
    L=-1701.0/69592;
    M=-540.0/8699;
    N=1350.0/8699;
    O=-960.0/8699;
    P=2400.0/8699;
  
    a = windowWidth;
    b = windowHeight;
    j = A*b + B*a;
    i = C*b + D*a;
    h = E*b + F*a;
    g = G*b + H*a;
    f = I*b + J*a;
    e = K*b + L*a;
    d = M*b + N*a;
    c = O*b + P*a;
        
    radioButtonWidth = 5 * defaultTextSize;    //TODO - change width of radiobutton to max text width  + "someGap" ::: max(video,image,paper,tech) = 5
    
    //ExamplePage attributes
    //println("value of G : "+g);
    epHeaderPosX = ((windowWidth-(g+radioButtonWidth+g+g))/2)+g+radioButtonWidth+g;
    epHeaderPosY = g/3;
  }
  
    
  
  //Function to fit the images in provided window without stretching
  float fitImageInWindow(PImage img, float pos_x, float pos_y, float frameWidth, float frameHeight){
    float imgW = img.width;
    float imgH = img.height;
    if(imgW/imgH < frameWidth/frameHeight){ 
      imgW = imgW*frameHeight/imgH;
      imgH = frameHeight;
      pos_x += (frameWidth - imgW)/2;
    }
    else{
      imgH = imgH*frameWidth/imgW;
      imgW = frameWidth;
      pos_y += (frameHeight-imgH)/2;
    }    
    image (img, pos_x, pos_y, imgW, imgH);
    return pos_y+imgH;  //Returning from where the image details should be shown
  }
  
  //Function to fit the image detail text in the provided window
  float getWrappedTextHeight(String text, float Width){
    textSize(imageDetailTextSize);
    float textWidth = textWidth(text);
    float textHeight = textDescent()+textAscent();
    
    if (textWidth > Width){
      int totalLines = ceil(textWidth/Width);
      //int textLength = text.length();
      //int textLengthPerLine = textLength/totalLines;
      //textLeading(textHeight*5/4);
      textHeight = textHeight*totalLines;
    }    
    return 2*textHeight;  
  }
  
  //Function to fit the video in provided window without stretching
  void fitVideoInWindow(Movie mov, float pos_x, float pos_y, float Width, float Height){
    float w = mov.width;
    float h = mov.height;
    if(w/h < Width/Height){  //
      w = w*Height/h;
      h = Height;
      pos_x += (Width - w)/2; 
    }
    else{
      h = h*Width/w;
      w = Width;
      pos_y += (Height-h)/2;
    }       
    //println ("w = "+ w + "  W = " + W + "\th = "+ h + "  H = "+ H);
    //PImage img = mov.get(0,60, (int)w, (int)h-100);    //For cropping a video
    image (mov, pos_x, pos_y, w, h);
  }
  
  //Function to draw Color-Table Descriptor
  void drawColorTable(){
    float Y = this.colorTablePosition.y;
    float X = this.colorTablePosition.x;
    float W = colorTableWidth;
    float boxSize = colourTableTextSize;
    int gap = 5;
    
    textSize(boxSize);    //Set font size
    noStroke();
    //Box-1
    fill(255,122,123);
    rect(X, Y, boxSize, boxSize);
    fill(buttonHighlightColor);  //Font color
    textAlign(LEFT, TOP);  //Text alignment
    text("System", X+boxSize+gap, Y);
    
    //Box-3
    fill(buttonHighlightColor);  //Font color
    textAlign(RIGHT, TOP);  //Text alignment
    text("Implementation", X+W, Y);
    float temp = W-textWidth("Implementation")-gap-boxSize;
    fill(124,124,254);
    rect(X + temp, Y, boxSize, boxSize);
    
    //Box-2
    fill(122,211,122);
    temp = temp/2;
    rect(X + temp, Y, boxSize, boxSize);
    fill(buttonHighlightColor);  //Font color
    textAlign(LEFT, TOP);  //Text alignment
    text("Manipulation", X+temp+boxSize+gap, Y);
    
  }
  
  String getFormattedTimeAsString(float time){    
    String playTime = "";
    //Minutes
    if((int)time/60 < 10)
      playTime = playTime + "0";
    playTime = playTime + Integer.toString((int)time/60 );
    
    //Separator
    playTime = playTime + ":";
    
    //Seconds
    if((int)time%60 <10)
      playTime = playTime + "0";
    playTime = playTime + Integer.toString((int)time%60 );
    
    return playTime;
  }
}
