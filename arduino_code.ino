#include <Servo.h>

#define SERVO_BOTTOM_PORT 9
#define SERVO_TOP_PORT 10

Servo servo_bottom; //bottom
Servo servo_top; //top
int angle = 0;
double max = 270.0;
double one = (max/4);
double two = (max*2)/4;
double three = (max*3)/4;
double four = max;
double sec_one = one/2;
double sec_two = (one + two)/2;
double sec_three = (two + three)/2;
double sec_four = (three + four)/2;
double home_bottom = 0;
double home_top = max/2;

void setup() {
  Serial.begin(9600);
  servo_bottom.attach(SERVO_BOTTOM_PORT);
  servo_top.attach(SERVO_TOP_PORT);
  
  for (angle = home_bottom; angle <= 0; angle += 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }            
  
  for (angle = home_top; angle <= two; angle += 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(3000);
  
}
void angle_one(void){
  
  for (angle = home_bottom; angle <= sec_one; angle += 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(15);
  for (angle = home_top; angle >= sec_one; angle -= 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(1000);
  angle_home_1(sec_one);
}
void angle_two(void){
  
  for (angle = home_bottom; angle <= sec_two; angle += 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(15);
  for (angle = home_top; angle >= sec_two; angle -= 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(1000);
  angle_home_1(sec_two);
}
void angle_three(void){
  
  for (angle = home_top; angle <= sec_three; angle += 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(15);
  for (angle = home_bottom; angle <= sec_three; angle += 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(1000);
  angle_home_2(sec_three);
}
void angle_four(void){
  
for (angle = home_top; angle <= sec_four; angle += 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(15);
  for (angle = home_bottom; angle <= sec_four; angle += 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  delay(1000);
  angle_home_2(sec_four);
}
void angle_home_2(int start){
  
  for (angle = start; angle > home_bottom; angle -= 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  for (angle = start; angle > home_top; angle -= 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
}

void angle_home_1(int start){
  
  for (angle = start; angle > home_bottom; angle -= 1) { 
    servo_bottom.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  for (angle = start; angle < home_top; angle += 1) { 
    servo_top.write(map(angle, 0, 270, 0, 180));             
    delay(15);                       
  }
  
}

void loop() {
 // if (Serial.available()) {  // Check if there's data from Python
  //  String input = Serial.readStringUntil('\n');  // Read the input string
  //  input.trim();
   
  //  int in = input.substring(0).toInt();
  //  if (in == 1){
	//	angle_one();
   //   	Serial.println("hole moved to " + String(sec_one));
  //  }else if (in == 2){
	//	angle_two();
   //   	Serial.println("hole moved to " + String(sec_two));
   // }else if (in == 3){
	//	angle_three();
   //   Serial.println("hole moved to " + String(sec_three));
   // }else if (in == 4){
	//	angle_four();
   //   	Serial.println("hole moved to " + String(sec_four));
   // }
  
 // }
  angle_one();
  delay(500);
  angle_two();
  delay(500);
  angle_three();
  delay(500);
  angle_four();
  delay(500);
  // servo_top.write(map(270, 0, 270, 0, 180));
  // delay(15);
  // servo_bottom.write(map(272/2, 0, 270, 0, 180));
  // delay(2000);
  // servo_top.write(map(0, 0, 270, 0, 180));
  // delay(15);
  // servo_bottom.write(map(270, 0, 270, 0, 180));
  // delay(2000);

  //servo_top.write(map(270, 0, 270, 0, 180));
  //delay(15);
  //servo_bottom.write(map(270, 0, 270, 0, 180));
  //delay(10000);
}
