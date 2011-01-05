

#include <Servo.h> 

/*

  this version drives the robot, but if it gets too close, 
  it makes random turn

*/

#define irPin 4

Servo servo1;
Servo servo2;

void setup() 
{ 
  
  // connect the servos
  servo1.attach(9);
  servo2.attach(10);
  
  // set to zero speed
  drive(0.0,0.0);
  
  // give us a chance to put the bot down before it takes of
  delay(4000);
  
} 

void loop() {

  // read the IR sensor
  if (analogRead(irPin) < 350) {

    // nothing close, so drive forward. fwd/rev depends on
    // which side the motors are on the robot, i.e. it's all relative
    drive(-1.0, -1.0);

  
  } else {

    // make a random turn by drive the motor in opposite directions 
    // for a random time (300msec to 1.5 sec) and stop.  next time around 
    // the loop determines what happens next - more turning or fwd
    drive(1.0, -1.0);
    delay(random(300, 1500));
    drive(0., 0.0);
    
  }
  
  delay(75);
  
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

