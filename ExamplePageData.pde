/*===================================================================================
 ** Set Data for every element in example pages here
 ===================================================================================*/

class ExamplePageData {
  final int backClicked = 1;
  final int tab1Clicked = 2;
  final int tab2Clicked = 3;
  HashMap<Integer, ExamplePage> loadedData = new HashMap();
  HashMap<Integer, String> PDFViewerFileNames = new HashMap();

  void loadExamplePageData(Integer param, ExamplePage exPage, IdeaBits obj) {

    //Using Dynamic Programming concept to make the program run faster after first load
    if ( loadedData.isEmpty() || !loadedData.containsKey(param)) {    //if data is not already loaded then load them.
      ExamplePage ep = new ExamplePage(obj);

      switch (param) {

        //frame-0 is clicked on home page
      case 0:   // Bend - Twist Blocks
        ep.headerText = constants.bend;
        ep.tabButton_1.Text = "Twist Blocks";
        ep.tabButton_2.Text = "Ninja Track";

        //For Media Player
        ep.movie = new Movie(obj, "Bend1V.mp4"); 

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A0 = {0, 4, 
                       18, 48};
        float [] B0 = {27, 29, 
                       56, 57};
        float [] C0 = {62, 68};

        formHotSpotObject(ep.videoHotSpots, 1, A0);
        formHotSpotObject(ep.videoHotSpots, 2, B0);
        formHotSpotObject(ep.videoHotSpots, 3, C0);

        //For Photo Viewer - load photos  and photo details
        ep.photoViewerImgArray.add(requestImage("Bend1Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: TwistBlocks as physical armatures.");
        ep.photoViewerImgArray.add(requestImage("Bend1Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: (a) Building a physical armature with TwistBlocks. (b) Generating a coressponding initial armature. (c) Adjusting the bones digitally to rig the model. (d, e) Performing a relative deformation using physical manipulation [bending].");
        ep.photoViewerImgArray.add(requestImage("Bend1Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: (a) Designing a lamp based on the physical armature. (b) Rotating the armature in order to observe the digital model from different directions. (c) Adjusting the lampstand using physical manipulation [bending].");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Bend\\Bend1.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://learn.sparkfun.com/tutorials/flex-sensor-hookup-guide/all";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

      case 10:   //Bend - Ninja Track
        ep.headerText = constants.bend;
        ep.tabButton_1.Text = "Twist Blocks";
        ep.tabButton_2.Text = "Ninja Track";

        //For Media Player
        ep.movie = new Movie(obj, "Bend2V.mp4");  
        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A10 = {57, 60, 
                        72, 79, 
                        99, 109};
        float [] B10 = {75, 77, 
                        101, 107};

        formHotSpotObject(ep.videoHotSpots, 1, A10);
        formHotSpotObject(ep.videoHotSpots, 2, B10);

        //For Photo Viewer - load photos  // TODO - Can use for-loop on File.list() if images are maintained in corresponding folders. 
        ep.photoViewerImgArray.add(requestImage("Bend2Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: The prototype.");
        ep.photoViewerImgArray.add(requestImage("Bend2Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: The back side of the prototype.");
        ep.photoViewerImgArray.add(requestImage("Bend2Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: Bending to play Sax sound.");
        ep.photoViewerImgArray.add(requestImage("Bend2Id.JPG"));
        ep.photoViewerDetailArray.add("Figure 4: Schematic of the prototype.");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Bend\\Bend2.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://learn.sparkfun.com/tutorials/flex-sensor-hookup-guide/all";
        
        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

      case 1: //Fold - Easigami 
        ep.headerText = constants.fold;
        ep.tabButton_1.Text = "Easigami";
        ep.tabButton_2.Text = "Paddle";      

        //For Media Player
        ep.movie = new Movie(obj, "Fold1V.mp4");  

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A1 = {0, 5, 
                      19, 26, 
                      42, 44, 
                      101, 129};
        float [] B1 = {0, 14, 
                      42, 71, 
                      101, 118};

        formHotSpotObject(ep.videoHotSpots, 1, A1);
        formHotSpotObject(ep.videoHotSpots, 2, B1);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Fold1Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Building a tetrahedron in process using the Easigami TUI.");
        ep.photoViewerImgArray.add(requestImage("Fold1Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: The Easigami software displays the digital 3D model, which echoes the physical construction.");
        ep.photoViewerImgArray.add(requestImage("Fold1Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: Polygonal pieces from the Easigami kit. Each piece has housing elements in its edges that permit pieces to beconnected by hinges.");
        ep.photoViewerImgArray.add(requestImage("Fold1Id.JPG"));
        ep.photoViewerDetailArray.add("Figure 4: Multicolored Easigami hinges. These act as connectors between adjacent polygons. The wings of the hinge are flexible enough to rotate 360 degrees about the central axis.");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Fold\\Fold1.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://learn.sparkfun.com/tutorials/the-great-big-guide-to-paper-circuits/all";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

        //frame-2 is clicked on home page 
      case 11:   //Fold - Paddle
        ep.headerText = constants.fold;
        ep.tabButton_1.Text = "Easigami";
        ep.tabButton_2.Text = "Paddle";     

        //For Media Player
        ep.movie = new Movie(obj, "Fold2V.mp4");  
        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A11 = {0, 2};
        float [] B11 = {15, 15, 
                        15, 26};

        formHotSpotObject(ep.videoHotSpots, 1, A11);
        formHotSpotObject(ep.videoHotSpots, 2, B11);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Fold2Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: The prototype.");
        ep.photoViewerImgArray.add(requestImage("Fold2Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: Folding of a part to peek at the layer underneath.");
        ep.photoViewerImgArray.add(requestImage("Fold2Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: Folding of a part to look at the next page.");
        ep.photoViewerImgArray.add(requestImage("Fold2Id.JPG"));
        ep.photoViewerDetailArray.add("Figure 4: Transformations supported by Paddle can be used for many purposes. For example, (a) a game controller, (b) opening a toolpalet.");
        ep.photoViewerImgArray.add(requestImage("Fold2Ie.JPG"));
        ep.photoViewerDetailArray.add("Figure 5: Physical controls (i.e. Paddle controls) for peeking as alternatives for traditional touch interactions.");
        ep.photoViewerImgArray.add(requestImage("Fold2If.JPG"));
        ep.photoViewerDetailArray.add("Figure 6: Physical controls (i.e. Paddle controls) for leafing as alternatives for traditional touch interactions.");
        ep.photoViewerImgArray.add(requestImage("Fold2Ig.JPG"));
        ep.photoViewerDetailArray.add("Figure 7: Some of the transformations that are supported by Paddle.");
        ep.photoViewerImgArray.add(requestImage("Fold2Ih.JPG"));
        ep.photoViewerDetailArray.add("Figure 8: The wiring pattern used for the hinges in Paddle: (a) flat form factor, (b) ring form factor.");

        //Load image file name for PDF Viewer
        ep.pdfViewerFileName = "papers\\Fold\\Fold2.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://learn.sparkfun.com/tutorials/the-great-big-guide-to-paper-circuits/all";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;


        //frame-3 is clicked on home page  
      case 2:    //Pull - Rope Plus
        ep.headerText = constants.pull;
        ep.tabButton_1.Text = "Rope Plus";
        ep.tabButton_2.Text = "Memento";      

        //For Media Player
        ep.movie = new Movie(obj, "Pull1V.mp4");

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A2 = {15,43};
        float [] B2 = {25,30,
                       42,44};
        float [] C2 = {94,100};

        formHotSpotObject(ep.videoHotSpots, 1, A2);
        formHotSpotObject(ep.videoHotSpots, 2, B2);
        formHotSpotObject(ep.videoHotSpots, 3, C2);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Pull1Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Preliminary game designs.");
        ep.photoViewerImgArray.add(requestImage("Pull1Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: Pulling of the rope and it's digital output in Multi-Fly game.");
        ep.photoViewerImgArray.add(requestImage("Pull1Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: Different ways of pulling the rope in Multi-Fly.");
        ep.photoViewerImgArray.add(requestImage("Pull1Id.JPG"));
        ep.photoViewerDetailArray.add("Figure 4: The real rope merging with the virtual rope in Multi-Fly.");
        ep.photoViewerImgArray.add(requestImage("Pull1Ie.JPG"));
        ep.photoViewerDetailArray.add("Figure 5: User interface of Multi-Fly.");
        ep.photoViewerImgArray.add(requestImage("Pull1If.JPG"));
        ep.photoViewerDetailArray.add("Figure 6: Hardware for Multi-Fly.");
        ep.photoViewerImgArray.add(requestImage("Pull1Ig.JPG"));
        ep.photoViewerDetailArray.add("Figure 7: Rope serves as connection between physical and virtual world.");
        ep.photoViewerImgArray.add(requestImage("Pull1Ih.JPG"));
        ep.photoViewerDetailArray.add("Figure 8: System setup.");
        ep.photoViewerImgArray.add(requestImage("Pull1Ii.JPG"));
        ep.photoViewerDetailArray.add("Figure 9: System diagram for Multi-Fly.");


        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Pull\\Pull1.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://maker.pro/arduino/tutorial/how-to-use-an-ldr-sensor-with-arduino";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

      case 12:  //Pull - Memento
        ep.headerText = constants.pull;
        ep.tabButton_1.Text = "Rope Plus";
        ep.tabButton_2.Text = "Memento";      

        //For Media Player
        ep.movie = new Movie(obj, "Pull2V.mp4");  

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A12 = {5,47};
        float [] B12 = {42,42,
                        42,57};

        formHotSpotObject(ep.videoHotSpots, 1, A12);
        formHotSpotObject(ep.videoHotSpots, 2, B12);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Pull2Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Memento.");
        ep.photoViewerImgArray.add(requestImage("Pull2Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: Open the back lid to playback fragments. Browse through the fragments by pulling the chain through the pendant.");
        ep.photoViewerImgArray.add(requestImage("Pull2Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: The sound fragments are positioned around the chain of the locket. The size of the track depends on the total number of playbacks. Users can change the track by pulling the chain through the pendant.");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Pull\\Pull2.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://maker.pro/arduino/tutorial/how-to-use-an-ldr-sensor-with-arduino";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;   

        //frame-4 is clicked on home page
      case 3:      //Squeeze - Photoelastic Touch 
        ep.headerText = constants.squeeze;
        ep.tabButton_1.Text = "Photoelastic Touch";
        ep.tabButton_2.Text = "Tessella";      
        ep.movie = null;    

        //For Media Player
        ep.movie = new Movie(obj, "Squeeze1V.mp4");  

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A3 = {2,21};
        float [] B3 = {11,14,
                      17,20};
        float [] C3 = {57,122};

        formHotSpotObject(ep.videoHotSpots, 1, A3);
        formHotSpotObject(ep.videoHotSpots, 2, B3);        
        formHotSpotObject(ep.videoHotSpots, 3, C3);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Squeeze1Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Tangible objects made from transparent elastic body.");
        ep.photoViewerImgArray.add(requestImage("Squeeze1Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: Tangible interface using rubbery face model.");
        ep.photoViewerImgArray.add(requestImage("Squeeze1Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: Paint application using squeezing interaction.");
        ep.photoViewerImgArray.add(requestImage("Squeeze1Id.JPG"));
        ep.photoViewerDetailArray.add("Figure 4: The filter on the camera blocks the incoming light from the LCD. However, elliptically polarized light induced by deformed regions of the elastic body is visible to the camera.");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Squeeze\\Squeeze1.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://learn.sparkfun.com/tutorials/force-sensitive-resistor-hookup-guide/all";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

      case 13:  //Squeeze - Tessella   
        ep.headerText = constants.squeeze;
        ep.tabButton_1.Text = "Photoelastic Touch";
        ep.tabButton_2.Text = "Tessella";        
        ep.movie = null;    

        //For Media Player
        ep.movie = new Movie(obj, "Squeeze2V.mp4");  

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A13 = {0,4,
                        12,55,
                        113,127};
        float [] B13 = {38,43,
                        75,79,
                        149,163,
                        176,190,
                        202,208,
                        235,243};

        formHotSpotObject(ep.videoHotSpots, 1, A13);
        formHotSpotObject(ep.videoHotSpots, 2, B13);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Squeeze2Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Squeeze interaction with Tessella.");
        ep.photoViewerImgArray.add(requestImage("Squeeze2Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: Squeeze interaction with Tessella.");
        ep.photoViewerImgArray.add(requestImage("Squeeze2Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: LEDs and sensors matrix.");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Squeeze\\Squeeze2.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://learn.sparkfun.com/tutorials/force-sensitive-resistor-hookup-guide/all";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

        //frame-5 is clicked on home page
      case 4:    // Stretch - Cord UIs
        ep.headerText = constants.stretch;
        ep.tabButton_1.Text = "Cord UIs";
        ep.tabButton_2.Text = "Stretch E Band";      
        ep.movie = null;    

        //For Media Player
        ep.movie = new Movie(obj, "Stretch1V.mp4");  

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A4 = {18,20,
                      121,123,
                      131,141};
        float [] B4 = {135,137};
        float [] C4 = {124,130};

        formHotSpotObject(ep.videoHotSpots, 1, A4);
        formHotSpotObject(ep.videoHotSpots, 2, B4);
        formHotSpotObject(ep.videoHotSpots, 3, C4);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Stretch1Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Stretchable cord with rubber resistive cord to sense pulling.");
        ep.photoViewerImgArray.add(requestImage("Stretch1Ib.JPG")); 
        ep.photoViewerDetailArray.add("Figure 2: Stretching the USB cord safe-ejects the hard drive.");   

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Stretch\\Stretch1.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://www.hackster.io/Juliette/measuring-stretch-forces-with-a-conductive-rubber-cord-d1528e";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

      case 14:  //Stretch - Stretch E Band
        ep.headerText = constants.stretch;
        ep.tabButton_1.Text = "Cord UIs";
        ep.tabButton_2.Text = "Stretch E Band";        
        ep.movie = null;    

        //For Media Player
        ep.movie = new Movie(obj, "Stretch2V.mp4");  

        //Set hot spots for the movie    //TODO ******** Set Hot Spots for System, Manipulation, Implementation *********
        float [] A14 = {0,2};
        float [] B14 = {6,12,
                        14,17,
                        19,21,
                        22,29};
        float [] C14 = {3,6};
        
        formHotSpotObject(ep.videoHotSpots, 1, A14);
        formHotSpotObject(ep.videoHotSpots, 2, B14);
        formHotSpotObject(ep.videoHotSpots, 3, C14);

        //For Photo Viewer - load photos  *** Can use for-loop
        ep.photoViewerImgArray.add(requestImage("Stretch2Ia.JPG"));
        ep.photoViewerDetailArray.add("Figure 1: Switching between tracks in a clutter-free manner.");
        ep.photoViewerImgArray.add(requestImage("Stretch2Ib.JPG"));
        ep.photoViewerDetailArray.add("Figure 2: (1–2) Users can switch between the contacts without cluttering the screen. Also (3–4) pan & zoom into maps efficiently by using a bi-manual approach.");
        ep.photoViewerImgArray.add(requestImage("Stretch2Ic.JPG"));
        ep.photoViewerDetailArray.add("Figure 3: Adjusting the car seat position by stretching the StretchEBand sensor.");
        ep.photoViewerImgArray.add(requestImage("Stretch2Id.JPG"));
        ep.photoViewerDetailArray.add("Figure 4: (a) Continuous stretch input for zooming / scrolling, (b) continuous wrist input for interacting in motion, (c) fold & stretch and (d) lift & press for directional input, and (e) touch & stretch for hybrid interaction.");
        ep.photoViewerImgArray.add(requestImage("Stretch2Ie.JPG"));
        ep.photoViewerDetailArray.add("Figure 5: StretchEBand, a textile-based stretch sensor for interacting with a variety of devices. (a) Adjusting car seats, (b) Changing music track during a run, (c) playing with toys, (d) controlling the TV with pillows, (e) and interacting with a smart phone cover.");
        ep.photoViewerImgArray.add(requestImage("Stretch2If.JPG"));
        ep.photoViewerDetailArray.add("Figure 6: SketchEBand enhancing everyday objects, e.g. pillows (1) and toys (2).");

        //Load image file for PDF Viewer
        ep.pdfViewerFileName = "papers\\Stretch\\Stretch2.jpg";  //this will be a single image file
        
        //Tech Button Link
        ep.techButtonLink = "https://www.hackster.io/Juliette/measuring-stretch-forces-with-a-conductive-rubber-cord-d1528e";

        loadedData.put(param, ep);    // Put data in the loadedData object for quick access once loaded.
        break;

        //TODO write cases for 3rd page and so on

      default:
        //headerText = "ERROR PAGE";
        break;
      }
    }

    //Check if data has been loaded already
    if (! loadedData.isEmpty() && loadedData.containsKey(param)) {
      //println("Data Already Loaded for Param "+ param + " " + loadedData.get(param).headerText);
      exPage.headerText = loadedData.get(param).headerText;
      exPage.tabButton_1.Text = loadedData.get(param).tabButton_1.Text;
      exPage.tabButton_2.Text = loadedData.get(param).tabButton_2.Text;
      exPage.movie = loadedData.get(param).movie;
      exPage.videoHotSpots = loadedData.get(param).videoHotSpots;

      //println("PhotoArray size = "+ loadedData.get(param).photoViewerImgArray.size() + "\n");
      exPage.photoViewerImgArray = loadedData.get(param).photoViewerImgArray;
      exPage.photoViewerDetailArray = loadedData.get(param).photoViewerDetailArray;
      exPage.pdfViewerFileName = loadedData.get(param).pdfViewerFileName;
      exPage.techButtonLink = loadedData.get(param).techButtonLink;
    }
  }

  private void formHotSpotObject(HashMap<Integer, ArrayList<Float[]>> videoHotSpots, int tag, float[] hsArr) {
    if (hsArr != null) {
      ArrayList<Float[]> timeIntervalList = new ArrayList();
      for (int i=0; i<hsArr.length; i+=2) {
        Float [] timeInterval = new Float[2];
        timeInterval[0] = hsArr[i];
        timeInterval[1] = hsArr[i+1];
        timeIntervalList.add(timeInterval);
      }
      videoHotSpots.put(tag, timeIntervalList);
    }
  }
}
