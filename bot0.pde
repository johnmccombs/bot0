/*

  This is a basic robot self-navigating robot.   It's driven by two 
  continuous rotation servos and uses a Sharp GP2Y0A02YK0F infra-red 
  distance measuring sensor to detect obstacles.
  
  If the IR sensor detects something within range, it make a turn
  by driving the motors in opposite directions.

--
Copyright (C) 2010 by Integrated Mapping Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

#include <Servo.h> 

// connect the IR sensor to analogue pin 4
#define irPin 4

// the two servo objects
Servo servo1;
Servo servo2;

//-----------------------------------------------------
void setup() 
{ 
  
  // connect to the servos.
  servo1.attach(9);
  servo2.attach(10);
  
  // set to zero speed
  drive(0.0,0.0);
  
  // give us a chance to put the bot down before it takes off - 4 second delay
  delay(4000);
  
} 


//-----------------------------------------------------
void loop() {

  // read the IR sensor.  a raw reading of 350 is about 350mm away
  if (analogRead(irPin) < 350) {

    // nothing close, so drive forward. fwd/rev depends on
    // which side the motors are on the robot. if it goes the wrong
    // way, swap the motors or modify the drive() function to invert the 
    // sign of the speed values. 0 is stopped.  -1/1 are full speed
    drive(-1.0, -1.0);

  
  } else {

    // make a random turn by drive the motor in opposite directions 
    // for a random time (300msec to 1.5 sec) and stop.  next time around 
    // the loop determines what happens next - more turning or fwd
    drive(1.0, -1.0);
    delay(random(300, 1500));
    drive(0.0, 0.0);
    
  }
  
  delay(50);
  
} 



//------------------------------------------------------------
void drive(float left_speed, float right_speed){
  
/*
  This routine drives the motors.  The arguments left_speed and 
  right_speed specify the speed of each motor. 0=stop, 1 = full speed
  
  The servo library runs from 0=full fwd, to 180=full rev
  this routine maps that 1 to -1.   This routine also assumes that
  the motors are installed on the robot chassis as mirror images, so
  they need to be drive in opposite dorections.
*/

  left_speed = left_speed*90 + 90;
  right_speed = 180-(right_speed*90 + 90);
 
  servo1.write(left_speed);
  servo2.write(right_speed);  

}

