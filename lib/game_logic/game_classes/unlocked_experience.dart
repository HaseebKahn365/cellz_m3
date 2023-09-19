class UnlockedExperience {
  int highScore;
  int totalScore;
  final int level;
  final String experience;
  bool isUnlocked;
  int gamesPlayed;

  UnlockedExperience({
    required this.highScore,
    required this.level,
    required this.totalScore,
    required this.experience,
    required this.gamesPlayed,
    this.isUnlocked = false,
  });

  void updateHighScore(int newHighScore) {
    if (newHighScore > highScore) {
      highScore = newHighScore;
    }
  }

  void updateTotalScore(int newTotalScore) {
    totalScore += newTotalScore;
  }

  void updateGamesPlayed() {
    gamesPlayed++;
  }

  // the calculateExperience function will look at the current totalScore, level and games played and return the experience
}
