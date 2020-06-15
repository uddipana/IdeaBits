class PDFViewer {
  //Constants constants;
  PVector pos = new PVector(0, 0);
  PImage displayPage, orgSizedPage, RenderedPageArea;  
  ImageButton zoomInButton, zoomOutButton, reCenter, fullScreen;
  
  int panX = 0, panY = 0, pageWidth, pageHeight;
  float scale = 1;    //zooming is initialized to 100%
  float Width, Height, resizeRatio;
  boolean dragging = false;
  float scrollCurrPos = 0, scrollLastPos;

  boolean isFirstLoad = true;
  boolean isDataInitialized = false;
  boolean scrolling = false;
  boolean hidden = false;
  color textColor;
  
  HashMap<String, PImage> loadedPdfFilesMap = new HashMap();


  PDFViewer(float pos_X, float pos_Y, float W, float H) {
    pos.x = pos_X;
    pos.y = pos_Y;
    this.Width = W;
    this.Height = H;
    //constants = new Constants();
    textColor = constants.buttonDefaultColor;
    

    //fullScreen = new ImageButton(pos.x+Width-110, pos.y-25, 20, 20, loadImage("icons\\full-screen.png"));
    zoomInButton = new ImageButton(pos.x+Width-120+4, pos.y-40, 30, 30, loadImage("icons\\zoom-in.png"), loadImage("icons\\zoom-in2.png"));    //TODO pdf viewer buttons
    zoomOutButton = new ImageButton(pos.x+Width-120+37+4, pos.y-40, 30, 30, loadImage("icons\\zoom-out.png"), loadImage("icons\\zoom-out2.png"));
    reCenter = new ImageButton(pos.x+Width-120+37+37+3+4, pos.y-40, 30, 30, loadImage("icons\\zoom-reset.png"), loadImage("icons\\zoom-reset2.png"));
  }

  // Load Page Image  //This method should run only once for one PDF viewer object
  void loadPages(String imgName) {
    if (isFirstLoad) {
      isDataInitialized = false;
      isFirstLoad = false;
      if(loadedPdfFilesMap.containsKey(imgName))
        orgSizedPage = loadedPdfFilesMap.get(imgName);
      else {
        if(loadedPdfFilesMap.size() == constants.maximumPDFInMemory)  //For lesser RAM, Not saving more than 2 PDF images on RAM.. Each Example Page has only two PDF, so this will merely enable faster switching between two
          loadedPdfFilesMap.clear();
        orgSizedPage = requestImage(imgName);
        loadedPdfFilesMap.put(imgName,orgSizedPage);
      }
    }
    initPageData();
  } 

  private void initPageData() {
    if (!isDataInitialized) {
      //println("waiting for PDF file to load");
      if (orgSizedPage.width > 0) {
        //println("****** Success ******");
        isDataInitialized = true;
        // Resize all Pages to fit in window
        scale = 1;      
        resizePages(scale); //remove zooms
        panX=0; 
        panY=0;  //Reset Page position
      }
      //By the time PDF image is loading, Render the outline of the PDF viewer
      renderOutline();
      fill(constants.buttonDefaultColor);  //Font color
      textAlign(CENTER, TOP);  //Text alignment
      textSize(constants.defaultTextSize);    //Set font size
      text("Loading . . .", pos.x + Width/2, pos.y + Height/2);
    }
  }

  private void renderOutline() {
    //Outline Shape rendering
    stroke(constants.buttonHighlightColor);
    strokeWeight(2);
    fill(255);
    rect(pos.x, pos.y, Width, Height);  //Outline of the diaplay area
    //Control Panel rendering    
    zoomInButton.render();
    zoomOutButton.render();
    reCenter.render();
    //fullScreen.render();
  }

  // Render
  void render() { 
    if (!this.hidden && displayPage != null && isDataInitialized) {
      
      //1. Render PDF Viewer Outline
      renderOutline();

      //2. Zoom-in & Zoom-out
      if (zoomInButton.isClicked()) {
        scale *= 1.25;
        resizePages(scale); //zoom in by 25%
      }
      if (zoomOutButton.isClicked()) {
        scale /= 1.25;      
        resizePages(scale); //zoom out by 25%
      } 

      //3. Full Screen
      //if(fullScreen.isClicked()){
      //  this.pos.x = 0;
      //  this.pos.y = 50;
      //  this.Width = width-50;
      //  this.Height = height-50;
      //}

      //4. Recenter / Reset
      if (reCenter.isClicked()) {
        scale = 1;      
        resizePages(scale); //remove zooms
        panX=0; 
        panY=0;  //Reset Page position
      } 
      
      //5. Scrolling 
      int xShift = 0, yShift = 0;
      if(scrollCount != 0){
        yShift = - scrollCount * constants.oneScrollWheelValue;
        panY += yShift;
        scrollCount = 0;        //Resetting the scroll value to receive new input
      }
      
      //6. Panning Function
      if (!mousePressed && dragging) 
        dragging = false;
      if (dragging && isMouseOver()) {
        xShift = -pmouseX + mouseX;
        yShift= -pmouseY + mouseY;
        panX += xShift;
        panY += yShift;
      }
      if (mousePressed && isMouseOver()) 
        dragging = true;
        
      if (panX >= 0) {   
        panX = 0;
        xShift = 0;
      } else if (panX <= -pageWidth + (int)Width)   { 
        panX = -pageWidth + (int)Width;     
        xShift = 0;
      }
      if (panY >= 0)  {  
        panY = 0;
        yShift = 0;
      } else if (panY <= -pageHeight + (int)Height)  {  
        panY = -pageHeight + (int)Height;   
        yShift = 0;
      }
      //println(panX +"\t\t"+ panY + "\t\t" + (-pageHeight + (int)Height));
      
      RenderedPageArea = displayPage.get(-panX, -panY, (int)Width, (int)Height);
      image(RenderedPageArea, pos.x, pos.y, Width, Height);  // Define a Rendering boundary for display area
      
      //Scroll Position Marker
      int markerHeight = 20;  //in pixels
      rect(pos.x+Width-1, pos.y-((Height-markerHeight)/(pageHeight-Height))*panY, 2, markerHeight);  
    }
  }


  Boolean isMouseOver() {
    if (mouseX >= pos.x && mouseX <= pos.x + Width && mouseY >= pos.y && mouseY <= pos.y + Height)
      return true;
    return false;
  }

private void resizePages(float scale) {
    try {
      //Resize all pages
      pageWidth = (int)(Width*scale);
      pageHeight = (int)(orgSizedPage.height * pageWidth/orgSizedPage.width);

      //Make a deep copy of original images so that on resizes original image resolution is not lost
      displayPage = createImage(pageWidth, pageHeight, RGB);
      displayPage.copy(orgSizedPage, 0, 0, orgSizedPage.width, orgSizedPage.height, 0, 0, pageWidth, pageHeight);

      //**************
      //println("Page Height : "+temp.height);
      resizeRatio = Width/displayPage.width *scale;
    }
    catch(Exception ex) {
      println("PDF File not available yet ::\t Error : "+ex);
    }
  }
  //Hide-Unhide
  void hide(){
    this.hidden = true;
  }
  void unHide(){
    this.hidden = false;
  }
  void reset(){
    displayPage = null; 
    orgSizedPage=null; 
    RenderedPageArea = null;
    loadedPdfFilesMap.clear();
  }
}
