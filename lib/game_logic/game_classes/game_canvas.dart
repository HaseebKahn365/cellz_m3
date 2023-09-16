import '../lists_of_objects.dart';
import 'Points.dart';

class GameCanvas {
  int numOfXPoints = 0; // number of points on the x axis.
  int numOfYPoints = 0; // number of points on the y axis.
  static bool isGameOver = false; // toCheck if the game is over or not
  bool isMyTurn = true; //to control the touch events
  static int movesLeft =
      0; // to check how many moves are left. Todo: this must be assigned the value of caculateMovesLeft() function. soon after declaring the object of this class.
  int level;
  // to check the level of the game. Todo: this must be assigned the value of caculateMovesLeft() function. soon after declaring the object of this class.
  void calculateMovesLeft() {
    GameCanvas.movesLeft = (this.numOfXPoints - 1) * this.numOfYPoints + (this.numOfYPoints - 1) * this.numOfXPoints;
  }

  static void createDots(int xCount, int yCount) {
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        allPoints.add(Points(xCord: j, yCord: i)); //i am using the reverse because the y axis is inverted in the game.
      }
    }
  }

  //creating a complex switch case for implementing levels. ie the first level must have only 2Xpoints and 2Ypoints.
  //the second level must have 4Xpoints and 5Ypoints. and so on.
  //this function will be called in the main.dart file.

  void levelSwitchCase(int level) {
    switch (level) {
      case 1:
        numOfXPoints = 2;
        numOfYPoints = 2;
        //call the create dots function here.
        createDots(numOfXPoints, numOfYPoints);
        //we have to initialize the moves left here too.
        calculateMovesLeft();
        break;
      case 2:
        numOfXPoints = 4;
        numOfYPoints = 5;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();
        break;
      case 3:
        numOfXPoints = 5;
        numOfYPoints = 6;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();
        break;
      case 4:
        numOfXPoints = 6;
        numOfYPoints = 7;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();

        break;
      case 5:
        numOfXPoints = 7;
        numOfYPoints = 8;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();

        break;
      case 6:
        numOfXPoints = 8;
        numOfYPoints = 9;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();

        break;
      case 7:
        numOfXPoints = 9;
        numOfYPoints = 10;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();

        break;
      case 8:
        numOfXPoints = 10;
        numOfYPoints = 11;
        break;
      case 9:
        numOfXPoints = 11;
        numOfYPoints = 12;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();

        break;
      case 10:
        numOfXPoints = 12;
        numOfYPoints = 13;
        createDots(numOfYPoints, numOfXPoints);
        calculateMovesLeft();

        break;
      //thats it 10 levels are enough for now.
      default:
        numOfXPoints = 2;
        numOfYPoints = 2;
    }
  }

  GameCanvas({
    required this.level,
  });

  @override
  String toString() {
    return 'GameCanvas(numOfXPoints: $numOfXPoints, numOfYPoints: $numOfYPoints, isGameOver: $isGameOver, movesLeft: $movesLeft, level: $level)';
  }
}
