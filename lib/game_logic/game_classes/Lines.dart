import '../game_classes.dart';

class Lines {
  Points firstPoint;
  Points secondPoint;
  GamePlayers owner;
  LineDirection lineDirection;
  bool isNew;
  Lines(
      {required this.firstPoint,
      required this.secondPoint,
      required this.owner,
      required this.lineDirection,
      this.isNew = false});
  void animate(Lines providedLine) {
    print('Animating the line: $providedLine');
  }

  @override
  String toString() {
    return 'Line(P1:(${firstPoint.xCord},${firstPoint.yCord}), P2:(${secondPoint.xCord},${secondPoint.yCord}), isPlayer: ${owner.isPlayer}, lineDirection: $lineDirection, isNew: $isNew)\n';
  }

//There is a major problem with this simple overload becuase it considers the order of the points in the line whereas it should not.
//to fix this we need to add an extra condition to check if the points are equal or not
  @override
  bool operator ==(Object other) {
    if (other is Lines) {
      return this.firstPoint == other.firstPoint && this.secondPoint == other.secondPoint ||
          this.firstPoint == other.secondPoint &&
              this.secondPoint == other.firstPoint; //hopefully this fixes the problem
    }
    return false;
  }

  //override the hashcodes so that lines with the same first and second points should have the same hashcodes
  @override
  int get hashCode => firstPoint.hashCode ^ secondPoint.hashCode;
}

enum LineDirection { Horiz, Vert }
