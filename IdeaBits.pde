// Execution starts from here

import processing.serial.*;       //For communicating with Arduino
import processing.video.*;

//Defining instances
ExamplePage examplePage;  
HomePage homePage;
Constants constants;

int currentPage = 0;  // 0:Homepage  1:Example page 
int frameClicked = -1; //Frame is each "image button + text button" of Home page. frameClicked stores which frame is being clicked on.
boolean loadingFirstTime = true;  //To load all data initially and only once

Serial myPort;  // Define object from Serial class
String val;     // Data received from the serial port
String portName;
int artifactSelected = -1;
boolean isArduinoActive = false;
int lastInputTime = 0, timeDiff = 0;
boolean shouldMoviePlay = true;
boolean isArtifactChanged = false;
boolean isArtifactManipulated = false;
boolean isArtifactKeptPressed = false;
boolean isMouseClicked = false;
int scrollCount = 0;

PrintWriter outFile;
float timeTracker;

//_____________________________________________
//TextButton [] btn = new TextButton[5];
//---------------------------------------------

void setup() {  
  constants = new Constants();          //Constants is for a list of global variables
  //size(displayWidth, displayHeight);    //For window view
  size(1920,1135);
  //fullScreen();                       //For Full Screen view

  //Font setting for all
  textFont(constants.font_regular);
  
  //For Arduino
  try {
    for(String temp : Serial.list())
      println(temp);
    portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);    // Create object from Serial class
    isArduinoActive = true;        //if port is available then mark Arduino as Active
  } 
  catch (Exception ex) {
    println("Arduino not Active\t\t\t"+ex);
  }
  println("is Arduino Active : " + isArduinoActive);

  // Home Page
  homePage = new HomePage(this);      //"this" passes IdeaBits type object to "HomePage"

  //ExamplePage
  examplePage = new ExamplePage(this);

  //Preload all the data at the time of load itself
  if (loadingFirstTime && constants.preLoadData) {
    println("Loading Example Page Data");
    for (int i=0; i<homePage.numberOfFrames; i++)
      examplePage.loadPageData(i);  //Load Data in example pages
    loadingFirstTime = false;
  }
  
  //====================================================
  //int X=10,Y=10,W=40, H=40;
  //for(int i=0; i<5; i++){
  //  btn[i] = new TextButton(X,Y,W,H,Integer.toString(i));
  //  X=X+W+5;
  //}
  //isArduinoActive = true;
  //----------------------------------------------------
  
  
  //Writing log to a file
  outFile = createWriter("output\\Research_Output_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".csv"); 
  timeTracker = millis();
  
  writeTimeStamp();
  outFile.println("Program Loaded");  
  writeTimeStamp();
  outFile.println("On Home Page");  //On first load of program home page will be loaded
}

void draw() {
  background(constants.background);  //To use "background" variable value from constants
  
  if (currentPage==0)         
    homePage.render();    //To call "render" function in homePage
  if (currentPage==1) {
    examplePage.render();
  }

  //Read from Serial (Arduino) as input and jump to appropriate example page.
  if (isArduinoActive ) {
    //=====================================================================================
    if ( myPort.available() > 0)    // If data is available,
    {
      val = myPort.readStringUntil('\n');         // read it and store it in val 
    //val = "9\n";
    //for(int i=0; i<5; i++){
    //  btn[i].render();
    //  if(btn[i].isClicked())
    //    val=Integer.toString(i)+"\n";
    //}
    //------------------------------------------------------------------------------------
      isArtifactChanged = false;
      isArtifactManipulated = false;
      //println("\t\tvalr received from arduino : "+val);
      if (val!=null && val.length()>0) 
      {    
        if(artifactSelected != 9 && Integer.parseInt(val.trim()) == artifactSelected)
          isArtifactKeptPressed = true;
        else if(Integer.parseInt(val.trim()) == 9)
          isArtifactKeptPressed = false;
          
        artifactSelected = Integer.parseInt(val.trim());         
        if (artifactSelected >= 0 && artifactSelected<5 && !isArtifactKeptPressed)    //if input correspond to any artifact ONLY THEN go to corresponding example page and play the movie
        {
          timeDiff = millis() - lastInputTime;    //Time difference between subsequent input from serial          
          if (frameClicked == artifactSelected)       //if same artifact is being manipulated again 
          {
            //println("************************ Same artifact selected again");
            writeTimeStamp();
            outFile.print("Artifact : "+artifactSelected+" is Manipulated again ,");
            
            isArtifactManipulated = true;
            if (examplePage.mediaPlayer.getMovieState() != examplePage.mediaPlayer.PLAY)   //if media player's movie is not playing (stopped or paused) then play
              shouldMoviePlay = true;
            else
              shouldMoviePlay = false;
          } else if (timeDiff>2000)   //if different artifact is manipulated then there should be a time gap between two subsequent manipulations
          {
            lastInputTime = millis();    // Set time when an input is selected
            //println("######################## artifact clicked : " + artifactSelected + "\tframe clicked : " + frameClicked);            
            writeTimeStamp();
            outFile.println("Artifact : "+artifactSelected+" is Selected ,");
            
            currentPage = 1;
            shouldMoviePlay = true;   //if another artifact is manipulated then movie should start playing.
            frameClicked = artifactSelected;
            isArtifactChanged = true;
          }
        }
      }
    //===================================================================================
    }
    //-----------------------------------------------------------------------------------
  } 
    //If serial input is not available then show Homepage.. Record Homepage Clicks and render appropriate example page  
    if (currentPage == 0)  //Home Page click returns which frame is clicked if on homepage
      frameClicked = homePage.getClickedFrameNo();
    //else
    //  frameClicked = -1;    //if not on homepage then no need to keep frame data
  

  if (frameClicked != -1) {
    if (currentPage == 0) {      //The case when arduino isn't active then the program should behave like UI controlled   
      examplePage.loadPageData(frameClicked);  //Load Data in example page corresponding to frame clicked
      currentPage = 1;                         //when a frame is clicked, should GOTO example page
    } else if (isArduinoActive) {  
      if (isArtifactChanged) {
        //println("resetting example page");
        examplePage.reset();
        examplePage.loadPageData(frameClicked);  //Load Data in example page corresponding to Artifact manipulation
        //isArtifactChanged = false;           //To stop loading same data again and again in the event of unexpected arduino inputs
      }
      if (isArtifactManipulated || isArtifactChanged) {
        //println(" * * * Changing movie state");
        if (shouldMoviePlay){
          examplePage.mediaPlayer.setMovieState(examplePage.mediaPlayer.PLAY);
        } else {
          examplePage.mediaPlayer.setMovieState(examplePage.mediaPlayer.PAUSE);
        }
      }
    }

    currentPage = 1;                         //when a frame is clicked, should GOTO example page
    homePage.hide();                         //hide homepage elements
  }

  //Return to home page from example page
  if (currentPage==1 && examplePage.getClickEvent().equals("back")) {  //Example Page clicks returns if back button is pressed on exapmle page
    currentPage = 0;      //pressing back button should bring back home page
    frameClicked = -1;    //pressing back button should erase previous frame clicks
    homePage.unHide();    //home page should be allowed to be rendered
    writeTimeStamp();
    outFile.println("On Home Page");
  }
  outFile.flush();
}

void writeTimeStamp(){
    outFile.print(hour()+":"+minute()+":"+second()+"," + (millis()-timeTracker)/1000 +",");
    timeTracker = millis();
}

// To enable playing of any video. Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

// Mouse events
void mouseClicked(){
  isMouseClicked = true;
}
void mouseWheel(MouseEvent event) {
  scrollCount = event.getClickCount();
}
