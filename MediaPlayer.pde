class MediaPlayer {
  

  private PVector pos = new PVector(0, 0);
  float Width, Height;      //Media player window width and height

  ImageButton playButton, pauseButton, stopButton, tempButton, windowSizedPlayPauseButton;//windowSizedPlayPauseButton;
  Movie movie;
  SeekBar seekBar, seekBarOverlay, seekBarHover;    //seekBarOverlay indicates progress of movie  //seekBarHover reacts when mouse is over seek bar
  float seekBar_W, seekBar_H, seekBar_X, seekBar_Y;
  float playTime_textWidth, playTime_textSize;
  PImage playIcon, pauseIcon;
  Boolean hidden = false;
  Boolean movieExist = false;
  Boolean isFirstLoad = true;
  float movieDuration = 0;

  //Variables to record movie states
  final int STOP = 0, PAUSE = 1, PLAY = 2, FINISH = 3;
  int palyPauseToggle = PLAY;  //Toggle between play and pause
  private int movieState = STOP; 
  private boolean isMovieStateChanged = false;

  MediaPlayer(float pos_X, float pos_Y, float W, float H) {
    pos.x = pos_X;
    pos.y = pos_Y;
    Width = W;
    Height = H;

    //Invisible Button for play-pause function on clicking the video
    windowSizedPlayPauseButton = new ImageButton();
    windowSizedPlayPauseButton.pos = this.pos;
    windowSizedPlayPauseButton.Width = this.Width;
    windowSizedPlayPauseButton.Height = this.Height;

    //Play Icon
    playIcon = loadImage("icons\\play1.png");
    pauseIcon = loadImage("icons\\play2.png");
    playIcon.resize(40, 40);
    pauseIcon.resize(40, 40);
    playButton = new ImageButton(pos_X + 10, pos_Y + H, playIcon.width, playIcon.height, playIcon, pauseIcon);   

    //Pause Icon
    playIcon = loadImage("icons\\pause1.png");
    pauseIcon = loadImage("icons\\pause2.png");
    playIcon.resize(40, 40);
    pauseIcon.resize(40, 40);
    pauseButton = new ImageButton(pos_X + 10, pos_Y + H, playIcon.width, playIcon.height, playIcon, pauseIcon);  //at same position as play

    //Stop Icon
    playIcon = loadImage("icons\\stop1.png");
    pauseIcon = loadImage("icons\\stop2.png");
    playIcon.resize(40, 40);
    pauseIcon.resize(40, 40);
    stopButton = new ImageButton(pos_X + 50, pos_Y + H, playIcon.width, playIcon.height, playIcon, pauseIcon);

    //Play Time    
    seekBar_H = 10;
    playTime_textSize = seekBar_H*1.5;  //TODO - to change the text size of play-timer text change this value
    textSize(playTime_textSize);
    playTime_textWidth = textWidth(constants.playTimeFormat) + 30;  //TODO- to increase gap between play-timer-text and seek bar, change the hardcoded values
    
    //Seek Bar          //TODO - set seek-bar size and location free from hardcoded values
    float seekBar_Xshift = 100;
    seekBar_X = pos.x+seekBar_Xshift;
    seekBar_Y = pos.y+Height+15;
    seekBar_W = Width- seekBar_Xshift - playTime_textWidth;    //Reducing the length of scroll bar by 30 to accomodate Play time display 
    seekBar = new SeekBar(seekBar_X, seekBar_Y, seekBar_W, seekBar_H); 
    seekBarOverlay = new SeekBar(seekBar_X, seekBar_Y, 0, seekBar_H); //Initially seekbar overlay has zero width 
    seekBarHover = new SeekBar(seekBar_X, seekBar_Y, 0, seekBar_H); //Initially seekbar Hover has zero width

    seekBar.defaultColor = color(105);    //============ CHANGE AS REQUIRED ============= //TODO - Change colors as required
    seekBarOverlay.defaultColor = color(255);  //default color is orange     
    //seekBarOverlay.highlightColor = color(199, 0, 57); //On hoverover color changes to maroon   
    seekBarHover.defaultColor = color(169);    //default color is faded orange
  }

  //Render
  void render() {
    if (!hidden) {
      //Player window Outline
      //stroke(constants.buttonHighlightColor);
      //strokeWeight(1);
      noStroke();
      fill(0);
      rect(pos.x, pos.y, Width, Height+constants.bottomPanelHeight);   //Includes the area of bottom panel also

      //// Media Player bottom panel
      //rect(pos.x, pos.y+Height, Width, bottomPanelHeight);    

      /**** Place Buttons on player panel ****
       ***************************************/
      movieExist = this.movie != null;
      if (movieExist) {
        // Initiate Movie
        if (isFirstLoad) {
          isFirstLoad = false;
          movie.pause();    //***** needed to report accurate movie duration
          movieDuration = movie.duration();
          seekBar.setDuration(movieDuration);  //Seek Bar duration is set when movie is first loaded 
          seekBar.reset();
          //movie.stop();
        }
        // Movie position
        constants.fitVideoInWindow(movie, pos.x, pos.y, Width, Height);
      }

      // Play-pause toggle button
      if (palyPauseToggle == PLAY) {
        playButton.render();
        if ((playButton.isClicked() || windowSizedPlayPauseButton.isClicked()) && movieExist) {
          setMovieState(PLAY);
          writeTimeStamp();
          outFile.print("Play button clicked ,");
        }
      } else if (palyPauseToggle == PAUSE){
        pauseButton.render();
        if ((pauseButton.isClicked() || windowSizedPlayPauseButton.isClicked()) && movieExist) {
          setMovieState(PAUSE);
          writeTimeStamp();
          outFile.print("Pause button clicked ,");
        }
      }    
      // stop button
      stopButton.render();
      if (stopButton.isClicked() && movieExist) {
        setMovieState(STOP);
          writeTimeStamp();
          outFile.print("Stop button clicked ,");
      }

      // time Seek bar  
      seekBar.render();   
      seekBarHover.render();
      seekBarOverlay.render();

      seekBarOverlay.Width = max(seekBar_H, movie.time()/movieDuration*seekBar_W);
      if (seekBar.isMouseOver())
        seekBarHover.Width = max(seekBarOverlay.Width, mouseX-seekBar_X);
      else 
      seekBarHover.Width=0;
      if (seekBar.isClicked() && movieExist) {  //SeekBar click event
        movie.jump(seekBar.getSeekTime());
        
        //Writing to file
        writeTimeStamp();
        outFile.print("Movie Seek Bar Clicked ,");
        outFile.println("Seek Time Jump : "+seekBar.getSeekTime()+" ,");
      }
      
      //Showing Play Time
      textSize(playTime_textSize);
      textAlign(CENTER, CENTER);
      String playTime = constants.getFormattedTimeAsString(movie.time());
      playTime = playTime + " / " + constants.getFormattedTimeAsString(movieDuration);
      
      text(playTime, seekBar_X+seekBar_W+playTime_textWidth/2, seekBar_Y+seekBar_H/2);
      
      //If movie stops after playing entire video then update buttons state accordingly
      //println(movie.time() + " : " +movieDuration);
      if(movie.time()+0.1 >= movieDuration){
        setMovieState(FINISH);  //Pausing the video will retain the video seeking function.
        writeTimeStamp();
      }
      
      //Actuate the movie state
      if (isMovieStateChanged) {
        //println("movie state changed");
        isMovieStateChanged = false; 
        //writeTimeStamp();
        
        switch(movieState) {
        case PLAY:
          movie.play();
          palyPauseToggle = PAUSE;
          outFile.println("Movie Played ,");
          break;
        case PAUSE:
          movie.pause();
          palyPauseToggle = PLAY;
          outFile.println("Movie Paused ,");
          break;
        case STOP:
          movie.pause();
          movie.stop();
          palyPauseToggle = PLAY; 
          outFile.println("Movie Stopped ,");
          break;
        case FINISH:
          movie.pause();
          palyPauseToggle = PLAY;
          movie.jump(0);  //Bring the seek time to zero. Because won't bring that to zero automatically       
          outFile.println("Movie Finished ,");
          break;
        }
      }
    }
  }

  // For setting Movie
  void setMovie(Movie mov) {
    this.movie = mov;
  }

  // For setting Hotspots on seek bar
  void setHotSpots(HashMap<Integer, ArrayList<Float[]>> videoHotSpots) {
    seekBar.setHotSpots(videoHotSpots);
  }

  // Set movie state
  void setMovieState(int state) {
    this.movieState = state;
    isMovieStateChanged = true;
  }
  // Get movie state
  int getMovieState() {
    return this.movieState;
  }
  // Hide and UnHide
  void hide() {
    this.hidden = true;
    playButton.hide();
    pauseButton.hide();
    stopButton.hide();
    if (movieExist) {
      this.movie.pause();
      this.movie.stop();
      movieState = STOP;
      palyPauseToggle = PLAY;
    }
  }
  void unHide() {
    this.hidden = false;
    playButton.unHide();
    pauseButton.unHide();
    stopButton.unHide();
  }
}
