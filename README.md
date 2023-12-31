# cellz_m3

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Points
Members:
Int xCord;
Int yCord;
Bool isMarked; //used to mark the point as bold if already used
Bool isDisabled; //used to avoid selection if point is connected in all four directions
Bool isSelected; //use to mark the point even bolder. When drawing a line
Methods:
Points({required this. xCord, required this. yCord, this. isSelected = false, this. isDisabled = false, this. isSelected = false}); 
Overload the equality operator for Point:
bool operator ==(Point p2){
if(this.xCord == p2.xCord && this.yCord == p2.yCord){return true;} else {return false;}
}
bool checkDisability(Points p1){
    if(p1.isDisabled == true){
        return true;
    }
    //find number of instances of p1 in pointsUsed
    if(
        pointsUsed.where((element) => element.xCord == p1.xCord && element.yCord == p1.yCord).length > 3
    ){
        return true;
    }
    return false;
    
}


Lines
Members:
Points firstPoint;
Points secondPoint;
User owner;
LineDirection lineDirection;

Methods:
Void animate(Lines providedLine){
//animates the provided Line ie. Line drawn by ai function
} 
Void CheckSquare(Lines providedLine){
//this function will check the square based on the line provided as an argument
}
Overload the equality operator for Lines:
//a proper overload of the == operator was required which is now resolved in the latest version of this project.
bool operator ==(Line l2){
if(this.firstPoint == l2.firstPoint && this.secondPoint == l2.secondPoint){return true;} else {return false;}
}


Enum for directions of the lines drawn
Enum LineDirection = {Horiz, Vert};

Square
Members:
Lines L1Horiz;
Lines L2Horiz;
Lines L1Vert;
Lines L2Vert;

Methods:
Void checkHorizSquare( Lines horizontalLine){
//This function will check if there is a square above or below the current horizontal line which is //provided as an argument.
}
Void checkVertSquare( Lines VerticalLine){
//This function will check if there is a square on the right or left of the current vertical line which is //provided as an argument.
}

GameCanvas
Members:
Int numOfXPoints; // number of points on the x axis.
Int numOfYPoints;// number of points on the y axis.
Static Bool isGameOver; // toCheck if the game is over or not
Static Int movesLeft;

Methods:
Void calculateMovesLeft(int i /*numOfXPoints*/, int j /*numOfYPoints*/ ){
GameCanvas.movesLeft = (i-1)j + (j-1)i;
Void checkVertSquare( Lines VerticalLine){
//This function will check if there is a square on the right or left of the current vertical line which is //provided as an argument.
}


GamePlayers
Members:
Bool isPlayer;
Int score;
Int numOfLives;// 
List<Lines> linesDrawn = [];
List<Squares> squaresOwned = [];
Methods:
Void incrementScore(){
//increments the score as user completes a square/squares
This.score++;
}
Void loseLife(){
//this.life--;
}
Void addSquares(Squares s1){
squaresOwned.add(s1);
}

Development Phase 1 Control Flow:
•	GameStartup:
On the start of the game, we should first create the Points Objects. This task will be carried out by a function called create points which is explained below:
List<Points> allPoints= []; 
List<Points> usedPoints =[]; empty at first

void createPoints(int rows /*numOfXPoints*/, int colums/*numOfYPoints*/){
    for(var i=0; i<rows; i++){
        //creates xCord attributes of points objects
        for(var j=0; j<colums; j++){
            //creates yCord attributes of points objects
            allPoints.add(Point(xCord: i, yCord: j));
        }
    }
}

//After the creation of the points we should plot the Points on the screen from the allPoints[] list based on their respective xCord and yCord Values;
•	Logic for drawing lines:
We should use a gesture detector or any other widget so that when the user pans down on the screen, we will first check if the point is disabled or not. If the Point is disabled then we should not be able to draw a line from this current point. We will check whether the point is diabled or not using the function that we have defined in the Points class. 
bool checkDisability(Points p1){
    if(p1.isDisabled == true){
        return true;
    }
    //find number of instances of p1 in pointsUsed
    if(
        pointsUsed.where((element) => element.xCord == p1.xCord && element.yCord == p1.yCord).length > 3
    ){
        return true;
    }
    return false;
    
}

In case if p1 is not a disabled point, and p1 is being connected with a valid nearby point then add both the points to the usedPoints list.
We should only be able to connect to a nearby point which is only in the nearby zone around the current p1. Ie check using the following function:
bool checkNearby(Points p1, Points p2){
    if(p1.xCord == p2.xCord && p1.yCord == p2.yCord){
        return false;
    }
    if(p1.xCord == p2.xCord && p1.yCord == p2.yCord+1){
        return true;
    }
    if(p1.xCord == p2.xCord && p1.yCord == p2.yCord-1){
        return true;
    }
    if(p1.xCord == p2.xCord+1 && p1.yCord == p2.yCord){
        return true;
    }
    if(p1.xCord == p2.xCord-1 && p1.yCord == p2.yCord){
        return true;
    }
    return false;
}


usedPoints.add(p1);
usedPoints.add(p2);

Determining the direction of the points connected and creating a line object based on the direction and then add it to the list of allLines:
List<Lines> allLines = [];
import '../game_classes.dart';
import '../lists_of_objects.dart';

//create an instance of humanPlayer:
final humanPlayer = GamePlayers(isPlayer: true, score: 0, numOfLives: 4, linesDrawn: [], squaresOwned: []);

//global list of pointsUsed

Lines createLine(Points p1, Points p2) {
  Lines newLine;
  if (p1.xCord == p2.xCord) {
    //check in allPoints where a point matches with p2 and mark that point as selected
    //TODO:set isSelected to false and isMarked to true for the point p1 and p2 if line is valid and not already drawn after the square is checked and formed
    allPoints.forEach((element) {
      if (element == p2) {
        element.isSelected = true;
      }
    });
    //set the newLine's member isNew to true
    newLine =
        Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Vert, isNew: true);
    //add the new line to the list of lines
    allLines.add(newLine);
    //also add the new line to the list of lines drawn by the current user
    humanPlayer.linesDrawn.add(newLine);

    //checking if square has formed:
    checkSquare(newLine);
  } else if (p1.yCord == p2.yCord) {
    //check in allPoints where a point matches with p2 and mark that point as selected
    allPoints.forEach((element) {
      if (element == p2) {
        element.isSelected = true;
      }
    });
    newLine =
        Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Horiz, isNew: true);
    //add the new line to the list of lines
    allLines.add(newLine);
    //also add the new line to the list of lines drawn by the current user
    humanPlayer.linesDrawn.add(newLine);

    //checking if square has formed:
    checkSquare(newLine);
  } else {
    throw Exception('Invalid Line');
  }
  return newLine;
}

Lines? newLine;

checkSquare(Lines newLine) {
  //TODO In the actual game make sure that the newLine doesn't exist in the allLines list before calling this function
  allLines.add(newLine);
  switch (newLine.lineDirection) {
    case LineDirection.Horiz:

      //checking for the square below the newLine becuase origin point in in the top left corner and y increases downwards
      Lines L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert); //first vertical line

      Lines L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      Lines L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord + 1),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat. A square below the newLine\n');
        //in allLines where the line is equal to newLines set its isNew to false
        allLines.forEach((element) {
          if (element == newLine) {
            element.isNew = false;
          }
        });

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {
          print('out of moves. Game Over');
        }
      }

      //checking for the square above the newLine becuase origin point in in the top left corner and y increases downwards
      // print(
      //     'checking for the square above the newLine becuase origin point in in the top left corner and y increases downwards\n');
      L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord - 1),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      // print('l1 containment check: ${allLines.contains(L1)} and l1: $L1');
      // print('l2 containment check: ${allLines.contains(L2)} and l2: $L2');
      // print('l3 containment check: ${allLines.contains(L3)} and l3: $L3');  these return true as these should.

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat. a square above the newLine\n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {}
      }

      break;

    case LineDirection.Vert:

      //checking for the square on the left side of the newLine in the same manner as above
      Lines L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord - 1, yCord: newLine.firstPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      Lines L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord - 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      Lines L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord - 1, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord - 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: L1, L2Horiz: L2, L1Vert: newLine, L2Vert: L3);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat. a square on the left side of the newLine\n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {}
      }

      //After checking for the square above, we are going to check for the square on the right side of 	the newLine in 	the same manner as above

      L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord + 1, yCord: newLine.firstPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord + 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord + 1, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord + 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: L1, L2Horiz: L2, L1Vert: newLine, L2Vert: L3);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat. a square on the right side of the newline\n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {}
      }

      break;
  }
}

bool offsetAnalyzer(Offset P1, Offset Q1, Points currentPoint) {
  //first we need to find the difference between the x-coordinate and y-coordinate of the two offsets
  //minimum offset coordinate difference is 120
  //Lets say we have two points P1(x1,y1) and Q1(x2,y2) as two offsets. Then find the difference between x1 and x2 and y1 and y2
  //making sure that the points of the newline are in the allPoints list Lets do this in the createLine function or even better in the offsetAnalyzer function

  final xDif = (Q1.dx - P1.dx);
  final yDif = (Q1.dy - P1.dy);
  //X-major (Horizontal) line
  if (xDif.abs() > yDif.abs() && xDif.abs() > 120) {
    //the Line could be in the right or left direction:
    //FOR RIGHT LINE:
    if (xDif > 120) {
      //creating two points for the new line:
      var point1 = Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord);
      var point2 = Points(xCord: currentPoint.xCord + 1, yCord: currentPoint.yCord);
      //if point1 and point2 are in the allPoints list then create a new line

      if (allPoints.contains(point1) && allPoints.contains(point2)) {
        newLine = createLine(
          point1,
          point2,
        );
        print('\nHorizontal Right created: $newLine');
        return true;
      } else if (!allPoints.contains(point1) || !allPoints.contains(point2)) {
        print(
            'point1: $point1 and point2: $point2 are not in the allPoints list and out of bounds. horizontal right line creation failed\n');
        return false;
      }
    }

    //FOR LEFT LINE:
    else if (xDif < -120) {
      //creating two points for the new line:
      var point1 = Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord);
      var point2 = Points(xCord: currentPoint.xCord - 1, yCord: currentPoint.yCord);
      if (allPoints.contains(point1) && allPoints.contains(point2)) {
        newLine = createLine(
          point1,
          point2,
        );
        print('\nHorizontal Left created: $newLine');
        return true;
      } else if (!allPoints.contains(point1) || !allPoints.contains(point2)) {
        print(
            'point1: $point1 and point2: $point2 are not in the allPoints list and out of bounds horizontal left line creation failed\n');
        return false;
      }
      // print('Horizontal Left created: $newLine');
      // //add the new line to the allLines list if it does not already exists there:
      // if (!allLines.contains(newLine)) {
      //   allLines.add(newLine);
      //   //checking if square has formed:
      //   checkSquare(newLine!);
      // }
      // //print the list of allLines:
      // print('allLines: $allLines'); we need to do all this in the createLine function
    }
  }
  //Y-major (Vertical) line
  else if (yDif.abs() > xDif.abs() && yDif.abs() > 120) {
    //the Line could be in the up or down direction:
    //FOR Down LINE:
    //we need to be careful here because when we drag from top to bottom the offset.dy increases which means we have to create a newLine under the following conditions:
    if (yDif > 120) {
      var point1 = Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord);
      var point2 = Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord + 1);

      if (allPoints.contains(point1) && allPoints.contains(point2)) {
        newLine = createLine(
          point1,
          point2,
        );
        print('\nVertical Down created: $newLine');
        return true;
      } else if (!allPoints.contains(point1) || !allPoints.contains(point2)) {
        print(
            'point1: $point1 and point2: $point2 are not in the allPoints list and out of bounds vertical down line creation failed\n');
        return false;
      }

      // print('Vertical Down created: $newLine');

      // //add the new line to the allLines list if it does not already exists there:
      // if (!allLines.contains(newLine)) {
      //   allLines.add(newLine);
      //   //checking if square has formed:
      //   checkSquare(newLine!);
      // }
      // //print the list of allLines:
      // print('allLines: $allLines');
    }
    //FOR UP LINE:
    else if (yDif < -120) {
      var point1 = Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord);
      var point2 = Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord - 1);
      newLine = createLine(
        point1,
        point2,
      );

      if (allPoints.contains(point1) && allPoints.contains(point2)) {
        newLine = createLine(
          point1,
          point2,
        );
        print('\nVertical Up created: $newLine');
        return true;
      } else if (!allPoints.contains(point1) || !allPoints.contains(point2)) {
        print(
            'point1: $point1 and point2: $point2 are not in the allPoints list and out of bounds vertical up line creation failed\n');
        return false;
      }
      //   print('Vertical Up created: $newLine');
      //   //add the new line to the allLines list if it does not already exists there:
      //   if (!allLines.contains(newLine)) {
      //     allLines.add(newLine);
      //     //checking if square has formed:
      //     checkSquare(newLine!);
      //   }
      //   //print the list of allLines:
      //   print('allLines: $allLines');
      // }
    } else {
      //make the selected p1 unselected
      //use the returned false to make the line unselected
      return false;
    }
  }
  return false;
}

//create a fake offset class that only has the essential components to test the above code:

class Offset {
  final double dx;
  final double dy;

  Offset({required this.dx, required this.dy});
}

Phases of development:
* Properly overload the == operators, hashcodes and also simplify overridden .toString().
* Test every == operator and method indivisually with proper paramters.
* Test scenario based tests for every method and global functions.
* Integrate a full game loop from start to finish for console based Cellz game.
* Integrate a full game loop from start to finish for GUI based Cellz game.


Here is a complete description of the global functions and classes that we have created so far:
Global functions:


bool offsetAnalyzer(Offset P1, Offset Q1, Points currentPoint):
this is a function that returns a boolean value of true when a line is created and false when a line is not created. This function takes three arguments:
1.	Offset P1: this is the offset of the first point of the line that is being created.
2.	Offset Q1: this is the offset of the second point of the line that is being created.
3.	Points currentPoint: this is the current point that is being selected by the user.

how the offsetAnalyzer works?
The offsetAnalyzer function first checks if the line is horizontal or vertical. If the line is horizontal then it checks if the line is in the right direction or left direction. 
 If the line is in the right direction or down direction then it creates a new line and returns true.
 otherwise, it does not create a new line and returns false.
 if (allPoints.contains(point1) && allPoints.contains(point2)) {
        newLine = createLine(
          point1,
          point2,
        ); //gives a call to the createLine function
        print('\nHorizontal Right created: $newLine');
        return true;
      } else if (!allPoints.contains(point1) || !allPoints.contains(point2)) {
        print(
            'point1: $point1 and point2: $point2 are not in the allPoints list and out of bounds. horizontal right line creation failed\n');
        return false;
      }
      
      Example output:
      Points((0, 0) isMarked: false, isDisabled: false, isSelected: false) and point2:
Points((0, -1) isMarked: false, isDisabled: false, isSelected: false) are not in the allPoints list and out of bounds vertical up line creation failed


Vertical Up created: Line(P1:(0,1), P2:(0,0), isPlayer: true, lineDirection: LineDirection.Vert, isNew: true)
    

If the line is vertical then it checks if the line is in the up direction or down direction.
  If the line is in the left direction or up direction then it does not create a new line and returns false.
    otherwise, it creates a new line and returns true.

    the expected output is similar to above.


Lines createLine(Points p1, Points p2):
This function takes two arguments of type Points and returns a Line object. This function is used to create a new line object. This function first checks if the line is horizontal or vertical. 
If the line is horizontal then it checks if the line is in the right direction or left direction. 
 Lines newLine;
  if (p1.xCord == p2.xCord) {
    //check in allPoints where a point matches with p2 and mark that point as selected
    //TODO:set isSelected to false and isMarked to true for the point p1 and p2 if line is valid and not already drawn after the square is checked and formed
    allPoints.forEach((element) {
      if (element == p2) {
        element.isSelected = true;
      }
    });
    //set the newLine's member isNew to true
    newLine =
        Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Vert, isNew: true);
    //add the new line to the list of lines
    allLines.add(newLine);
    //also add the new line to the list of lines drawn by the current user
    humanPlayer.linesDrawn.add(newLine);

    //checking if square has formed:
    checkSquare(newLine);

After checking if the line is horizontal or vertical it does the following things:
 newLine =
        Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Vert, isNew: true);
    //add the new line to the list of lines
    allLines.add(newLine);
    //also add the new line to the list of lines drawn by the current user
    humanPlayer.linesDrawn.add(newLine);

    //checking if square has formed:
    checkSquare(newLine);


void checkSquare(Lines newLine):
This function takes a Line object as an argument and checks if a square has formed or not. This function first checks if the line is horizontal or vertical.
 after checking for appropriate square, it does the following
   Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
            humanPlayer.addSquares(s1);
            print('we have detected a sqaure, I repeat. A square below the newLine\n');
            //in allLines where the line is equal to newLines set its isNew to false
            allLines.forEach((element) {
            if (element == newLine) {
                element.isNew = false;
            }
            });
    
            humanPlayer.incrementScore();
    
            if (GameCanvas.movesLeft == 0) {
            print('out of moves. Game Over');
            }
        }



Now we are gonna find a safe line: A safe line is a line in the game which can be drawn so that the apponent doesn’t get a chance to own a square. There are many safeLines in the beginning of the game but as the game progresses, the newLines will have a greater tendency to form a square and it becomes kinda’ hard to find a safeLine in the game. Therefore, the following rules will help us determine where in the game a safeLine might be present.
Lets consider a square that is formed by four sub-squares and 9 dots. We will be refering to the squares and lines of this giant square in the following terms:
The four sub-squares that form the square of 9 dots are named as top-right aka TR, top-left aka TL, bottom-right aka BR, bottom-left aka BL. These squares are form from four lines ie. Top, bottom, right and left. Altogether  the naming should be as follows:
(going around from top-left to top-right to bottom-right to bottom-left)
•	for the top line in the Top left square the line name is TTL
•	for the left line in the Top left square the line name is LTL
•	for the bottom line in the Top left square the line name is BTL
•	for the right line in the Top left square the line name is RTL


•	for the top line in the Top right square the line name is TTR
•	for the left line in the Top right square the line name is LTR
•	for the bottom line in the Top right square the line name is BTR
•	for the right line in the Top right square the line name is RTR

•	for the top line in the Bottom right square the line name is TBR
•	for the left line in the Bottom right square the line name is LBR
•	for the bottom line in the Bottom right square the line name is BBR
•	for the right line in the Bottom right square the line name is RBR

•	for the top line in the Bottom left square the line name is TBL
•	for the left line in the Bottom left square the line name is LBL
•	for the bottom line in the Bottom left square the line name is BBL
•	for the right line in the Bottom left square the line name is RBL

To make sure that the newline is safe. We need to consider 20 different unsafe scenarios and make sure that none of these scenarios occur so that we can find a safe line. 4 of these scenarios are a bit different from the other 16. Following are the scenarios:
2•	if there are two vertical lines already drawn ie. On the right and left of the newLine then the newline drawn above or below these lines is unsafe.
2•	if there are two horizontal lines already drawn ie. below and above of the newLine then the newline drawn on the right or left of these lines is unsafe.
The following 8 scenarios are when the boundaries lines of the big square might be drawn and we are trying to draw a line inside it.
2•	if there are two lines ie the LTL and TTL in the allLines then the newline drawn on the right or Bottom is unsafe
2•	if there are two lines ie the TTR and RTR in the allLines then the newline drawn on the left or Bottom is unsafe
2•	if there are two lines ie the RBR  and BBR in the allLines then the newline drawn on the left or Top is unsafe
2•	if there are two lines ie the BBL and LBL in the allLines then the newline drawn on the right or Top is unsafe

The following 8 scenarios are when inner lines of the big square might be drawn and we are trying to draw a line outside it.
2•	if there are two lines ie the BTL and RTL (inner lines) in the allLines then the newline drawn on the left or Top is unsafe //this is the scenario of the TopLeft square of the big square
2•	if there are two lines ie the LTR and BTR (inner lines) in the allLines then the newline drawn on the right or Top is unsafe //this is the scenario of the TopRight square of the big square
2•	if there are two lines ie the TBR and LBR (inner lines) in the allLines then the newline drawn on the left or Bottom is unsafe //this is the scenario of the BottomRight square of the big square
2•	if there are two lines ie the RBL and TBL (inner lines) in the allLines then the newline drawn on the right or Bottom is unsafe //this is the scenario of the BottomLeft square of the big square

so in total the above 20 scenarios are the unsafe scenarios and we need to make sure that none of these scenarios occur when we are trying to find a safe line. If any of these scenarios occur then we need to find another safe line. If none of these scenarios occur then we can say that the line is safe to draw.


Now that we have implemented the safe lines list we will use it for several purposes in our game. We are now gonna develop the firstMaxSquareChain function. Following is the full definition of a firstMaxSquareChain():
The firstMaxSquareChain is a series of squares that can be owned by the ai function by drawing a line one after the other and forming a square by each newLine drawn by ai. This is possible will when a user draws an unsafe line which allows the apponent which in this case is aiFunction to consume or own or complete one or more squares in series. Now the question is that how will we find this firstMaxSquareChain. Before we proceed to implement the logic for the firstMaxSquareChain, lets take a look at the definition of a secondMaxSquareChain. A secondMaxSquareChain is also similar to a firstMaxSquareChain but the only difference being that the secondMaxSquareChain has both ends open which mean that although it is not readily awailable to be completed/consumed however it is really dangerous to make a move here because if any player makes a move here. It will cause the entire chain to be available for the apponent. Therefore we have to find this secondMaxSquareChain as well. One more thing, that there may be many secondMaxSquare chains in the game but there can only be one firstMaxSquare chain. We will deal with with this after we are done with the firstMaxSquareCheck. This is why we need to store the secondMaxSquare chains in a list but the firstMaxSquareChain can be calculated and formed on the spot. Following is the flow chart for the firstMaxSquareChain.
•	The first max square chain can be found easily. We just have to find the first line that allows the ai to own a square. Add it to the squares owned and linesdrawn then look again for a line that forms another square and so on. But we will not directly make this move we first have to run this code privately in the ai function and make some calculations and comparisons before doing so. 
•	The firstMaxSquareChain function will contain a copy of allLines list(list of lines drawn in the game) in tempAllLines, tempremainingLines that contains lines of totalLines other than tempAllLines, it will try forEach tempremainingLine where a square may be formed. once we find a line where the square may be formed, we will add  it to the tempSquaresOwned[].
Following pseudo code gives us an idea about the firstSquareMaxChain function:
firstMaxSquareChain() {
	tempAllLines []; //contains a copy of the list of allLines so that we don’t accidently modify the original allLines
	tempRemaining []; //this list contains all the remaining lines. Ie totalLines – allLines;
	//tempSquaresOwned []; //this list will contain the temporary squares formed inside this function. (unnecessary)
	tempFirstChainMoves[]; contains a series of moves to complete squares in chain.
//now we call and define a new function here which well resursively check for squares and add them to tempSquaresOwned[].
	Void customCheckSquare( tempRemaining ) {
		forEach (remainingLine) in tempRemaining {
			if( checkSquare2(remainingLine) ){
				tempAllLines.add(remainingLine);
				tempRemaining.remove(remainingLine);
				tempFirstChainMoves.add(remainingLine);
				customCheckSquare(tempRemaining); //doing recursion
			}
		}
	}
} 


Now that we have tested the firstMaxSquareChain finder function, we are now ready to develop the secondMaxSquareChain(). What is the purpose of secondMaxSquareChain() when we already have the safe line and firstMaxSquareChain()? The answer is that at the final stage of the game we might be out of safeLines that is when we would need to identify the weight of the secondMaxChain to know whether we should completely go through the entire firstMaxSquareChain or stop at the second last line of the tempFirstChainMoves and do the trick move. A trick move is simple we just have to close the firstMaxSquareChain by letting the aiFunction mark the last line of the tempFirstChainMoves when we reach the second last line of the tempFirstChainMoves, why are we doing this? Because this way, although we lose two squares but it also puts the user into the risk of making a line in the secondMaxChain which is exactly what we want because we don’t want the ai to touch the secondMaxChain. Once the user put a line in the secondMaxSquareChain the aiFunction will take the advantage and complete the entire chain and get the score for itself. OK, enough talking, lets talk code now.
Following is the pseudo code for the secondMaxSquareChain function:
List<List<Lines>> tempSecondMaxChainsList = [];
 secondMaxSquareChain(totalLines, allLines, tempFirstChainMoves){
	List<Lines> tempCheckableLines = list of elements that is in in totalLines but not in the tempFirstChainMoves and allLines;
List<Lines> tempAllLines; //this list of lines will hold the lines that are in allLines list and also in the list of tempFirstChainMoves
tempAllLines  = […allLines, … tempFirstChainMoves];
tempCheckableLines = totalLines - tempAllLines  ;
forEach line in tempCheckables {
	tempAllLines.add(line);
	tempFirstChain = firstMaxSquareChain(totalLines, tempAllLines);
	if( !tempSecondMaxChainsList.contains(tempFirstChain) ) { tempSecondMaxChainsList .add(tempFirstChain)}
	tempAllLines.remove(line);

	}
}



After knowing about the safelines, firstMaxSquareChain list and the secondMaxSquareChain list of lists, we now need to let the ai function create appropriate line based on the situation’s safeLines, leastSquareMaxChain, and firstMaxSquareChain to make the appropriate move. A leastSquareMaxChain is a list of lines in the in the  secondMaxSquareChain which contains the lease number of elements/lines. Here is the pseudo code for how the ai will createLine:

List<Lines> leastSquareMaxChain = secondMaxSquareChain.where(list.length is maximum);

If( safeLines.length == 0 && leastSquareMaxChain.length > (1.5* firstMaxSquareChain)){
	doTrickShot();
	}else{
		completeFMC();
	}

Void doTrickShot(FMC){
	If(FMC.length > 1){
		Int trickShotMove = 0;
		While(trickShotMove < FMC.length-2){
			createLine(FMC[trickShotMove]); //run this loop until the secondLastLine. (without secondlastLine)
			trickShotMove++;
			}
		createLine( FMC [ FMC.length – 1 ] ); //create last line
		}
	If( FMC.length ==1 ) { completeFMC();} else{
			createLine( leastSquareMaxChain.selectRandomIndex() );//select any random line from the secondMaxChain length. And create line from it.
		}
	 
	}
Now implementing the completeFMC() this is used for creating the newlines without the need for the doTrickShot(). The logic for the completeFMC() is quite simple. We just have to go through every line in the in the firstMaxSquareChain list of lines and create newLine using the create function for each one of the lines in the firstMaxSquareChain

Building the material 3 UI:

After implementing the logic for the console base application we are now going to work on the ui of the app. The UI of the cellz is going to be entirely built on top of the Material 3 design system. A perfect example would be the material3_demo app. We are gonna utilize most of its components but we will modify it to meet our UI requirements. The following is UI description of the screens:

•	The game has a navigationBar widget which encompasses three items/screens. The first screen on which we will land as the user opens the app is the ‘Home’ screen. The appbar will have the title ‘Home’ in the center and on the left side we will have the drawer. We will come to the contents of the drawer soon. Now lets discuss the body of the home screen. The body of the home screen is simple we only have a 3 buttons labeled as: ‘Play’ , ‘Play with friend', ‘Play Offline’. Lets quickly discuss the roles of these buttons: the first button ‘play’ will automatically navigate the user to the game screen of the latest level that he is at where he will be playing against the aiFunction. The ‘play with friend’ button will ask the navigate the user to a screen where he will be asked to share the link and ‘join-code’ with a friend so that the friend can come to join the friend who invited him. This mode will be integrated using firestore. The last button is ‘Play offline’ this button allows the user to play offline up to the level that he has achieved against the ai function. But here the ai function will be weaker, being able to finish the FMC(firstMaxChain) and pick a safeLine without being able to do the trickshot or calculate the SMC(secondMaxChain). The levels and scores of the user wil not change in the offline mode. 

•	The second screen on the navigationBar is the ‘Journey’ screen. This screen has a carousel slider which will have multiple containers with the same color as the themecolor indicating the levels that are completed by the user. And for the locked levels the container will appear grey. Lets have a look at what the container will contain. The container will have the Level label as a text, a play button to play the repective level, a high score text indicating the highest score that the user has scored, a  total score text indicating the total Score for the level and experience text indicating the performance of the player. This data will come from list of the UnlockedExperience objects list named as ‘unlockedExperienceList’. Following is the structure of the class: 	
Class unlockedExperience{ 
int level;
int totalScore;
int highScore;
int gamesPlayed;
Text CalculateExperience(){
If(this.level == 1){ return Text(‘High’, style: TextStyle(color: Colors.green));}
If(this.level == 2){
//number of xPoints and yPoints are specified for the level 2 use those hard values here.
	Final noOfMoves = (numOfXPoints - 1) * numOfYPoints + (numOfYPoints - 1) * numOfXPoints;
	Final ratio = totalScore / ( noOfMoves* gamesPlayed ) 
	Return ratio > 0.65 ? Text(‘High’, style: TextStyle(color: Colors.green)) : ratio> 0.4? Text(‘Med, style: TextStyle(color: Colors.yellow)) : Text(‘Low, style: TextStyle(color: Colors.red[200]));
	}
//….similarly we will find the experience for the specified level.
}

 }
We will extract the required data from the global list of the unlockedExperience objects and for the remaining levels which are locked the default texts of level, totalScore = 0, highScore = 0 and gamesPlayed = 0 will be displayed on the container of the carousel slider. Below the carousel slider we will have the Overall Stats of the user. This will display the following data which is extracted from the unlockedExperience objects list. 
currentTopLevel; //this shows the top level that is currently unlocked by the user.
totalGamesPlayed;
Experience; //extract the most occurring experience label in the list of unlockedExperienceList

•	The third screen on the navigation bar is the Patrios screen. This screen is for the donations for the app. Since I don’t want to implement ads in my game, the users who ae willing to donate for the app will be able to pay via this screen. This screen will load data from the firestore document which stores 5 of the latest donors. Here is what the UI looks like. At the center we will have a container which will display the image and the name of the top donor. Who is the top donor, it is the user that gives the most number of donations for today. And below this, we will have the other five donors that just made the most recent donations. 

Details of the drawer: 
On the home screen, we have a hamburger icon which opens up the drawer, following is the content of the drawer:
On top we have a label that says Settings, below it we will have a color picker using a gridview that has icons which can be selected to change the colors of the ui. Below the colorPicker we have the option to select dark or light theme. After this we have the account settings where the user will be able to change his name and picture using an AlertDialoguebox. After this we have the send Feedback button which lauch the playstore and open the review section of the app. and at the end we will have a ‘reset all’ button which will make all the list of the unlockedExperienceList empty but this will be done via an alert dialogue box where the user has to type ‘reset all’ in order to reset the all his data. 

Image Picker and name: 
We have two variables one for the userImage and the other for userName.
An alert dialogue box allows the user to click on the circle avatar and pick a color from the gallery or he can also change his name using a textfield in the alert dialogue box.



 

Implementing Firebase Architecture:
Responsive Level selection box on the Inviter side:
We need to allow the inviter to select only the levels that he/she has unlocked using the class list of unlockedExperience. And we also want to be able to store the selected level in a variable so that it can be used as an int value for the joiner.

Now that we have the userInterface ready for the basic interaction with the app and adjusting the settings. We yet have to implement the ui for the gameplay but before that we have to integrate the connection with the firebase firestore. We need it for the players to send invitation and join to play game. This is gonna be done through the connection via an integer code. Here is a brief passage that explains what playing with friend looks like. 
Once the user1 clicks on the share button, it causes the creation of a document in the collection ‘Users’ for the user that just pressed the share button. The following shows what this document looks like:
Uid Of the Document: …
Bool isInviter = true;
String Name = ‘Name of the inviter’
String imageUrl = ‘Image is Uploaded and its url is stored in here’;
Int Score = 0;
 After the creation of the above document of the inviter, we need to create a document in the collection ‘WaitingDocs’. The waiting docs contains all the documents that are waiting for the joiner. A joiner has to enter the 4 digit code to identify the right waiting person or the invitor. Here is what the logic for creation of a document in the ‘WaitingDocs’ looks like. 
We first have to create a random number between 0 to 9999, we will call it intCode. Then we need to check if there exists a document in the ‘WaitingDocs’ collection with the same name as the intCode. If there exists such document, then we return false. And we will keep on checking like this using a while look until we find an intCode for which there is no document with its name as its uid. After finding a unique intCode we need to create a document in the ‘WaitingDocs’ collection with the same name as the current intCode. Here is what the contents of this document looks like:
Uid Of the Document: intCode
Int Level = SelectedLevel
Bool isWaitingStatus = true;
String inviterDocUid = ‘Uid Of the Document of the inviter’
After the creation of the above document the inviter will now wait for the isWaitingStatus of the document to change. 


Invitation Handeling:

Now that we can handle the creation of the necessary document for the invitation we are now going to make some slight changes to better handle the wait process for the inviter. If the code is generated successfully then it would mean that we are good to wait for the joiner to join. But the waiting process needs to be proper for the inviter. After the code is generated, the alert dialogue box should pop automatically after 2 seconds and on the bottom sheet we are going to display a new Text widget that displays ‘(Waiting for your friend to enter 1234 in the join tab)’, this widget is displayed only if a state variable called isCodeGenerated ==true. Not only this, we will also disable the invite button using the same state variable. This way  we will indicate to the inviter that you are waiting for the joiner. In case if the inviter tries to pop the bottom sheet without being joined then we also need to delete the invitation document that was created in order to make sure that we don’t over-crowd the WaitingDocs collection.


Joining Handeling:
After the user submits the value in the 

we need to create a  Future<bool> join(int intCode) async {} function that will be executed as the user submits the code in the alertdialogue box. The following is the logic inside the join() function:
we first check if there exisits a document in the collection ‘WaitingDocs’ under the same uid as the intJoinCode entered by the joiner. If there exists such document then we are going to update the state of Bool isWaitingStatus  to false. This way the inviter will be notified that the joiner has joined the invitation and along with this we also need to upload the profile document of the joiner to the ‘Users’ collection.
The following is the structure of the joiner document:
Uid Of the Document: …
Bool isInviter = false;
String Name = ‘Name of the joiner’
String imageUrl = ‘Image is Uploaded and its url is stored in here’;
Int Score = 0;

After the successful creation of the document we will return true. Otherwise in any case causing errors we will return false. These Boolean values are essential to display validCodeWidget or the invalidCodeWidget from the FutureBuilder.  The following details covers what the FutureBuilder in the join tab does:
In the join tab we are gonna use a Boolean variable named isJoinCodeSubmitted to show the future builder widget or not. Inside the future builder we have three different states. One is the waiting state, this is the state when the future has not been resolved yet. In this case we will display the ‘Loading’ widget. The other two states are possible after the future has resolved and it has either returned true or false. In case if true is returned by the future we will use the snapshot.data to display validCodeWidget or inValidCodeWidget in case if false is returned. 
The validCodeWidget is just a container with a row as its child which contains a tick icon and text ‘Code Correct! Lets Play’.
The inValidCodeWidget is also a similar widget with a cross icon and text ‘Can’t join your friend. Try again!’. 
The Loading widget is is a container with a column that has text ‘Validating’ and a LinearProgressIndicator as its children. 

Connecting two friends in GameplayScreen:

On the joiner side:
Now that we are able to validate the code entered by the joiner, we create a document in the ‘GamePlayDocs’ collection in firestore which will be the main document where the actual game play between the players will happen. The following is the structure of the game play document:
Uid Of the Document: ‘inviterDocUid+intCode’
Int Level = storedLevel on joiner end
inviterRef = inviterDocUid
joinerRef = current uid of the joiner
Bool Turn = true(for the invitor’s turn) / false (for the  joiner’s turn)
String  Move= ‘34’ (these two values indicate the points of the line drawn in this case allPoints[3] and allPoints[4])
The above is just a representation of the fields. The initial values for the fields will be bool Turn = 0; and String Move = ‘’. After creation of the above document, we download the invitation document from which we will find the uid of the inviter and use it as an argument in the GameplayScreen(String inviterUid) we set the isWaiting to false and immediately navigate to the GameplayScreen(inviterUid). On this screen we will simply display the a text ‘Connected with ${inviterName}’. 


On the inviter side:
on the inviter side we listen for any changes on the bottomSheet as soon as we observe a change in the bool isWaitingStatus, we will delete the invitation document and navigate to the GameplayScreen(String inviterUid).



Game Develepment stage right now:
The “Cellz” game during its initial development times did not follow any Software Development model. Nevertheless, we did manage to get the UI ready for the game navigation and stats display. However, the game UI is still not ready and there is also the problem of feasibility within the time-constraint. The following  is a detailed analysis of game development using the waterfall model. I chose the water fall model because the requirement is specified, requiring no modification and feedback in the middle and the entire game will be developed in a single sequential attempt. The following phases specify the general over-view of the game development in the given time-constraint.
Phases of Project:
Feasibility:
We only got like 5 days to finish the project. 
The game logic is all ready and well-tested. Now we just need to develop the interface for the game and link it to the game’s logic to enable game interaction and responsiveness. 
Requirements gathering and analysis:
The “Cellz”, for now, is only planned to be implemented for the mobile. The requirements are clarified for the gameplay. The Naming scheme for the development of certain parts of the game are as follows:
On the home screen of the Cellz we got three buttons i.e.,  “Play”, “Play with friend” and “offline”. This first  button “Play” and its functionality use the label of P1C0 (short for Phase 1 Chapter 0. It’s just a project-codename). Similarly for the other two buttons, we will use the code-names P1C1 and P1C2.
P1C0:
This part of the game is used for the user to play against the aiFunction().Once the user presses the “Play” button. This will cause the user to automatically navigate to the game screen and start playing at the highest level that he is at. He will be playing against the ai but we will make it appear like a human to make it more engaging. The aiFunction will be used to return lines as the opponent of the user. The aiFunction is an advanced function that is designed to return a line in a dynamic fashion according to the given scenarios that will be discussed here. 
This mode will require internet just for formality because the game is already plaid locally. 
Role of the aiFunction up to level 6: The aiFunction will always take about 1- 5 seconds randomly, to return a line. The aiFunction will return only lines for which the safeLines is true or finish the FirstMaxChain in case if available. The aiFunction() will not use the concept of second max chain and the doTrickShot() concept. The reason is that we gradually want to increase the difficulty as we go through the higher levels. 
Role of the aiFunction in level 7 and 8: The aiFunction will get advanced in these levels being able to recognize the secondMaxChain and also be able to do the trick shots inside the first max chain. 
Playing at level 9 and 10: The aiFunction will perform similar as above but the user will now have to score more than 60% to win in the level 9 and more than 75% in the level 10 to win against the ai. 
After winning the game by scoring more than 50% (for levels up to 6), this will modify the global list of unlockedExperienceList thus allowing the user to be promoted to the newer levels after completing a level.
P1C1:
The “Play with friend” button will allow two users of the Cellz to connect via firebase and play against each other. This is done using encoding of a line as a string then broadcasting it as a string and once the player on the other end receives the string, he will be able to decode this line string. Once this new line is rendered the current user will create his own line and this line will then be broadcasted. And the game on the other end will respond accordingly.
P1C2:
The “Play with friend” button will allow the user to play with the ai in a straight forward fashion. In this mode the aiFunction will respond instantly. The profile for the ai player is pre-defined with the name: Artificial Intelligence and the profile pic from the assets folder. This mode will also not require any internet connection.
Extra code-names P1C3 and P1C4:
P1C3:
This part of the Cellz is about the contributions. The concept of contribution is already implemented however we do need to connect the dailyContributionsList to firebase and also make it dynamic alongside the payment. We need to implement the payment service for the users to contribute. After the successful payment process, we must be able to update the UI accordingly.
P1C4:
This part of the game handles the Journey and the Patrios screen. These screens simply use the global lists i.e., unlockedExperienceList and dailyContributionsList. The data from these lists is used for the UI of the Journey and the Patrios screen respectively.
SYSTEM DESIGN:
The system design specifies the implementation details of the chapters that are discussed above in the form of pseudocode. The main chapters are further divided into parts that are denoted in the form of “P1C0P1”. This indicates the part 1 of the chapter 0. The following is the description of the chapters and its parts. 
P1C0P1 to P1C0P6:
Here, we will work on the entire UI and the state of the “Play” screen. Here the user is going to play with aiFunction which will be dynamic i.e., from Level 1 to Level 6, the aiFunction will use the bool “isMediocre” to know whether or not we need the aiFunction needs to do the trick shot or not. The following is the design of the “Play” screen.
P1C0P1:
In this part we initialize the variables to set the level in the appbar to the selected level. In the scaffold we will have two profiles. The first one is of the current user and the second one is that of the aiFunction. 

We simply display the profile of the user and name for the first Player’s Container. But for the profile of ai we will randomly pick an image from list of URLs and names specified in the AiProfiles class.
We will use state variables for the scores of the user as well as the controlling the Shifting colors of the container and for returning an animated circular container in case of the current players turn.

we will also override the popping of the back button to make sure that the user really  wants to exit the game. 

P1C0P2:
Point representation:
There will be a canvasContainer in the middle that will contain a stack widget with its first widget of the stack being the gridview for the allPoints where each point has a gesture detector allowing the user to pan and create line. 
The point object has four Boolean control states. These states are as:
isUntouched: This boolean member of the point will be used to make the point appear like an outlined circle thus indication that the point is not used yet. 
isSelected: This boolean member of the point will be used to make the point appear like a filled circle but its radius will be larger that the normal point. 
isMarked: This boolean member of the point will be used to make the point appear like a filled circle of normal radius. 
isDisabled: This boolean is used to indicate that whether or not the point is disabled. This member is not going to be used for any UI but it will be used to ignore the gesture detector the point that is disabled. A disabled point is a point that is present four times in the allUsedPoints list.
Line  representation:
The second widget of the stack will be a gridview for lines that will be used to return linear progress indicators for representing the lines. The new line which gets created will be animated using LinearProgressIndicator widget. 
Square  representation:
The third widget of the stack will be a gridview for squares. To calculate the number of squares we will use the following algorithm: no. of squares = (no. of XPoints – 1) * (no. of YPoints – 1). The number of squares will be used  in the gridview for creating the number of squares. 
P1C0P3:
This part of the game contains the createPoints function which is responsible for the creation of points UI. It works by returning a Container with a gesture detector for the gridview. The offset Analyzer is called after the drag detection by point. The offset Analyzer uses two offset objects to create the proper line. After the Line is created using the createLine method the checkSquare method is called for the detection of squares. 
P1C0P3:
UpdateUI:
This method is called to update the states variables and make the changes visible on the game canvas by calling the setState on the local variables so that the scores and widgets may update. 
SwtichTurn:
This method is called after the update of the UI to switch the turn to the other player. This causes to make the gesture detector of the points for current users useless and unresponsive.
createLine(aiFunction()):
This is called after the player has already done his move. This causes the line to be created after the aiFunction returns the line.
P1C1P1 to P1C1P4:
This part of the game focuses on the development of the game play for the two users that will be connected via Firebase. The code for the players’ connection has already been implemented now we need to implement the state-management and data transfer via Firebase to both inviter and the joiner. 
Inviter-side Logic:
P1C1P1:
On the inviter side we will first initialize the local variables from the firestore’s game play document. After this we will delete the inviter’s document. Then after first move is done on the inviter’s side, we will do the work explained as follows:
P1C1P2:
We will then update the UI and encode the line in a string variable and update the string representing the line in the firestore. 
P1C1P3:
we will switch the turn and inform the joiner using stream builder on the joiner’s side. 
Now on the inviter’s side we will listen for changes in the turn value of the firestore’s game play document using stream Builder and once it is the inviter’s turn the gesture detector will be enabled again.

Joiner-side Logic:
P1C1P4:
On the joiner’s side we will decode the string representing the line and pass it to the createLine function. Thus, creating the line and also checking for the squares. After this the joiner will make his move and after creating the line, we will update the UI and encode the line in a string variable and update the string representing the line in the firestore. And so the game will be played
P1C1P4:
We will also calculate the created line and when the remaining moves are 0 we will display an Alert Dialogue box after navigating to the Home screen. This is not the only way to win. In case if the 20 seconds passes without the creation of any lines we will also do the same and return an AlertDialogue  box for losing the game.

P1C2P1 to P1C2P2:
The Play offline screen:
On this screen, we will use most of the above logic with only the following two basic changes:
P1C2P1:
We will load the profile using the profile image in the assets folder and also give a name “AI”.
P1C2P2:
We will call the aiFunction for creating line with the isMediocre set to true. The game play is pretty similar to the aiFunction.

P1C3P1 to P1C3P2:
The Contributions Screen:
P1C3P1:
We will implement the google pay for the android version of the app and if the platform is Ios we will implement the apple pay. There will be three payment selection options of 1$ , 5$ and 10$.
P1C3P2:
After the payment  we will update the document in the firestore that contains the details of the contributions. However, the changes will be visible to the users who reopen the Cellz app. This is because the data for the Contributions screen is only downloaded in the init method of myApp widget. 



P1C4P1:
The Journey and Patrios Screen:
P1C3P1:
Updating the data on the Journey and Patrios screen in done in the part of the development. We simply have to load the data from the following lists:
List<UnlockedExperience> unlockedExperienceList = [];
 
//create a list of daily contributions class

List<DailyContributions> dailyContributionsList = [];
 
Now that the system requirements for the Cellz game are specified, we are now going to implement the game using the waterfall model. Lets start coding!


