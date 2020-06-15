import processing.video.*;

class HomePage
{
  private String pageParam;
  int numberOfFrames = 5;    //How many frames you want on the homepage
  Frame [] frame;
  PImage [] img;
  Movie [] mov;

  Boolean hidden = false;
  float a, b, c, d, e, f, g, h, i, j;
  float A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, AA, BB, CC, DD, EE, FF;
  
  //Constructor
  HomePage(IdeaBits obj) {
    // Home Page
    println("Loading Home Page Data");
    frame = new Frame[numberOfFrames];
    img = new PImage[numberOfFrames];
    mov = new Movie[numberOfFrames];
    for (int itr=0; itr<numberOfFrames; itr++) {
      img[itr] = requestImage("ar"+itr+".jpg");
      mov[itr] = new Movie(obj, "how"+itr+".mp4");
      //print("loading homepage data\n");
    }

    //a = constants.windowWidth;
    //b = constants.windowHeight;
    //c = 3*(25*a - 8*b)/289;
    //d = 9*c/16;
    //e = (3*a-13*c)/24;
    //f = 4*e;
    //g = 4*e;
    //h = 8*e;
    //i = 2*c/3;
    //j = 37*c/12 - 5*a/8;

    //A=
    //B=
    //C=
    //D=
    //E=
    //F=
    //G=
    //H=
    //I=
    //J=
    //K=
    //L=
    //M=
    //N=
    //O=
    //P=
    //Q=
    //R=
    //S=
    //T=
    //U=
    //V=
    //W=
    //X=
    //Y=
    //Z=
    //AA=
    //BB=
    //CC=
    //DD=
    //EE=
    //FF=

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


    //println("a="+a+"\tb="+b+"\tc="+c+"\td="+d+"\te="+e+"\tf="+f+"\tg="+g+"\th="+h+"\ti="+i+"\tj="+j);

    float x_offset, y_offset = 1.5*g + h;   //Y coordinate of the frames in first line
    frame[0] = new Frame (g, y_offset, c, d, f, e, constants.bend, img[0], mov[0]);
    frame[1] = new Frame (g+c+i, y_offset, c, d, f, e, constants.fold, img[1], mov[1]);
    frame[2] = new Frame (g+c+i+c+i, y_offset, c, d, f, e, constants.pull, img[2], mov[2]);

    //calculate Y coordinate of the frames in second line (if planning for second line) 
    y_offset = y_offset + d+e+f+j;
    x_offset = (a-2*c-i)/2;
    frame[3] = new Frame (x_offset, y_offset, c, d, f, e, constants.squeeze, img[3], mov[3]);
    frame[4] = new Frame (x_offset +c+i, y_offset, c, d, f, e, constants.stretch, img[4], mov[4]);
  }

  //Render
  void render() {
    if (!hidden) {
      fill(constants.buttonDefaultColor);  //Font color
      textAlign(CENTER, TOP);  //Text alignment
      textSize(h);    //Set font size
      text("Idea Bits", constants.windowWidth/2, g/2);
      for (int itr=0; itr<numberOfFrames; itr++) {
        if (frame[itr] != null) frame[itr].render();
      }
    }
  }

  //This function returns frame number that is clicked starting from 0
  int getClickedFrameNo() {
    if (!hidden) {
      for (int itr=0; itr<numberOfFrames; itr++) {
        if (frame[itr] != null && frame[itr].isClicked()) {
          writeTimeStamp();
          outFile.println("Frame : "+frame[itr].buttonText+" is Clicked"+ ",");
          return itr;
        }
      }
    }
    return -1; // if none clocked or error
  }

  void hide() {
    this.hidden = true;
    for (int itr=0; itr<numberOfFrames; itr++) {
      if (frame[itr] != null) frame[itr].hide();
    }
  }
  void unHide() {
    this.hidden = false;
    for (int itr=0; itr<numberOfFrames; itr++) {
      if (frame[itr] != null) frame[itr].unHide();
    }
  }
}
