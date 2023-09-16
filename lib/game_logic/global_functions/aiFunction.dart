//this is the testing stage of the aiFunction

import '../game_classes.dart';
import '../lists_of_objects.dart';
import 'create_line_checkSq.dart';
import 'safeLine_subFunctions/safeline_barrel.dart';
import 'square_chain_functions/firstMaxSquareChain.dart';
import 'square_chain_functions/secondMaxChain.dart';

void aiFunction() {
  int numberOfXPoints = 4;
  int numberOfYPoints = 5;
//lets create the totalLines list

  List<Lines> totalLines = [];

  for (int i = 0; i < numberOfYPoints; i++) {
    for (int j = 0; j < numberOfXPoints - 1; j++) {
      Lines newLine = Lines(
          firstPoint: allPoints[i * numberOfXPoints + j],
          secondPoint: allPoints[i * numberOfXPoints + j + 1],
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);
      totalLines.add(newLine);
    }
  }
//now doing the same for the vertical lines

  for (int i = 0; i < numberOfXPoints; i++) {
    for (int j = 0; j < numberOfYPoints - 1; j++) {
      Lines newLine = Lines(
          firstPoint: allPoints[i + j * numberOfXPoints],
          secondPoint: allPoints[i + (j + 1) * numberOfXPoints],
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);
      totalLines.add(newLine);
    }
  }

  print('toatl lines length is ${totalLines.length}');
  print(GameCanvas
      .movesLeft); //test passed: the totalLines list is created properly and the length is 31 which is correct. this is becuase we have 4Xpoints and 5Ypoints and the total number of lines is 5*3 + 4*4 = 31
//making sure that all the lines in the totalLines list are correct and valid.

  // for (int i = 0; i < totalLines.length; i++) {
  //   print(totalLines[i]);
  // }

  //creating a nullable list of safeLine Lines objects
  bool isSafeLine(Lines line) {
    Lines currentLine = line;

// so in total the above 20 scenarios are the unsafe scenarios and we need to make sure that none of these scenarios occur when we are trying to find a safe line. If any of these scenarios occur then we need to find another safe line. If none of these scenarios occur then we can say that the line is safe to draw.
//list of first four scenarios ie. the two parallel vertical lines and two parallel horizontal lines will be checked in the following code
//the firstTwoScenarios are testing only if the current line is a horizontal line

    bool isSafeFirstTwo = (currentLine.lineDirection == LineDirection.Horiz) ? firstTwoScenarios(currentLine) : true;
    bool isSafeSecondTwo = (currentLine.lineDirection == LineDirection.Vert) ? secondTwoScenarios(currentLine) : true;

    bool isSafeFirstEight = firstEightScenarios(currentLine);
    bool isSafeSecondEight = secondEightScenarios(currentLine);

    if (isSafeFirstTwo && isSafeSecondTwo && isSafeFirstEight && isSafeSecondEight) {
      return true;
    } else {
      return false;
    }
  }
//implementing the logic to assign a proper safe Lines to the safeLines list
  //we will iterate through all the totalLines then look for the unsafe lines in the allLines and assign all the safe lines to the safeLines list
  //Lets create another function that looks for a safeLine and returns it

//lets dig through the entire possible horizontal lines and find the safe line
  List<Lines?> safeLines = [];

  for (int i = 0; i < totalLines.length; i++) {
    if (totalLines[i].lineDirection == LineDirection.Horiz) {
      if (isSafeLine(totalLines[i])) {
        if (!allLines.contains(totalLines[i])) {
          safeLines.add(totalLines[i]);
        }
      }
    }
  }

  //lets dig through the entire possible vertical lines and find the safe line

  for (int i = 0; i < totalLines.length; i++) {
    if (totalLines[i].lineDirection == LineDirection.Vert) {
      if (isSafeLine(totalLines[i])) {
        if (!safeLines.contains(totalLines[i]) && !allLines.contains(totalLines[i])) {
          safeLines.add(totalLines[i]);
        }
      }
    }
  }

  //Implementing the isSafeLine function. This function will return true if the line is safe and false if it is not safe
  //Now lets test safe lines. we should get all the lines in the safeLines list as there are in the
  print('safe lines length is ${safeLines.length}');

  List<Lines> firstChainMoves = [];
  firstChainMoves = firstMaxSquareChain(List.from(totalLines), List.from(allLines));
  print('first chain moves length is ${firstChainMoves.length}');
  firstChainMoves.forEach(print);

  List<List<Lines>> secondChainMoves = [];
  secondChainMoves = secondMaxSquareChain(List.from(totalLines), List.from(allLines), List.from(firstChainMoves));
  print('second chain moves length is ${secondChainMoves.length}');

  //idetifying leastSquareMaxChain in the secondChainMoves list of lists

  List<Lines> leastSMC = [];
  leastSMC = secondChainMoves[0];
  for (int i = 0; i < secondChainMoves.length; i++) {
    if (secondChainMoves[i].length < leastSMC.length) {
      leastSMC = secondChainMoves[i];
    }
  }

//implementing the completeFMC function

  void completeFMC() {
    for (int i = 0; i < firstChainMoves.length; i++) {
      if (!allLines.contains(firstChainMoves[i])) {
        createLine(firstChainMoves[i].firstPoint, firstChainMoves[i].secondPoint);

        // break; don't break the loop as we need to create all the lines in the firstChainMoves
      } else {
        print('allLines already contains all the lines in the firstChainMoves list: unusual case');
      }
    }
    print('created all the lines in the firstChainMoves list');
    //if the length of the safeLines is not zero then create a line from the list of the safeLines else create from the leastSMC
    if (safeLines.length != 0) {
      Lines useless = safeLines[0]!;
      createLine(useless.firstPoint, useless.secondPoint);
      print('created line from the safe Lines');
    } else {
      Lines useless = leastSMC[0];
      createLine(useless.firstPoint, useless.secondPoint);
      print('created line from the leastSMC');
    }
  }

  //implementing the doTrickShot function

  void doTrickShot(List<Lines> FMC) {
    if (FMC.length > 1) {
      int trickShotMove = 0;
      while (trickShotMove < FMC.length - 2) {
        createLine(FMC[trickShotMove].firstPoint,
            FMC[trickShotMove].secondPoint); //run this loop until the secondLastLine. (without secondlastLine)
        trickShotMove++;
        print('trickShotMove is $trickShotMove');
      }
      createLine(
          FMC[FMC.length - 1].firstPoint,
          FMC[FMC.length - 1]
              .secondPoint); //dart allows us to discard the return value of a function. So we can just discard the return value of the createLine function
      if (FMC.length == 1) {
        completeFMC();
      } else {
        Lines useless2 =
            leastSMC[0]; //useless2 means that i am just using it to make a move and i don't need the returned line
        createLine(useless2.firstPoint,
            useless2.secondPoint); //select any random line from the secondMaxChain length. And create line from it.
      }
    }
  } //end of doTrickShot function

  if (safeLines.length == 0 && leastSMC.length > (1.5 * firstChainMoves.length)) {
    print('doTrickShot function called');
    doTrickShot(firstChainMoves);
  } else {
    completeFMC();
  } //end of aiFunction making a move
}
