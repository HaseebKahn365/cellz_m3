import '../../game_classes.dart';
import '../create_line_checkSq.dart';

List<Lines> firstMaxSquareChain(List<Lines> totalLines, List<Lines> allLines) {
  List<Lines> tempAllLines = [];
  List<Lines> tempRemaining = [];
  List<Lines> tempFirstChainMoves = [];

  tempAllLines = List.from(allLines);
  // tempRemaining = List.from(totalLines); //tempRemaining contains all the lines that are not in the allLines list
  tempRemaining = totalLines.where((element) => !tempAllLines.contains(element)).toList();
  //calling the customCheckSquare

  void customCheckSquare(List<Lines> tempRemaining) {
    for (int i = 0; i < tempRemaining.length; i++) {
      if (checkSquare2(tempRemaining[i], tempAllLines)) {
        tempFirstChainMoves.add(tempRemaining[i]);
        tempAllLines.add(tempRemaining[i]);
        tempRemaining.remove(tempRemaining[i]);
        customCheckSquare(
          tempRemaining,
        );
      }
    }
  }

  customCheckSquare(tempRemaining);

  return tempFirstChainMoves;
}

bool checkSquare2(Lines line, List<Lines> tempAllLines) {
  switch (line.lineDirection) {
    case LineDirection.Horiz:

      //checking for the square below the newLine becuase origin point in in the top left corner and y increases downwards
      Lines L1 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord),
          secondPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert); //first vertical line

      Lines L2 = Lines(
          firstPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord),
          secondPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      Lines L3 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord + 1),
          secondPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      if (tempAllLines.contains(L1) && tempAllLines.contains(L2) && tempAllLines.contains(L3)) {
        // print('square found for line: $line');
        return true;
      }

      //checking for the square above the line becuase origin point in in the top left corner and y increases downwards
      // print(
      //     'checking for the square above the line becuase origin point in in the top left corner and y increases downwards\n');
      L1 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord),
          secondPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      L2 = Lines(
          firstPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord),
          secondPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      L3 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord - 1),
          secondPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      // print('l1 containment check: ${tempAllLines.contains(L1)} and l1: $L1');
      // print('l2 containment check: ${tempAllLines.contains(L2)} and l2: $L2');
      // print('l3 containment check: ${tempAllLines.contains(L3)} and l3: $L3');  these return true as these should.

      if (tempAllLines.contains(L1) && tempAllLines.contains(L2) && tempAllLines.contains(L3)) {
        // print('square found for line: $line');
        return true;
      }

      return false;

    case LineDirection.Vert:

      //checking for the square on the left side of the line in the same manner as above
      Lines L1 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord),
          secondPoint: Points(xCord: line.firstPoint.xCord - 1, yCord: line.firstPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      Lines L2 = Lines(
          firstPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord),
          secondPoint: Points(xCord: line.secondPoint.xCord - 1, yCord: line.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      Lines L3 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord - 1, yCord: line.firstPoint.yCord),
          secondPoint: Points(xCord: line.secondPoint.xCord - 1, yCord: line.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      if (tempAllLines.contains(L1) && tempAllLines.contains(L2) && tempAllLines.contains(L3)) {
        // print('square found for line: $line');
        return true;
      }

      //After checking for the square above, we are going to check for the square on the right side of 	the line in 	the same manner as above

      L1 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord, yCord: line.firstPoint.yCord),
          secondPoint: Points(xCord: line.firstPoint.xCord + 1, yCord: line.firstPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      L2 = Lines(
          firstPoint: Points(xCord: line.secondPoint.xCord, yCord: line.secondPoint.yCord),
          secondPoint: Points(xCord: line.secondPoint.xCord + 1, yCord: line.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      L3 = Lines(
          firstPoint: Points(xCord: line.firstPoint.xCord + 1, yCord: line.firstPoint.yCord),
          secondPoint: Points(xCord: line.secondPoint.xCord + 1, yCord: line.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      if (tempAllLines.contains(L1) && tempAllLines.contains(L2) && tempAllLines.contains(L3)) {
        //print('square found for line: $line');
        return true;
      }

      return false;
  }
}
