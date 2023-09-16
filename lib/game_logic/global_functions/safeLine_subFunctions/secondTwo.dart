import '../../game_classes.dart';
import '../../lists_of_objects.dart';
import '../create_line_checkSq.dart';

bool secondTwoScenarios(Lines line) {
  //lets say that the point1 is the upperPoint of the line and point2 is the lowerPoint of the line.
  //we gotta make sure that there are no horizontal lines on the top and bottom of the currentLine'S upperPoint and lowerPoint respectively

  Points upperPoint = line.firstPoint;
  Points lowerPoint = line.secondPoint;

  //horizontal line 1 on the right of the upper point:
  Lines horizontalLine1 = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //horizontal line 2 on the right of the lower point:
  Lines horizontalLine2 = Lines(
      firstPoint: lowerPoint,
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //horizontal line 3 on the left of the upper point:
  Lines horizontalLine3 = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //horizontal line 4 on the left of the lower point:
  Lines horizontalLine4 = Lines(
      firstPoint: lowerPoint,
      secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(horizontalLine1) && allLines.contains(horizontalLine2)) {
    return false;
  }

  if (allLines.contains(horizontalLine3) && allLines.contains(horizontalLine4)) {
    return false;
  }

  //last control statement
  else {
    return true;
  }
}
