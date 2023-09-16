import '../game_classes.dart';

class GamePlayers {
  bool isPlayer = false;
  int score = 0;
  int numOfLives = 4;
  bool hasTurn;
  List<Lines> linesDrawn = [];
  List<Square> squaresOwned = [];
  //Constructor to instantiate the values:
  GamePlayers(
      {required this.isPlayer,
      this.hasTurn = true,
      required this.score,
      required this.numOfLives,
      required this.linesDrawn,
      required this.squaresOwned});

  void incrementScore() {
    //increments the score as user completes a square/squares
    this.score++;
  }

  void loseLife() {
    //this.life--;
    this.numOfLives = this.numOfLives - 1;
  }

  void addSquares(Square s1) {
    squaresOwned.add(s1);
  }

  //a method to add to the linesDrawn list

  void addLines(Lines l1) {
    linesDrawn.add(l1);
  }

  @override
  String toString() {
    return 'GamePlayer(isPlayer: $isPlayer, score: $score, numOfLives: $numOfLives, linesDrawn: ${linesDrawn.length}, squaresOwned: $squaresOwned)';
  }
}
