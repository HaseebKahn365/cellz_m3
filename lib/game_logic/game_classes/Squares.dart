import '../lists_of_objects.dart';
import 'Lines.dart';

class Square {
  Lines L1Horiz;
  Lines L2Horiz;
  Lines L1Vert;
  Lines L2Vert;
  Square({required this.L1Horiz, required this.L2Horiz, required this.L1Vert, required this.L2Vert});

  @override
  String toString() {
    //i have to make sure that the lines details below are printed in the form of P1 allPoints[index]-> P2 allPoints[index].
    return 'Square(L1Horiz: P1 [${allPoints.indexOf(L1Horiz.firstPoint)}]-> P2 [${allPoints.indexOf(L1Horiz.secondPoint)}], L2Horiz: P1 [${allPoints.indexOf(L2Horiz.firstPoint)}]-> P2 [${allPoints.indexOf(L2Horiz.secondPoint)}], L1Vert: P1 [${allPoints.indexOf(L1Vert.firstPoint)}]-> P2 [${allPoints.indexOf(L1Vert.secondPoint)}], L2Vert: P1 [${allPoints.indexOf(L2Vert.firstPoint)}]-> P2 [${allPoints.indexOf(L2Vert.secondPoint)}])\n';
  }

  @override
  bool operator ==(Object other) {
    if (other is Square) {
      return this.L1Horiz == other.L1Horiz &&
          this.L2Horiz == other.L2Horiz &&
          this.L1Vert == other.L1Vert &&
          this.L2Vert == other.L2Vert;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
