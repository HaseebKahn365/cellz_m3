import '../../game_classes.dart';
import '../../lists_of_objects.dart';
import '../create_line_checkSq.dart';

bool firstTwoScenarios(Lines line) {
  //lets say that the point1 is the left point and point2 is the right point.
  //we gotta make sure that there are no vertical lines on the left and right of the currentLine'S left point and right point respectively

  //

  Points leftPoint = line.firstPoint;
  Points rightPoint = line.secondPoint;

  //vertical line 1 below the left point:
  Lines verticalLine1 = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //vertical line 2 below the right point:
  Lines verticalLine2 = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //vertical line 3 above the left point:
  Lines verticalLine3 = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //vertical line 4 above the right point:
  Lines verticalLine4 = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  if (allLines.contains(verticalLine1) && allLines.contains(verticalLine2)) {
    return false;
  }

  if (allLines.contains(verticalLine3) && allLines.contains(verticalLine4)) {
    return false;
  }

//last control statement
  else {
    return true;
  }
}
