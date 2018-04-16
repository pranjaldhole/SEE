import lejos.robotics.navigation.DifferentialPilot;
import lejos.nxt.Motor;
import lejos.nxt.Button;

public class SEE {
  final static double SPEED = 180.0;
  final static int INITIAL_SLEEP_TIME = 500;
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

        int button_code = Button.waitForAnyPress();
        try {
            Thread.sleep(INITIAL_SLEEP_TIME);
        }
        catch(InterruptedException e) { }

        if (button_code == ENTER_BUTTON_CODE) {
            pilot.forward();
        }
        else if (button_code == LEFT_BUTTON_CODE) {
            pilot.steer(-TURN_RATE);
        }
        else if (button_code == RIGHT_BUTTON_CODE) {
            pilot.steer(TURN_RATE);
        }

        try {
            Thread.sleep(SLEEP_TIME);
        }
        catch(InterruptedException e) { }

        pilot.stop();
  }
}