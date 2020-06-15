import processing.video.*; //<>//

class ImageButton extends Button
{

  PImage mainImage, displayImage, highlightImage;  //Button shows image assigned to displayImage
  Movie movie;
  IdeaBits ideaBits;

  boolean stretchImage = true;
  boolean isMovieStopped = false;
  String buttonDetail = "";
  private boolean isMouseEventChanged = false;
  private boolean isHighlighted = false;
  private boolean isDefaultFilled = false;

  //Constructors to instanciate Image button
  ImageButton(float pos_X, float pos_Y, float buttonWidth, float buttonHeight, PImage image) {
    super.pos.x = pos_X;
    super.pos.y = pos_Y;
    super.Width = buttonWidth;
    super.Height = buttonHeight;
    this.displayImage = image;
  }

  //Constructors to instanciate Image button which changes image on mouse hover
  ImageButton(float pos_X, float pos_Y, float buttonWidth, float buttonHeight, PImage image, PImage hoverImage) {
    super.pos.x = pos_X;
    super.pos.y = pos_Y;
    super.Width = buttonWidth;
    super.Height = buttonHeight;
    this.mainImage = image;
    this.displayImage = mainImage;
    this.highlightImage = hoverImage;
  }

  //Constructors to instanciate Image button which plays movie on mouse hover.
  ImageButton(float pos_X, float pos_Y, float buttonWidth, float buttonHeight, PImage image, Movie movie) {
    super.pos.x = pos_X;
    super.pos.y = pos_Y;
    super.Width = buttonWidth;
    super.Height = buttonHeight;
    this.displayImage = image;
    this.movie = movie;
  }

  //Default Constructor
  ImageButton() {
  }

  void render () {
    render(true);
  }

  void render(Boolean reactive) {  
    if (!super.hidden) {
      if (displayImage != null) {
        if (stretchImage) {  //if stretching is allowed
          image(displayImage, pos.x, pos.y, Width, Height);
        } else {   //if stretching is not allowed
          fill(constants.thumbnailBackgroundColor);          //TODO Thumbnail background colour
          rect(pos.x, pos.y, Width, Height);
          //stroke(0);
          //strokeWeight(1);
          constants.fitImageInWindow(displayImage, pos.x+1, pos.y+1, Width-2, Height-2);
        }
      }
      if (movie != null && !isMovieStopped)
        image(movie, pos.x, pos.y, Width, Height);  
      if (reactive && (movie != null || highlightImage != null)) {   //if image button has no highlight element then it need not be reactive
        if (super.isMouseOver()) {
          highlightFill();
        } else {
          defaultFill();
        }
      }
    }
  }

  //GET - SET method for button's display image
  void setDisplayImage(PImage img) {
    this.displayImage = img;
  }
  PImage getDisplayImage() {
    return this.displayImage;
  }

  // Mouse over/off action 
  void defaultFill() {
    if (!isDefaultFilled) {
      isDefaultFilled = true;
      isHighlighted = false;
      if (movie != null) {
        movie.stop();
        isMovieStopped = true;
      } else
        displayImage = mainImage;
    }
  }
  void highlightFill() {
    if (!isHighlighted) {
      isHighlighted = true;
      isDefaultFilled = false;
      if (movie != null) {
        isMovieStopped = false;
        movie.play();
      } else      //else if (highlightImage != null)
      displayImage = highlightImage;
    }
  }
}
