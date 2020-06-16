import processing.serial.*;    //For communicating with Arduino //<>// //<>//
import processing.video.*;

class ExamplePage
{
  //Constants constants = new Constants();  //Creating instance of Constants class
  //Defining Instances
  TextButton    tabButton_1, tabButton_2, techGuideButton;
  ImageButton   backButton;
  Movie movie;
  MediaPlayer mediaPlayer;
  PhotoViewer photoViewer;
  ExamplePageData epDataObj;
  IdeaBits obj;
  PDFViewer pdfViewer;
  RadioButton menuRadio;

  int tabClicked = 1;  //To record which tab was clicked recently.  By default 1st tab is clicked on page load
  int currentFrame;

  HashMap<Integer, ArrayList<Float[]>> videoHotSpots = new HashMap();  // Hot spots for video file in media player
  ArrayList<PImage> photoViewerImgArray = new ArrayList();    // set of images to be shown in photoviewer
  ArrayList<String> photoViewerDetailArray = new ArrayList();
  String pdfViewerFileName;    //For pdf of paper (used arraylist earlier as multiple images were being used)
  String techButtonLink;

  float headerPosX = constants.epHeaderPosX;
  float headerPosY = constants.epHeaderPosY;    
  String headerText = "";

  int currentMenu = 0;  //to track selected menu from left panel on example page. menu starts from 0
  int tabOffset = 0;    //to load new data when tab changes
  boolean isTabClicked = false; //to detect click on either of the tab
  boolean isMenuOrTabChanged = false;

  ExamplePage(IdeaBits obj)
  {
    this.obj = obj;
    epDataObj = new ExamplePageData();
    float Xa = constants.windowWidth/24;  //A generic variable for x position of different items, being reused
    float Ya = constants.windowHeight/12;
    float Wa, Ha;

    //Example page interface    //TODO - change positions and Size of elements on interface appropriately. Remove hardcoded values.

    float a, b, c, d, e, f, g, h, i, j;
    float A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, AA, BB, CC, DD, EE, FF;
    
    A=-2961;
    B=8699;
    C=40149;
    D=139184;
    E=-604;
    F=8699;
    G=1600;
    H=8699;
    I=1820;
    J=8699;
    K=-11907;
    L=139184;
    M=2080;
    N=8699;
    O=-1701;
    P=17398;
    Q=1820;
    R=8699;
    S=-11907;
    T=139184;
    U=520;
    V=8699;
    W=-1701;
    X=69592;
    Y=-540;
    Z=8699;
    AA=1350;
    BB=8699;
    CC=-960;
    DD=8699;
    EE=2400;
    FF=8699;

    a = constants.windowWidth;
    b = constants.windowHeight;
    j = A*b/B + C*a/D;
    i = E*b/F + G*a/H;
    h = I*b/J + K*a/L;
    g = M*b/N + O*a/P;
    f = Q*b/R + S*a/T;
    e = U*b/V + W*a/X;
    d = Y*b/Z + AA*a/BB;
    c = CC*b/DD + EE*a/FF;
    println(g);

    //Back Button
    backButton = new ImageButton(g, g/3, 4*f/5, 4*f/5, loadImage("icons\\back1.png"), loadImage("icons\\back2.png"));

    //Tab Buttons
    Xa = constants.epHeaderPosX-constants.windowWidth/5.5;
    Wa = constants.windowWidth/5.5;
    Ha = constants.defaultButtonHeight;
    tabButton_1 = new TextButton(Xa, g/4+f+g/2, Wa, f, "");
    tabButton_2 = new TextButton(Xa+Wa, g/4+f+g/2, Wa, f, "");
    tabButton_1.defaultColor = constants.background;
    tabButton_2.defaultColor = constants.background;

    //Radio buttons
    
    menuRadio = new RadioButton(g, g/3+f+g/2+f+g/2, constants.radioButtonWidth, f, 3);
    menuRadio.setButtonText(0, "Video");
    menuRadio.setButtonText(1, "Image");
    menuRadio.setButtonText(2, "Paper");
    menuRadio.setSelectedIndex(currentMenu);

    //To position "techGuideButton" we can use the menuRadio Button's PVector value
    techGuideButton = new TextButton(menuRadio.pos.x, menuRadio.pos.y, constants.radioButtonWidth, f, "Tech");
    techGuideButton.Curve = 5;
    
    //println("Media Player param : " +(Xa*4) +"\t"+ (g+f+g/2+f+g/2) +"\t"+ constants.windowWidth/1.3 +"\t"+ constants.windowHeight/1.7);
    float window_X = g+constants.radioButtonWidth+g;
    float window_Y = g/3+f+g/2+f+g/2;
    float window_W = constants.windowWidth-(window_X)-g; 
    //mediaPlayer = new MediaPlayer(window_X, window_Y, window_W, constants.windowHeight/1.7);    //TODO height of mediabox excluding the lower rectangle
    mediaPlayer = new MediaPlayer(window_X, window_Y, window_W, menuRadio.pos.y + f/2 -window_Y-constants.colourTableTextSize-constants.bottomPanelHeight);    //TODO height of mediabox excluding the lower rectangle
    photoViewer = new PhotoViewer(window_X, window_Y, window_W, constants.windowHeight/1.7);    
    pdfViewer = new PDFViewer(window_X, g/3+f+g/2+f+g/2, window_W, menuRadio.pos.y+f-(g/3+f+g/2+f+g/2)-constants.colourTableTextSize-g/3);
    
    //set Position for Color-Table 
    constants.colorTablePosition = new PVector(window_X, menuRadio.pos.y + f-constants.colourTableTextSize);    //should be in the level of "Tech" button
    constants.colorTableWidth = window_W;
  }

  void render()
  { 
    
    //Header Text
    fill(constants.buttonDefaultColor);  //Font color
    textAlign(CENTER, TOP);  //Text alignment                  
    textSize(constants.headerTextSize);    //Set font size            
    text(headerText, headerPosX, headerPosY);    //Here headerText changes dynamically as per buttons are clicked     //TODO - Position of header

    //Back Button    
    backButton.render();

    //Menu Buttons    
    menuRadio.render();
    
    //Tech Guide Button
    techGuideButton.render();
    
    //Tech Guide Button Action
    if (techGuideButton.isClicked()){
      link(this.techButtonLink);
      writeTimeStamp();
      outFile.println("Menu : Tech Guide ,");
    }
    
    
    // Tab Toggle Layout 
    if (tabButton_1.isClicked() || tabClicked == 1) {
      tabOffset = 0;
      if (tabClicked != 1)  //we can't check tabButton_1.isClicked() again since now it will return false.. But since we know that only one of the 2 conditions above will hold, so we can use that property
        isTabClicked = true;        

      tabClicked = 1;    // Record which tab is clicked
      tabButton_2.render(false);
      tabButton_1.render(false);
      tabButton_1.highlightFill();
      tabButton_2.defaultFill();
      tabButton_2.textColor = constants.buttonHighlightColor;
      tabButton_1.textColor = constants.textColor;
    } 
    if (tabButton_2.isClicked() || tabClicked == 2) {
      tabOffset = 10;
      if (tabClicked != 2)
        isTabClicked = true;

      tabClicked = 2;    // Record which tab is clicked
      tabButton_1.render(false);
      tabButton_2.render(false);
      tabButton_2.highlightFill();      
      tabButton_1.defaultFill();
      tabButton_1.textColor = constants.buttonHighlightColor;
      tabButton_2.textColor = constants.textColor;
    }
    noFill();
    stroke(constants.buttonHighlightColor);
    strokeWeight(2);
    rect(tabButton_1.pos.x, tabButton_1.pos.y, tabButton_1.Width+tabButton_2.Width, tabButton_1.Height, tabButton_1.Curve);
    
    
    //isMenuOrTabChanged = false;
    //Tab button action
    if (isTabClicked) {
      isTabClicked = false;
      isMenuOrTabChanged = true;
      mediaPlayer.hide();
      photoViewer.hide();
      this.loadPageData(currentFrame);
      mediaPlayer.isFirstLoad = true;
    }
    
    if(currentMenu != menuRadio.getSelectedIndex()){
      isMenuOrTabChanged = true;
      currentMenu = menuRadio.getSelectedIndex();
      writeMenuInfo();
    }

    switch (currentMenu) {     
    case 0:  //When video player is active
      if(isMenuOrTabChanged){
        mediaPlayer.unHide();
        photoViewer.hide();
        pdfViewer.hide();
      }

      mediaPlayer.setMovie(movie);
      mediaPlayer.render();
      mediaPlayer.setHotSpots(videoHotSpots);
      constants.drawColorTable();
      break;

    case 1:  //When photo viewer is active
      if(isMenuOrTabChanged){
        mediaPlayer.hide();
        photoViewer.unHide();  
        pdfViewer.hide();
      }

      //photoViewer.loadImages(photoViewerImgArray);    //images should be loaded only once when any frame is clicked
      photoViewer.render();
      break;

    case 2:  //When PDF Viewer is active 
      if(isMenuOrTabChanged){
        mediaPlayer.hide();
        photoViewer.hide();
        pdfViewer.unHide();
      }
      
      pdfViewer.render();
      pdfViewer.loadPages(pdfViewerFileName);
      constants.drawColorTable();
      break;
    }
    
    isMenuOrTabChanged = false;
  }
  
  //Frame data to be loaded on frame click on home page
  HashMap<Integer, PhotoViewer> loadedPhotoViewer = new HashMap();

  private void loadPageData(int frameNo) {
    //println("Loading ExamplePage Data");
    epDataObj.loadExamplePageData(frameNo+tabOffset, this, obj);    //Tab offset is used to determine which tab was clicked
    currentFrame = frameNo;  

    photoViewer.loadImages(photoViewerImgArray, photoViewerDetailArray);    //images should be loaded only once when any frame is clicked
    mediaPlayer.isFirstLoad = true;
    pdfViewer.isFirstLoad = true;
    
    //Printing to File
    println();
    writeTimeStamp();
    outFile.print("Example Page : "+headerText+",");
    if(tabClicked==1)      
      outFile.print("Tab-1 : "+tabButton_1.Text+",");
    else if(tabClicked==2)      
      outFile.print("Tab-2 : "+tabButton_2.Text+",");
    outFile.println();    
    writeMenuInfo();
  }

  private void writeMenuInfo(){
    writeTimeStamp();
    switch(currentMenu){
        case 0:  
          outFile.println("Menu : MOVIE ,"); 
          break;
        case 1:  
          outFile.println("Menu : PHOTOS ,"); 
          writeTimeStamp();
          outFile.println("Displaying : " + photoViewer.displayDetail.split(":")[0]);      
          break;
        case 2:  
          outFile.println("Menu : PAPER ,"); 
          break;
      }
  }
  
  String getClickEvent() {
    if (this.backButton.isClicked()) {  //if back button is clicked, reset the example page for next load 
      reset();
      writeTimeStamp();
      outFile.println("Back Button clicked");
      return "back";
    }

    if (this.tabButton_1.isClicked()) {
      this.tabButton_1.highlightFill();
      this.tabButton_2.defaultFill();
      return "tab1";
    }
    if (this.tabButton_2.isClicked()) {
      this.tabButton_2.highlightFill();
      this.tabButton_1.defaultFill();
      return "tab2";
    }
    return "";
  }

  void reset() {
    mediaPlayer.hide();
    menuRadio.setSelectedIndex(0);
    tabClicked = 1;
    tabOffset = 0;
    isTabClicked = false;
    photoViewer.reset();
    pdfViewer.reset();
    isMenuOrTabChanged = true;
  }
}
