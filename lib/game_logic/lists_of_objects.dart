import 'game_classes.dart';
import 'game_classes/daily_contributions.dart';
import 'game_classes/unlocked_experience.dart';

List allPoints = <Points>[];

List<Lines> allLines = [];

//the following list will contain all the points that are used to draw the lines. we will check if the same point is present four times then it will be marked disabled. we will use this property to ignore the gesture detector on the point
List<Points> allUsedPoints = [];

//create a list of unlocked Experience class with a max size of 10

List<UnlockedExperience> unlockedExperienceList = [];

//create a list of daily contributions class

List<DailyContributions> dailyContributionsList = [];

//creating a function to initialize the lists

void initLists() {
  unlockedExperienceList.add(UnlockedExperience(
    highScore: 34,
    level: 1,
    totalScore: 312,
    experience: 'Low',
    gamesPlayed: 32,
    isUnlocked: true,
  ));

  unlockedExperienceList.add(UnlockedExperience(
    highScore: 56,
    level: 2,
    totalScore: 141,
    experience: 'Mid',
    gamesPlayed: 32,
    isUnlocked: true,
  ));

  unlockedExperienceList.add(UnlockedExperience(
    highScore: 78,
    level: 3,
    totalScore: 312,
    experience: 'High',
    gamesPlayed: 32,
    isUnlocked: true,
  ));

  unlockedExperienceList.add(UnlockedExperience(
    highScore: 90,
    level: 4,
    totalScore: 312,
    experience: 'High',
    gamesPlayed: 32,
    isUnlocked: false,
  ));

  for (var i = 4; i < 10; i++) {
    unlockedExperienceList.add(UnlockedExperience(
      highScore: 0,
      level: i + 1,
      totalScore: 0,
      experience: 'Low',
      gamesPlayed: 0,
      isUnlocked: false,
    ));
  }

// now sort the unlocked experience list in descending order base on the total score

  unlockedExperienceList.sort((a, b) => a.level.compareTo(b.level));

  dailyContributionsList.add(DailyContributions(
    name: 'Haseeb',
    imageUrl: 'https://th.bing.com/th/id/R.2b6a9e7fb7e8a5b1aeb2ff45e1f24cd3?rik=ZK7fVKZXbP4rjA&pid=ImgRaw&r=0',
    moneyContributed: 100,
  ));

  dailyContributionsList.add(DailyContributions(
    name: 'Haseeb',
    imageUrl: 'https://th.bing.com/th/id/R.2b6a9e7fb7e8a5b1aeb2ff45e1f24cd3?rik=ZK7fVKZXbP4rjA&pid=ImgRaw&r=0',
    moneyContributed: 312,
  ));

  for (int i = 2; i < 10; i++) {
    dailyContributionsList.add(DailyContributions());
  }

  //sort the daily contributions list in descending order base on the money contributed

  dailyContributionsList.sort((a, b) => b.moneyContributed.compareTo(a.moneyContributed));
}
