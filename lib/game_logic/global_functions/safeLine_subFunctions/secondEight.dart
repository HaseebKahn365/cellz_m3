import '../../game_classes.dart';
import '../../lists_of_objects.dart';
import '../create_line_checkSq.dart';

bool secondEightScenarios(Lines line) {
//   The following 8 scenarios are when inner lines of the big square might be drawn and we are trying to draw a line on the border.

// 2•	if there are two lines ie the BTL and RTL (inner lines) in the allLines then the newline drawn on the left or Top is unsafe //this is the scenario of the TopLeft square of the big square

//let the recieved line be the LTL line then we need to check if the BTL and RTL lines are drawn or not

  Points upperPoint = line.firstPoint;
  Points lowerPoint = line.secondPoint;

//defining BTL from the lowerPoint

  Lines BTL;
  Lines RTL;

  if (line.lineDirection == LineDirection.Vert) {
    BTL = Lines(
        firstPoint: lowerPoint,
        secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

//defining RTL from upperPoint and lowerPoint

    RTL = Lines(
        firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    if (allLines.contains(BTL) && allLines.contains(RTL)) {
      return false;
    }
  }

//let the recieved line be the TTL then we need to check again if the BTL and RTL lines are drawn or not

  Points leftPoint = line.firstPoint;
  Points rightPoint = line.secondPoint;

//defining RTL from the rightPoint

  if (line.lineDirection == LineDirection.Horiz) {
    RTL = Lines(
        firstPoint: rightPoint,
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

//defining BTL from leftPoint and rightPoint

    BTL = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(BTL) && allLines.contains(RTL)) {
      return false;
    }
  }
  //let the received line be the TTR line then we need to check if the LTR and BTR lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  Lines LTR;
  Lines BTR;

  //defining LTR from the leftPoint
  if (line.lineDirection == LineDirection.Horiz) {
    LTR = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining BTR from leftPoint and rightPoint

    BTR = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(LTR) && allLines.contains(BTR)) {
      return false;
    }
  }

  //let the recieved line be the RTR then we need to check again if the LTR and BTR lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining BTR from the lowerPoint
  if (line.lineDirection == LineDirection.Vert) {
    BTR = Lines(
        firstPoint: lowerPoint,
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    //defining LTR from upperPoint and lowerPoint

    LTR = Lines(
        firstPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    if (allLines.contains(LTR) && allLines.contains(BTR)) {
      return false;
    }
  }

  //let the received line be the RBR line then we need to check if the TBR and LBR lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining TBR from the upperPoint
  Lines TBR;
  Lines LBR;

  if (line.lineDirection == LineDirection.Vert) {
    TBR = Lines(
        firstPoint: upperPoint,
        secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    //defining LBR from upperPoint and lowerPoint

    LBR = Lines(
        firstPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    if (allLines.contains(TBR) && allLines.contains(LBR)) {
      return false;
    }
  }

  //let the recieved line be the BBR then we need to check again if the TBR and LBR lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining LBR from the rightPoint
  if (line.lineDirection == LineDirection.Horiz) {
    LBR = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining TBR from leftPoint and rightPoint

    TBR = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(TBR) && allLines.contains(LBR)) {
      return false;
    }
  }

  //let the received line be the BBL line then we need to check if the TBL and RBL lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining RBL from the rightPoint
  Lines RBL;
  Lines TBL;

  if (line.lineDirection == LineDirection.Horiz) {
    RBL = Lines(
        firstPoint: rightPoint,
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining TBL from leftPoint and rightPoint

    TBL = Lines(
        firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
        secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(TBL) && allLines.contains(RBL)) {
      return false;
    }
  }

  //let the recieved line be the LBL then we need to check again if the TBL and RBL lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining TBL from the upperPoint
  if (line.lineDirection == LineDirection.Vert) {
    TBL = Lines(
        firstPoint: upperPoint,
        secondPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    //defining RBL from upperPoint and lowerPoint

    RBL = Lines(
        firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    if (allLines.contains(TBL) && allLines.contains(RBL)) {
      return false;
    }
  }

  //now we have checked all the 8 scenarios and we can say that the line is safe to draw

  return true;
}
