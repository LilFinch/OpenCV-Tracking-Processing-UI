## OpenCV-Tracking-Processing-UI
**Easy to use with Arduino to control pan-tilt camera mounts, a robotic arm, etc..**
[OpenCV] (http://opencv.org/) provides a great open source computer vision library. It has C++, C, Python and Java interfaces and supports Windows, Linux, Mac OS, iOS and Android. However, installing openCV can be somehow frustrating especially for beginners as well as making use of the valuable data you get to control any device, robot, or a microcontroller of your choice.
I personally had some hard time trying to set up serial communication between openCV and Arduino, which is the motivation behind this project.
This project is based on the OpenCV for processing library created by [atduskgreg](https://github.com/atduskgreg/opencv-processing).
Contribution are welcome.
### Installing
1) Install [Processing](https://processing.org/download/) and [Arduino](https://www.arduino.cc/en/Main/Software) IDEs if you don't have them already.
2) In Processing, access the contribution manager via Sketch-->Import Library-->Add library.
3) Install Arduino(Firmata), commonmath, ControlP5, OpenCV for Processing.
4) Open & Run TrackingUI.pde
### Demo
Set the slider bars to match the HSV values of the yellow color, then start moving a yellow object infront of your camera.
![Alt Text](https://github.com/LilFinch/OpenCV-Tracking-Processing-UI/raw/master/TrackingUI/screenshots/Test_Yellow.PNG)
