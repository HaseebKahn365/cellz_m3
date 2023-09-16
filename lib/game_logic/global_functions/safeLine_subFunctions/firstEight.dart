import '../../game_classes.dart';
import '../../lists_of_objects.dart';
import '../create_line_checkSq.dart';

bool firstEightScenarios(Lines line) {
//   The following 8 scenarios are when the boundaries lines of the big square might be drawn and we are trying to draw a line inside it.
// 2•	if there are two lines ie the LTL and TTL in the allLines then the newline drawn on the right or Bottom is unsafe

//let the recieved line be the BTL line then we need to check if the LTL and TTL lines are drawn or not

  Points leftPoint = line.firstPoint;
  Points rightPoint = line.secondPoint;

  //defining LTL from the leftPoint
  //Only check it if the line is horizontal

  Lines LTL;
  Lines TTL;

  if (line.lineDirection == LineDirection.Horiz) {
    Lines LTL = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining TTL from leftPoint and rightPoint
    Lines TTL = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord - 1, yCord: rightPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(LTL) && allLines.contains(TTL)) {
      return false;
    }
  }

//let the recieved line be the RTL then we need to check again if the LTL and TTL lines are drawn or not

  Points upperPoint = line.firstPoint;
  Points lowerPoint = line.secondPoint;

  //defining LTL from the upperPoint
  //only check it if the line is vertical

  if (line.lineDirection == LineDirection.Vert) {
    LTL = Lines(
        firstPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining TTL from upperPoint and lowerPoint
    TTL = Lines(
        firstPoint: upperPoint,
        secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(LTL) && allLines.contains(TTL)) {
      return false;
    }
  }

//let the received line be the BTR line then we need to check if the TTR and RTR lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining TTR from the rightPoint

  Lines TTR;
  Lines RTR;

  if (line.lineDirection == LineDirection.Horiz) {
    TTR = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining RTR from leftPoint and rightPoint
    RTR = Lines(
        firstPoint: rightPoint,
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(TTR) && allLines.contains(RTR)) {
      return false;
    }
  }

  //let the recieved line be the LTR then we need to check again if the TTR and RTR lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining TTR from the upperPoint

  if (line.lineDirection == LineDirection.Vert) {
    TTR = Lines(
        firstPoint: upperPoint,
        secondPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining RTR from upperPoint and lowerPoint
    RTR = Lines(
        firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(TTR) && allLines.contains(RTR)) {
      return false;
    }
  }

//let the received line be the LBR line then we need to check if the RBR and BBR lines are drawn or not //TODO: check this code

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;
  Lines RBR;
  Lines BBR;

  //defining RBR from the rightPoint
  if (line.lineDirection == LineDirection.Vert) {
    RBR = Lines(
        firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining BBR from leftPoint and rightPoint
    BBR = Lines(
        firstPoint: lowerPoint,
        secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(RBR) && allLines.contains(BBR)) {
      return false;
    }
  }

  //let the recieved line be the TBR then we need to check again if the RBR and BBR lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining RBR from the lowerPoint
  if (line.lineDirection == LineDirection.Horiz) {
    RBR = Lines(
        firstPoint: rightPoint,
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining BBR from upperPoint and lowerPoint
    BBR = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(RBR) && allLines.contains(BBR)) {
      return false;
    }
  }

  //let the received line be the TBL line then we need to check if the BBL and LBL lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining BBL from the leftPoint
  Lines BBL;
  Lines LBL;

  if (line.lineDirection == LineDirection.Horiz) {
    BBL = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining LBL from leftPoint and rightPoint
    LBL = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(BBL) && allLines.contains(LBL)) {
      return false;
    }
  }

  //let the recieved line be the RBL then we need to check again if the BBL and LBL lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining BBL from the lowerPoint
  if (line.lineDirection == LineDirection.Vert) {
    BBL = Lines(
        firstPoint: lowerPoint,
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining LBL from upperPoint and lowerPoint
    LBL = Lines(
        firstPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(BBL) && allLines.contains(LBL)) {
      return false;
    }
  }

  //now we have checked all the 8 scenarios and we can say that the line is safe to draw

  return true;
}
