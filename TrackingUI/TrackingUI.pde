///////////////////////////////////////Import Arduino Libraries//////////////////
import cc.arduino.*;
import org.firmata.*;////Firmata is crucial for com between arduino and processing
//////////////////////////////////////Import Math Libraries/////////////////////
/////////////////////////You don't need all of them////////////////////////////
import org.apache.commons.math3.ml.neuralnet.*;
import org.apache.commons.math3.ml.neuralnet.twod.*;
import org.apache.commons.math3.ml.neuralnet.twod.util.*;
import org.apache.commons.math3.ml.neuralnet.oned.*;
import org.apache.commons.math3.ml.neuralnet.sofm.*;
import org.apache.commons.math3.ml.neuralnet.sofm.util.*;
import org.apache.commons.math3.ml.clustering.*;
import org.apache.commons.math3.ml.clustering.evaluation.*;
import org.apache.commons.math3.ml.distance.*;
import org.apache.commons.math3.analysis.*;
import org.apache.commons.math3.analysis.differentiation.*;
import org.apache.commons.math3.analysis.integration.*;
import org.apache.commons.math3.analysis.integration.gauss.*;
import org.apache.commons.math3.analysis.function.*;
import org.apache.commons.math3.analysis.polynomials.*;
import org.apache.commons.math3.analysis.solvers.*;
import org.apache.commons.math3.analysis.interpolation.*;
import org.apache.commons.math3.stat.interval.*;
import org.apache.commons.math3.stat.ranking.*;
import org.apache.commons.math3.stat.clustering.*;
import org.apache.commons.math3.stat.*;
import org.apache.commons.math3.stat.inference.*;
import org.apache.commons.math3.stat.correlation.*;
import org.apache.commons.math3.stat.descriptive.*;
import org.apache.commons.math3.stat.descriptive.rank.*;
import org.apache.commons.math3.stat.descriptive.summary.*;
import org.apache.commons.math3.stat.descriptive.moment.*;
import org.apache.commons.math3.stat.regression.*;
import org.apache.commons.math3.linear.*;
import org.apache.commons.math3.*;
import org.apache.commons.math3.distribution.*;
import org.apache.commons.math3.distribution.fitting.*;
import org.apache.commons.math3.complex.*;
import org.apache.commons.math3.ode.*;
import org.apache.commons.math3.ode.nonstiff.*;
import org.apache.commons.math3.ode.events.*;
import org.apache.commons.math3.ode.sampling.*;
import org.apache.commons.math3.random.*;
import org.apache.commons.math3.primes.*;
import org.apache.commons.math3.optim.*;
import org.apache.commons.math3.optim.linear.*;
import org.apache.commons.math3.optim.nonlinear.vector.*;
import org.apache.commons.math3.optim.nonlinear.vector.jacobian.*;
import org.apache.commons.math3.optim.nonlinear.scalar.*;
import org.apache.commons.math3.optim.nonlinear.scalar.gradient.*;
import org.apache.commons.math3.optim.nonlinear.scalar.noderiv.*;
import org.apache.commons.math3.optim.univariate.*;
import org.apache.commons.math3.exception.*;
import org.apache.commons.math3.exception.util.*;
import org.apache.commons.math3.fitting.leastsquares.*;
import org.apache.commons.math3.fitting.*;
import org.apache.commons.math3.dfp.*;
import org.apache.commons.math3.fraction.*;
import org.apache.commons.math3.special.*;
import org.apache.commons.math3.geometry.*;
import org.apache.commons.math3.geometry.hull.*;
import org.apache.commons.math3.geometry.enclosing.*;
import org.apache.commons.math3.geometry.spherical.twod.*;
import org.apache.commons.math3.geometry.spherical.oned.*;
import org.apache.commons.math3.geometry.euclidean.threed.*;
import org.apache.commons.math3.geometry.euclidean.twod.*;
import org.apache.commons.math3.geometry.euclidean.twod.hull.*;
import org.apache.commons.math3.geometry.euclidean.oned.*;
import org.apache.commons.math3.geometry.partitioning.*;
import org.apache.commons.math3.geometry.partitioning.utilities.*;
import org.apache.commons.math3.optimization.*;
import org.apache.commons.math3.optimization.linear.*;
import org.apache.commons.math3.optimization.direct.*;
import org.apache.commons.math3.optimization.fitting.*;
import org.apache.commons.math3.optimization.univariate.*;
import org.apache.commons.math3.optimization.general.*;
import org.apache.commons.math3.util.*;
import org.apache.commons.math3.genetics.*;
import org.apache.commons.math3.transform.*;
import org.apache.commons.math3.filter.*;
///////////////////////////////////IMPORT OpenCV Core LIBRARIES/////////////////////////////
//////////////////////////////////and some graphics and UI req./////////////////////////////
import gab.opencv.*;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.Size;
import org.opencv.core.Point;
import org.opencv.core.Scalar;
import org.opencv.core.CvType;
import org.opencv.imgproc.Imgproc;
import processing.video.*;
import java.awt.Rectangle;
import processing.serial.*;  
import controlP5.*;
////////////////////////////////DECLARE VARIABLES//////////////////
//Arduino arduinoPort;//uncomment if arduino is connected
Capture video;
OpenCV opencv;
PImage src, colorFilteredImage, sat, Va;
Range range1, range2, range3;
ControlP5 scroll1, scroll2, scroll3, cp5;
int max1, min1, max2, min2, max3, min3;
ArrayList<Contour> contours;
int sliderValue=0;
String val;
boolean firstContact = false;
int n=1; int i=1;
///////////////////////////////////////ARDUINO VARIABLES//////////////////////////////////////////
///If using arduino, your arduino sketch variables goes here, it will be uploaded to arduino board via firmata
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////SETUP//////////////////
void setup() {
video = new Capture(this, 640, 480);//Access your webcam by default
//video = new Capture(this, 640, 480, "name=Logitech HD Webcam C270,size=640x480,fps=30",30);//Example: if you want to access an external camera
////////////////////////////Iniate Serial Com with arduino and define pins as below/////////////////////
//arduinoPort = new Arduino(this, "COM3", 57600);
//arduinoPort.pinMode(11, Arduino.OUTPUT);    // Pin 11 conected a IN4
  video.start();
  opencv = new OpenCV(this, 640, 480);
  surface.setSize(2*opencv.width, 480+80);
  background(#005250);
  contours = new ArrayList<Contour>();
  opencv.useColor(HSB);
/////////////////UI Setup/////////////////////////////
scroll1= new ControlP5(this);
scroll2= new ControlP5(this);
scroll3= new ControlP5(this);
cp5=new ControlP5(this);
cp5.addSlider("slidervalue").setPosition(640,485).setRange(0,255);
range1= scroll1.addRange("Min H, Range H, Max H")
.setBroadcast(false)   .setPosition(640/4,485)
.setSize(320,20)       .setHandleSize(10)
.setRange(0,255)       .setRangeValues(50,100)
.setBroadcast(true);
range2= scroll1.addRange("Min S, Range S, Max S")
.setBroadcast(false)   .setPosition(640/4,510)
.setSize(320,20)       .setHandleSize(10)
.setRange(0,255)       .setRangeValues(50,100)
.setBroadcast(true);
range3= scroll1.addRange("Min V, Range V, Max V")
.setBroadcast(false)   .setPosition(640/4,535)
.setSize(320,20)       .setHandleSize(10)
.setRange(0,255)       .setRangeValues(50,100)
.setBroadcast(true);
}
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////DRAW MAIN FUNCTION///////////////////////////
///////////////////similar to void loop() in arduino/////////////////////////
void draw() {
  // Read last captured frame
  if (video.available()) {
    video.read();
  }
  // <2> Load the new frame of our movie in to OpenCV
  opencv.loadImage(video);

  // Tell OpenCV to use color information
  opencv.useColor();
  src = opencv.getSnapshot();
  // <3> Tell OpenCV to work in HSV color space.
  opencv.useColor(HSB);

  // <4> Copy the Hue channel of our image into 
  //     the gray channel, which we process.
  opencv.setGray(opencv.getH().clone());

  // <5> Filter the image based on the HSV range set by our control event function 
  opencv.inRange(min1,max1);
  opencv.blur(12);
  opencv.threshold(50);
  opencv.dilate();
  opencv.erode();
  colorFilteredImage = opencv.getSnapshot();
  opencv.setGray(opencv.getS().clone());
  opencv.inRange(min2,max2);
  opencv.blur(12);
  opencv.threshold(50);
  opencv.dilate();
  opencv.erode();
  opencv.diff(colorFilteredImage);
  opencv.threshold(sliderValue);
  opencv.invert();
  sat = opencv.getSnapshot();
  opencv.setGray(opencv.getV().clone());
  opencv.inRange(min3,max3);
  opencv.blur(12);
  opencv.threshold(50);
  opencv.dilate();
  opencv.erode();
  opencv.diff(sat);
  opencv.threshold(sliderValue);
  opencv.invert();
  Va = opencv.getSnapshot();
  // <7> Find contours in our range image.
  //     Passing 'true' sorts them by descending area.
  contours = opencv.findContours(true, true);
  // <8> Display background images
  image(src, 0, 0);
  image(Va, src.width, 0);
  // <9> Check to make sure we've found any contours
  if (contours.size() > 0) {
    // <9> Get the first contour, which will be the largest one
    Contour biggestContour = contours.get(0);

    // <10> Find the bounding box of the largest contour,
    //      and hence our object.
    Rectangle r = biggestContour.getBoundingBox();

    // <11> Draw the bounding box of our object
    noFill(); 
    strokeWeight(2); 
    stroke(255, 0, 0);
    rect(r.x, r.y, r.width, r.height);

    // <12> Draw a dot in the middle of the bounding box, on the object.
    noStroke(); 
    fill(255, 0, 0);
    ellipse(r.x + r.width/2, r.y + r.height/2, 30, 30);
    //output X,Y coordinates in pixels every 10 frames
    if(n==10){
    print("X=");
    println(r.x);
    print("Y=");
    println(r.y);
    n=0;
    }
    n=n+1;
    //////////////MOTOR CONTROL//////////////////////////
    //Here openCV provides us with (X,Y) coordinates for the centerof tracked object in pixels
    //Arduino Code for controlling motors based on the data you get from opencv 
  }
} 
//////////////A very Simple UI////////////////////
////////////////SLIDER BARS//////////////////////
void controlEvent(ControlEvent theControlEvent) {
 if (theControlEvent.isFrom("Min H, Range H, Max H")) {
 min1= int(theControlEvent.getController().getArrayValue(0));
 max1= int(theControlEvent.getController().getArrayValue(1));
 }
 if (theControlEvent.isFrom("Min S, Range S, Max S")) {
 min2= int(theControlEvent.getController().getArrayValue(0));
 max2= int(theControlEvent.getController().getArrayValue(1));
 }
 if (theControlEvent.isFrom("Min V, Range V, Max V")) {
 min3= int(theControlEvent.getController().getArrayValue(0));
 max3= int(theControlEvent.getController().getArrayValue(1));
 }
}