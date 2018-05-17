import lejos.robotics.navigation.DifferentialPilot;
import lejos.nxt.Motor;
import lejos.nxt.Button;

public class StraightLine {
  final static double SPEED = 180.0;
  final static int INITIAL_SLEEP_TIME = 0;
  final static int SLEEP_TIME = 2250;

  final static float DIAMETER = 56.0f;
  final static float TRACK_WIDTH = 186.0f;

  final static int ENTER_BUTTON_CODE = 1;
  final static int LEFT_BUTTON_CODE = 2;
  final static int RIGHT_BUTTON_CODE = 4;

  final static double TURN_RATE = 40.0;
  
  
  public static void main (String[] args) {
        DifferentialPilot pilot = new DifferentialPilot(DIAMETER, TRACK_WIDTH, Motor.A, Motor.B, false);
        pilot.setTravelSpeed(SPEED);
        Motor.C.setSpeed(720);
        Motor.C.forward();
        System.out.println("Press:");
        System.out.println("Middle for straight");
        System.out.println("Left for Left");
        System.out.println("Right for Right:");
        int button_code = Button.waitForAnyPress();
        try {
            Thread.sleep(INITIAL_SLEEP_TIME);
        }
        catch(InterruptedException e) { }
        
        if (button_code == ENTER_BUTTON_CODE) {
        	try {
                Thread.sleep(1000);
            }
            catch(InterruptedException e) { }
            pilot.forward();
        }
        else if (button_code == LEFT_BUTTON_CODE) {
        	try {
                Thread.sleep(1000);
            }
            catch(InterruptedException e) { }
            pilot.steer(-TURN_RATE);
        }
        else if (button_code == RIGHT_BUTTON_CODE) {
        	try {
                Thread.sleep(1000);
            }
            catch(InterruptedException e) { }
            pilot.steer(TURN_RATE);
        }

        try {
            Thread.sleep(SLEEP_TIME);
        }
        catch(InterruptedException e) { }
        pilot.stop();
        int button_code_new = Button.waitForAnyPress();
        while(true){
        	if (button_code_new == ENTER_BUTTON_CODE) {
                break;
            }
        }
  }
}