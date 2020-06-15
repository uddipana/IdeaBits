class RadioButton {

  PVector pos = new PVector(0, 0);
  float Width, Height;
  int gap = 20;              //*************** CHANGE AS REQUIRED **********************

  ArrayList<TextButton> radioButtonsList = new ArrayList();
  int selectedIndex = -1;  //initially non is selected
  color selectionColor = color(226);
  color hoverColor = color(233);
  color defaultColor = color(240);
  color textColor = color(66, 133, 177);  
  color currColor = defaultColor;

  //Constants constants = new Constants();
  boolean hidden = false;

  //Constructor
  RadioButton(float pos_X, float pos_Y, float Wa, float buttonHeight, int buttonCount) {      //Takes starting coordinates and width of the pane as parameters
    this.pos.x = pos_X;
    this.pos.y = pos_Y;
    this.Width = Wa;      // if Width passed is 0 then set Width to default
    this.Height = buttonHeight;    // if Height passed is 0 then set height to default

    //Add buttons
    //float X=pos.x, Y=pos.y; 
    
    float a, b, c, d, e, f, g, h, i, j;
    float A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, AA, BB, CC, DD, EE, FF;
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
    
    for (int itr=0; itr<buttonCount; itr++) {
      TextButton textButton = new TextButton(pos.x, pos.y, Width, Height, "");       
      pos.y += Height + (b-(g/3+f+g/2+f+g/2)-g-Height)/4;  //TODO - Adjust coordinate for next button

      //set button colors and attributes
      textButton.defaultColor = defaultColor;
      textButton.highlightColor = hoverColor;
      textButton.textColor = textColor;
      textButton.Curve = 5;

      radioButtonsList.add(textButton);
    }
  }

  //Render
  void render() {
    if (!hidden) {
      for (int i=0; i<radioButtonsList.size(); i++) {
        TextButton temp = radioButtonsList.get(i);
        
        // Radio selection
        if (temp.isClicked()) { 
          selectedIndex = i;  // if a button is clicked, it's index is the one selected
        }
        if (i == selectedIndex) {
          temp.defaultColor = selectionColor;
          temp.render(false);
        } else {
          temp.defaultColor = defaultColor;
          temp.render();
        }
      }
    }
  }

  //To get selected index
  int getSelectedIndex() {
    return selectedIndex;
  }

  //To set selected Index
  void setSelectedIndex(int index) {
    this.selectedIndex = index;
  }

  // To change button height of all buttons
  void setButtonHeight(float H) {
    this.Height = H;
  }  

  // To set text of a particular button
  void setButtonText(int index, String text) {
    if (radioButtonsList != null && radioButtonsList.size() >= index)
      radioButtonsList.get(index).Text = text;
    else {
      println("\t IndexOutOFBound");
      return;
    }
  }

  //Hide - Unhide
  void hide() {
    hidden = true;
    for (TextButton temp : radioButtonsList)
      temp.hide();
  }
  void unHide() {
    hidden = false;
    for (TextButton temp : radioButtonsList)
      temp.unHide();
  }
}
