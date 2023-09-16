import '../lists_of_objects.dart';

class Points {
  int xCord;
  int yCord;
  bool isUntouched; //used to mark the point as outlined container
  bool isMarked; //used to mark the point as bold if already used
  bool isDisabled; //used to avoid selection if point is connected in all four directions
  bool isSelected; //use to mark the point even bolder. When drawing a line
  Points(
      {required this.xCord,
      required this.yCord,
      this.isUntouched = true,
      this.isSelected = false,
      this.isDisabled = false,
      this.isMarked = false});
  @override
  //properly overload the == opertor for use like this: p1 == p2 shoudl return true if their respective xCord and yCord are equal
  //'Points.==' ('bool Function(Points)') isn't a valid override of 'Object.==' ('bool Function(Object)').dartinvalid_override
  bool operator ==(Object other) {
    if (other is Points) {
      return this.xCord == other.xCord && this.yCord == other.yCord;
    }
    return false;
  }

  static bool checkDisability(Points p1) {
    if (p1.isDisabled == true) {
      return true;
    }
    //find number of instances of p1 in pointsUsed
    if (allPoints.where((element) => element.xCord == p1.xCord && element.yCord == p1.yCord).length > 3) {
      return true;
    }
    return false;
  }

  // static bool checkNearby(Points p1, Points p2) {
  //   if (p1.xCord == p2.xCord && p1.yCord == p2.yCord) {
  //     return false;
  //   }
  //   if (p1.xCord == p2.xCord && p1.yCord == p2.yCord + 1) {
  //     return true;
  //   }
  //   if (p1.xCord == p2.xCord && p1.yCord == p2.yCord - 1) {
  //     return true;
  //   }
  //   if (p1.xCord == p2.xCord + 1 && p1.yCord == p2.yCord) {
  //     return true;
  //   }
  //   if (p1.xCord == p2.xCord - 1 && p1.yCord == p2.yCord) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  String toString() {
    return '\nPoints(($xCord, $yCord) isMarked: $isMarked, isDisabled: $isDisabled, isSelected: $isSelected)';
  }

  @override
  int get hashCode => xCord.hashCode ^ yCord.hashCode;
}
