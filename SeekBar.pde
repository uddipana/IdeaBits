
//Seekbar inherits textButton
class SeekBar extends TextButton {    
  float movDuration = 0;
  private float seekTime = 0;
  private boolean clicked = false;
  private boolean pressed = false;
  PVector pos, pos1, pos2;
  ArrayList<PVector> seekBarMarkerPos = new ArrayList();
  int isSeekBarMarkerLoaded = 0;   
  color textColor = constants.buttonDefaultColor;      

  SeekBar(float pos_X, float pos_Y, float W, float H) {
    super.pos.x = pos_X;  
    super.pos.y = pos_Y;
    super.Width = W;
    super.Height = H;
    this.pos = super.pos;
  }

  //Render
  void render() {
    super.render(false);
  }

  //To be called only after movie is played, to record accurate duration of movie
  void setDuration(float dur) {
    this.movDuration = dur;
  }

  //Mark hotspots on the seekbar using array of seek time
  void setHotSpots(ArrayList<Float> hsArray) {
    for (int i=0; i<hsArray.size(); i++) { 
      float X = pos.x + (hsArray.get(i) * super.Width / this.movDuration);
      fill (255);
      rect(X, pos.y, 1, super.Height);
      triangle(++X, pos.y+super.Height-1, X-4, pos.y+super.Height+10, X+4, pos.y+super.Height+10);
    }
  }

  //Mark Intervals on the seekbar
  void setHotSpots(HashMap<Integer, ArrayList<Float[]>> videoHotSpots) {
    if (videoHotSpots != null && ! videoHotSpots.isEmpty()) {
      ArrayList<Float[]> hotSpotList = new ArrayList();
      Float X1, X2, Y1, Y2;
      //Mark interval for *System* 
      if (videoHotSpots.containsKey(1)) {
        hotSpotList = videoHotSpots.get(1);  //Hot Spot List for system
        for (int i=0; i<hotSpotList.size(); i++) {
          X1 = pos.x + (hotSpotList.get(i)[0] * super.Width / this.movDuration);
          X2 = pos.x + (hotSpotList.get(i)[1] * super.Width / this.movDuration);
          Y1 = pos.y+10;
          fill(255,122,123);
          rect(X1, pos.y, 1, 20);
          rect(X2-1, pos.y, 1, 20);
          rect(X1, Y1, X2-X1, super.Height);

          if (isSeekBarMarkerLoaded < 3) {
            pos1 = new PVector(X1, Y1); 
            pos2 = new PVector(X2, pos1.y + super.Height);
            seekBarMarkerPos.add(pos1);
            seekBarMarkerPos.add(pos2);
          }

//          //Color Table description - 1
//          rect(pos.x, pos.y+60, 15, 15);
//          fill(textColor);  //Font color
//          textAlign(LEFT, CENTER);  //Text alignment
//          textSize(constants.defaultTextSize);    //Set font size
//          text("System", pos.x+20, pos.y+60 + constants.defaultTextSize/5);
        }
      }
      isSeekBarMarkerLoaded++ ;

      //Mark interval for *Manipulation* 
      if (videoHotSpots.containsKey(2)) {
        hotSpotList = videoHotSpots.get(2);  //Hot Spot List for Manipulation
        for (int i=0; i<hotSpotList.size(); i++) {
          X1 = pos.x + (hotSpotList.get(i)[0] * super.Width / this.movDuration);
          X2 = pos.x + (hotSpotList.get(i)[1] * super.Width / this.movDuration);
          Y1 = pos.y+20;
          fill(122,211,122);      
          rect(X1, pos.y, 1, 30);
          rect(X2-1, pos.y, 1, 30);
          rect(X1, Y1, X2-X1, super.Height);

          if (isSeekBarMarkerLoaded < 3) {
            pos1 = new PVector(X1, Y1); 
            pos2 = new PVector(X2, pos1.y + super.Height);
            seekBarMarkerPos.add(pos1);
            seekBarMarkerPos.add(pos2);
          }

//          //Color Table description - 2
//          rect(pos.x + super.Width/3, pos.y+60, 15, 15);          
//          fill(textColor);  //Font color
//          textAlign(LEFT, CENTER);  //Text alignment
//          textSize(constants.defaultTextSize);    //Set font size
//          text("Manipulation", pos.x + 20 + super.Width/3, pos.y+60 + constants.defaultTextSize/5);
        }
      }
      isSeekBarMarkerLoaded++ ;

      //Mark interval for *Implementation* 
      if (videoHotSpots.containsKey(3)) {
        hotSpotList = videoHotSpots.get(3);  //Hot Spot List for Manipulation
        for (int i=0; i<hotSpotList.size(); i++) {
          X1 = pos.x + (hotSpotList.get(i)[0] * super.Width / this.movDuration);
          X2 = pos.x + (hotSpotList.get(i)[1] * super.Width / this.movDuration);
          Y1 = pos.y+30;
          fill(124,124,254);
          rect(X1, pos.y, 1, 40);
          rect(X2-1, pos.y, 1, 40);
          rect(X1, Y1, X2-X1, super.Height); 
          pos1 = new PVector(X1, Y1); 
          pos2 = new PVector(X2, pos1.y + super.Height);
          seekBarMarkerPos.add(pos1);
          seekBarMarkerPos.add(pos2);

//          //Color Table description - 3
//          rect(pos.x + super.Width/3*2, pos.y+60, 15, 15);          
//          fill(textColor);  //Font color
//          textAlign(LEFT, CENTER);  //Text alignment
//          textSize(constants.defaultTextSize);    //Set font size
//          text("Implementation", pos.x + 20 + super.Width/3*2, pos.y+60 + constants.defaultTextSize/5);
        }
      }
      isSeekBarMarkerLoaded++ ;
    }
  }


  Boolean isClicked() {
    if (super.isClicked()) {
      seekTime = (mouseX - pos.x) * movDuration / super.Width;
      return true;
    } else {
      if (seekBarMarkerPos != null) {
        for (int i=0; i<seekBarMarkerPos.size(); i+=2) { 
          pos1 = seekBarMarkerPos.get(i);
          pos2 = seekBarMarkerPos.get(i+1);
          this.updateClick();
          if (clicked) {
            seekTime = (pos1.x - pos.x) * movDuration / super.Width;
            println("seek Time : "+seekTime);
            break;
          }
        }
      }
    }
    return clicked;
  }

  float getSeekTime() {
    return seekTime;
  }

  private void updateClick()  //Registers click event
  {
    if (mousePressed && mouseButton == LEFT && !pressed && !hidden) {
      pressed = true;
      if (this.isMouseOverMarker()) {
        clicked = true;
        delay(100);    // Delay added to restrict redundant clicks
        //System.out.println("Button Clicked");
      }
    } else {
      clicked = false;
      pressed = false;
    }
  }  

  private Boolean isMouseOverMarker() {
    if (mouseX >= pos1.x && mouseX <= pos2.x && mouseY >= pos1.y && mouseY <= pos2.y)
      return true;
    return false;
  }

  void reset() {
    this.seekBarMarkerPos.clear();
    this.isSeekBarMarkerLoaded = 0;
  }
}
