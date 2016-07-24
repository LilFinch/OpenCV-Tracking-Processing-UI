## OpenCV-Tracking-Processing-UI

**Easy to use with Arduino to control pan-tilt camera mounts, a robotic arm, etc..**

[OpenCV] (http://opencv.org/) provides a great open source computer vision library. It has C++, C, Python and Java interfaces and supports Windows, Linux, Mac OS, iOS and Android. However, installing openCV can be somehow frustrating especially for beginners as well as making use of the valuable data you get to control any device, robot, or a microcontroller of your choice.

I personally had some hard time trying to set up serial communication between openCV and Arduino, which is the motivation behind this project.

This project is based on the OpenCV for processing library created by [atduskgreg](https://github.com/atduskgreg/opencv-processing).

Contribution are welcome.
### Installation
1) Install [Processing](https://processing.org/download/) and [Arduino](https://www.arduino.cc/en/Main/Software) IDEs if you don't have them already.

2) In Processing, access the contribution manager via Sketch-->Import Library-->Add library.

3) Install Arduino(Firmata), Video, ControlP5, OpenCV for Processing. You will also need [commonmath](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/TrackingUI/code/commons-math3-3.6.1.jar) to access complex math operations, it is not necessary for this example (delete lines 6 to 80).  

4) Open & Run [TrackingUI.pde](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/TrackingUI/TrackingUI.pde)

5) Use the slider bars to set the HSV range you want to filter, you should see the original live video feedback on the left and the filtered HSV image on the right. A conversion tool from Hex and RGB color codes to HSV can be found [here](http://www.rapidtables.com/convert/color/rgb-to-hsv.htm)   

6) Explore the capabalities of OpenCV by trying the examples that comes with the library. In processing, File-->examples-->openCV for processing. [Face Detection](https://github.com/atduskgreg/opencv-processing/blob/master/examples/FaceDetection/FaceDetection.pde) and [Background Subtraction](https://github.com/atduskgreg/opencv-processing/blob/master/examples/BackgroundSubtraction/BackgroundSubtraction.pde) are highly recommended.

**PS: In the examples provided by the library, size() function is not supported by latest versions of processing, replace it with surface.setSize()**

### Demo
Run [TrackingUI.pde](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/TrackingUI/TrackingUI.pde) and set the slider bars to match the HSV values of the yellow color (23,158,191) to (68, 237, 255), then start moving a yellow object infront of your camera.
![Alt Text](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/raw/master/TrackingUI/screenshots/Test_Yellow.PNG)

###Using with a microcontroller

So far my main focus was arduino boards, the following was tested with the UNO and MEGA and should work with all arduino boards, let me know if it doesn't. I will try to include the RasPI as soon as possible. 

####To connect to Arduino:

1) Plug in your board, open the firmata arduino sketch from the examples in the arduino IDE or download [Ard_Firmata.ino](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/Ard_Firmata/Ard_Firmata.ino)

2) Upload the firmata sketch to your board, notice that the baud rate for serial communication in line 766 should match that in your processing sketch.

3) Based on your setup and what you are trying to achieve from the processed image (moving servos to track the object of interest, locking the cam to your face, etc..), build your arduino circuit and simply write your arduino sketch inside [TrackingUI.pde](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/TrackingUI/TrackingUI.pde), I have commented where should arduino variables, void setup() and void loop() go, so it should be a straight forward process. Make use of the object position variables (in this case r.x and r.y) in your arduino code.

4) Simply run your processing sketch after uploading [Ard_Firmata.ino](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/Ard_Firmata/Ard_Firmata.ino) to your board and watch your gadget tracking the object of your interest.

###Copyright & License

Code released under the [MIT license](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/blob/master/License.txt)
