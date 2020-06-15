 //<>// //<>// //<>//
class PhotoViewer { 

  int numberOfImageInPanel = 5;  //============ CHANGE AS REQUIRED ============= // change it if you want to change number of images in one visible panel  
  int temp = numberOfImageInPanel;
  float iconWidth = 40;          //============ CHANGE AS REQUIRED =============


  private PVector pos = new PVector(0, 0);
  float Width, Height;
  Boolean hidden = false;
  ArrayList<PImage> imgArray;
  ArrayList<String> detailArray;
  PImage displayImage;
  String displayDetail = "";

  float panelImageX, panelImageY, panelImageHeight, panelImageWidth;

  Boolean isImageLoaded = false;

  ImageButton scrollRight, scrollLeft;
  ImageButton [] img = new ImageButton [numberOfImageInPanel]; 
  ImageButton clickedImgButton;  //to save which image is clicked in panel
  
  int panelNo = 1;
  int totalPanels = 0;
  int newImageCount = 0;
  int clickedPanel = panelNo;
  int imgPosInPanel = 0;
  
  int gap = 20;      // Minimum gap between imageViewer window and thumbnail panel  //============ CHANGE AS REQUIRED =============

  //Default constructor
  PhotoViewer() {}
  
  //Constructor
  PhotoViewer(float pos_X, float pos_Y, float W, float H) {
    pos.x = pos_X;
    pos.y = pos_Y;
    Width = W;    //Width of the viewer window
    Height = H;   //Height of the viewer window

    // Scroll Buttons   
    scrollLeft = new ImageButton(pos.x, pos.y+Height+20, iconWidth, iconWidth, loadImage("icons\\left1.png"), loadImage("icons\\left2.png"));
    scrollRight = new ImageButton(pos.x+W-iconWidth, pos.y+Height+20, iconWidth, iconWidth, loadImage("icons\\right1.png"), loadImage("icons\\right2.png"));
    // For image selection panel
    
  }

  // Load Images in array  //This method should run only once for one photo viewer object for efficiency
  void loadImages(ArrayList<PImage> imageList, ArrayList<String> detailList) {
    if (imageList != null && !imageList.isEmpty()) {
      while (imageList.get(0).width == 0) delay(50);  //Asynchronous loading can take time. So wait until loaded.
      this.imgArray = imageList;
      this.detailArray = detailList;
      //  Image Buttons in image selection panel
      numberOfImageInPanel = min(temp, imgArray.size());
      
      //Create ImageButtons for image selection panel here, Because only here we know the actual number of images..
      //  Image Buttons in image selection panel
      panelImageWidth = (Width - 2*iconWidth - (temp+1)*gap)/temp;    //Sets the image width in panel based on number of images
      panelImageHeight = panelImageWidth * 9/18;  //============ CHANGE AS REQUIRED =============
  
      panelImageX = (pos.x + iconWidth) + (Width - iconWidth*2 - panelImageWidth*numberOfImageInPanel - gap*(numberOfImageInPanel-1))/2;  // this places the images in center relative to viewer
      panelImageY = pos.y+Height + gap;
      for (int i=0; i<numberOfImageInPanel; i++) {
        img[i] = new ImageButton(panelImageX, panelImageY, panelImageWidth, panelImageHeight, null);  //At first image buttons will not have any imag 
        img[i].stretchImage = false;
        panelImageX += panelImageWidth + gap;    // Shift X-coordinate for next panel image
      }
      
      loadPanel(panelNo);
      
      displayImage = imgArray.get(0);  // By default first picture will be displayed 
      displayDetail = detailList.get(0);
      clickedImgButton = img[0];    //By default first picture is considered clicked
      
      
      //totalPanels = imgArray.size()%numberOfImageInPanel==0 ? imgArray.size()/numberOfImageInPanel : imgArray.size()/numberOfImageInPanel+1;
      totalPanels =  ceil((float)imgArray.size()/numberOfImageInPanel);
      //println("Total number of Panels : "+totalPanels);
    } else {
      System.out.println("\tERROR : Please load the images for Photo Viewer");
    }
  }

  // Render
  void render() {
    if (!this.hidden && imgArray != null) {
      // *** UI layout ***
      // 1.  Photo Viewer window Outline
      fill(constants.photoviewerBackgroundColor);          //TODO Photoviewer backgound colour
      noStroke();
      rect(pos.x, pos.y, Width, Height); //TODO Photoviewer position and size
      
      //Display Details
      fill(constants.imageDetailTextColor);
      textAlign(CENTER,CENTER);
      float textDetailHeight = constants.getWrappedTextHeight(this.displayDetail, Width);
      text(displayDetail, pos.x, constants.fitImageInWindow(this.displayImage, pos.x, pos.y, Width, Height-textDetailHeight), Width, textDetailHeight);
      
      //Render display Image
      //constants.fitImageInWindow(this.displayImage, pos.x, pos.y, Width, Height-textDetailHeight);

      // 2. Active Panel indicator   
      int gap = 16, D = 6;      //============ CHANGE AS REQUIRED ============ //assuming center of circles are separated by 16 pixels and has diameter of 6 pixels
      float markExtent = gap * (totalPanels-1);
      float X = pos.x + (Width-markExtent)/2;  //to position in the center   TODO - we can calculate coordinate positions for all kinds of elements using this technique 
      float Y = panelImageY+panelImageHeight + 20;
      
      if(totalPanels >1 ){    //If there is more than one image panel then show Active Panel indicator
        for (int i=1; i<=totalPanels; i++) {  
          stroke(constants.buttonHighlightColor);
          strokeWeight(1);
          if (i == panelNo)   //if this is current panel then fill differently
            fill(0);
          else 
          fill(255);
          circle(X, Y, D);
          X += gap;
        }
      } else {    // else no need to show Active Panel indicator and Scroll Buttons
        scrollLeft.hide();
        scrollRight.hide();
      }
      
      // 3. Photo Selector panel Render
      noStroke();    //No outline should be there for selector panel images
      scrollLeft.render();
      scrollRight.render();
      for (int i=0; i<numberOfImageInPanel; i++) {
        img[i].render();
      }

      // 4. Scroll Button Actions      
      if (scrollRight.isClicked()) {
        newImageCount = loadPanel(panelNo+1);
        if (newImageCount>0)
          panelNo += 1;
      }
      if (scrollLeft.isClicked()) {
        newImageCount = loadPanel(panelNo-1);
        if (newImageCount>0)
          panelNo -= 1;
      }
      //Hiding Left / Right Scroll Buttons
      if(panelNo == 1){
        scrollLeft.hide();
        scrollRight.unHide();
      } else if(panelNo == totalPanels){
        scrollRight.hide();
        scrollLeft.unHide();
      }

      // 5. Image buttons action on click      
      for (int i=0; i<numberOfImageInPanel; i++) {
        if (img[i].isClicked()) {
          this.displayImage = img[i].getDisplayImage();
          clickedImgButton = img[i];
          clickedPanel = panelNo;
          imgPosInPanel = i;
          displayDetail = img[i].buttonDetail;
          
          //Write to File
          writeTimeStamp();
          outFile.println("Displaying : " + displayDetail.split(":")[0] + " ,"+"clicked By User");
        }
      }      
      
        // Mark which image was clicked in panel
      if(clickedPanel == panelNo){ 
        noStroke();        
        fill(constants.buttonHighlightColor);  //TODO - change the fill color as required
        rect(clickedImgButton.pos.x, clickedImgButton.pos.y+clickedImgButton.Height+5, clickedImgButton.Width, 3, 2);
      }
      else if(abs(clickedPanel - panelNo) == 1){ // && (imgPosInPanel + newImageCount) < 2*numberOfImageInPanel-1){
        int newIndex = (clickedPanel - panelNo)*newImageCount + imgPosInPanel;
        //println("Clicked Panel : "+clickedPanel + "\t current Panel Number : " + panelNo + "\t New Image Count : " + newImageCount + "\t img Pos In Panel : "+imgPosInPanel);
        //println("\t New Image Index : " + newIndex);
        
        if(newIndex>=0 && newIndex < numberOfImageInPanel){        
          noStroke();
          fill(constants.buttonHighlightColor);  //TODO - change the fill color as required
          rect(img[newIndex].pos.x, img[newIndex].pos.y+img[newIndex].Height+5, img[newIndex].Width, 3, 2);
        }
      }
    }
  }


  //Loads given panel and returns number of new images loaded if requested panel number loads successfully
  int loadPanel(int panelNumber) {
    if (imgArray != null) {
      if(panelNumber == 1){
        for(int i=0; i< min(numberOfImageInPanel, imgArray.size()); i++) {          
          img[i].setDisplayImage(imgArray.get(i));
          img[i].buttonDetail = detailArray.get(i);
        }
        return imgArray.size();
      }
      int lastIndex = min (numberOfImageInPanel * panelNumber, imgArray.size());

      // *** if lastIndex == -ve, then panel number 0 is requested which is invalid
      // *** if numberOfImageInPanel * (panelNumber-1) > imgArray.size() that means previous panel was already overflowing so next panel doesn't exist
      if (lastIndex <= 0 || numberOfImageInPanel * (panelNumber-1) >= imgArray.size()) {
        return 0;
      }
      println("\nActual loaded image count : "+ (lastIndex-numberOfImageInPanel) + "\n");
      for (int i = lastIndex-1, j=numberOfImageInPanel-1; i >= lastIndex-numberOfImageInPanel; i--, j--) {
        img[j].setDisplayImage(imgArray.get(i));
        img[j].buttonDetail = detailArray.get(i);
      }
      return lastIndex-numberOfImageInPanel;
    }
    //if imgArray is null return false
    return 0;
  }

  //Hide and UnHide
  void hide() {
    this.hidden = true;
    if (imgArray != null) 
      for (int i=0; i<numberOfImageInPanel; i++) 
        img[i].hide();
    scrollLeft.hide();
    scrollRight.hide();
  }
  void unHide() {
    this.hidden = false;
    if (imgArray != null) 
      for (int i=0; i<numberOfImageInPanel; i++) 
        img[i].unHide();
    scrollLeft.unHide();
    scrollRight.unHide();
  }
  
  void reset(){
    this.panelNo = 1;
    this.totalPanels = 0;
    this.newImageCount = 0;
    this.clickedPanel = panelNo;
    this.imgPosInPanel = 0;
  }
}
