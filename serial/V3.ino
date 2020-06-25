//******************************************************************************************************************************
//Bend A0,0
//Fold A1,1
//Pull A2,2
//Squeeze A3,3
//Stretch A4,4

//This should be the same value of the used resistor
#define RESISTOR 10000

//Bend
const int FLEX_PIN = A0;
const float VCC = 4.98; // Measured voltage of Ardunio 5V line
const float R_DIV = 100000.0; // Measured resistance of 10 K re
const float STRAIGHT_RESISTANCE = 37300.0; // resistance when straight
const float BEND_RESISTANCE = 90000.0; // resistance at 90 deg

//Fold
const int FOLD_PIN = A1; // Pin connected to voltage divider output

//Pull
const int PULL_PIN = A2;
int pullVal = 0;
int trackState = 0;
float pullValA = 0;
float pullValB = 0;

//Squeeze
const int FSR_PIN = A3; // Pin connected to Squeeze/FSR/resistor divider
const float R_DIVsq = 3230.0; // Measured resistance of 3.3k resistor

//Stretch
const int RUBBERCORDPIN = A4;
int raw = 0;           // Raw input value
int vin = 5;           // Store input voltage, this should be 5
float vout = 0;        // Store output voltage
float refresistor1 = 10;  // Variable to store the R1 value
float refresistor2 = 0;  // represents unknown resistor. Code will determine what value it is after the voltage that falls across it has been measured
float buffer = 0;    // buffer variable for calculation

void setup()
{
  Serial.begin(9600);
  pinMode(FLEX_PIN, INPUT);
  pinMode(FSR_PIN, INPUT);
  pinMode(FOLD_PIN, INPUT);
  pinMode(RUBBERCORDPIN, INPUT);
  pinMode(PULL_PIN, INPUT);
}

void loop()
{
  //Bend
  int flexADC = analogRead(FLEX_PIN);
  float flexV = flexADC * VCC / 1023.0;
  float flexR = R_DIV * (VCC / flexV - 1.0);
  float angle = map(flexR, STRAIGHT_RESISTANCE, BEND_RESISTANCE,
                    0, 90.0);
  if (angle > 430) {
  Serial.println(0);
  }

  //Fold
  int foldADC = analogRead(FOLD_PIN);
      if (foldADC >1000) {
        Serial.println(1);
      }

  //Pull
  pullVal = analogRead(PULL_PIN); // read the value from the sensor
  if (trackState == 0 || trackState == 2) {
    pullValA = pullVal;
    trackState = 1;
  }
  if (pullVal > pullValA) {
    if (trackState == 1 && pullVal - pullValA > 100) {
      trackState = 2;
    }
  }
  if (pullVal < pullValA) {
    if (trackState == 1 && pullValA - pullVal > 100) {
      trackState = 2;
    }
  }

  if (trackState == 2) {
    Serial.println(2);
  }

  //Squeeze
  int fsrADC = analogRead(FSR_PIN);
  float fsrV = fsrADC * VCC / 1023.0;
  float fsrR = R_DIVsq * (VCC / fsrV - 1.0);
  float force;
  float fsrG = 1.0 / fsrR; // Calculate conductance
  if (fsrR <= 600)
    force = (fsrG - 0.00075) / 0.00000032639;
  else
    force =  fsrG / 0.000000642857;
  if (force > 55) {
    Serial.println(3);
  }
  
  //Stretch
  int value;
  value = analogRead(RUBBERCORDPIN); //Read value
  if (value > 90) {
    Serial.println(4);
  }

    if (angle <= 430 && foldADC<=1000 && trackState!=2 && force <= 55 && value <= 90) {
      Serial.println(9);
    }
    delay(300);
}
