//the daily contributions class contains data about the top contributors for the day. the contributor's name, his firebase storage image url, and his money contribution for the day is stored in this class

class DailyContributions {
  String name;
  String imageUrl;
  int moneyContributed;

  DailyContributions({this.name = 'No Contribution', this.imageUrl = '', this.moneyContributed = 0});

  void updateMoneyContributed(int newMoneyContributed) {
    moneyContributed += newMoneyContributed;
    // compare with the current highest contributor and update the list accordingly
    //compareContributions();
  }
}


//the following code uses sharedPreferences to save and load the theme data


