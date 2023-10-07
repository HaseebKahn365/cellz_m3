// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cellz_m3/game_logic/game_classes.dart';

import 'package:cellz_m3/game_logic/game_classes/unlocked_experience.dart';
import 'package:cellz_m3/main.dart';
import 'package:flutter/material.dart';

import '../../app_ui/point_ui.dart';
import '../global_functions/create_line_checkSq.dart';
import '../lists_of_objects.dart';

class GameStateVariables {
  int hisScore = 0;
  int myScore = 0;
  bool isMyTurn = true;
  String myName = userName;
  String hisName = 'Dynamic Ai';
  GameCanvas gameCanvas = GameCanvas(level: 0); //this is just for init

  GameStateVariables({required this.hisScore, required this.myScore, required this.isMyTurn}) {
    int level = gameLevelFinder();
    gameCanvas = GameCanvas(level: level);
    print(
        "the level is $level no of x points is ${gameCanvas.numOfXPoints} and no of y points is ${gameCanvas.numOfYPoints}");
  }

  int gameLevelFinder() {
    List<UnlockedExperience> allUnlockedExperiences =
        unlockedExperienceList.where((element) => element.isUnlocked == true).toList();
    int level = allUnlockedExperiences.length;
    return level;
  }

  //Working on P1C0P2
  // taking an instance of game canvas as a member

  //creating a method to reset the global lists of points, lines, after the game is over

  void resetGame() {
    allLines = [];
    allPoints = [];
    allUsedPoints = [];
  }
}

//creating an instance of the class

class PlayWithAi extends StatefulWidget {
  PlayWithAi({Key? key}) : super(key: key) {}

  @override
  State<PlayWithAi> createState() => _PlayWithAiState();
}

class _PlayWithAiState extends State<PlayWithAi> {
  //lets override the back button to make sure that user doesn't leave the game accidently

  var newLineOffset = List<Offset>.filled(3, Offset(0, 0));
  bool isLineCreated = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to exit the game and lose?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
                  ),
                ],
              ),
            )) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Level: ${gameStateVariables.gameCanvas.level.toString()}'),
          //in the actions we will display the moves left
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text('Moves Left :  '),
                  Text(
                    gameStateVariables.gameCanvas.calculateMovesLeft().toString(),
                    style: TextStyle(fontSize: 21),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              PlayersBox(),
              //creating a container with rounded borders that will contain the stack
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //its just a container with rounded borders and a little horizontal padding
                  height: 600,
                  width: 400,

                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Stack(
                    children: [
                      //the first widget of the stack is the gridview for the allPoints
                      Container(
                        height: 600,
                        color: Colors.red.withOpacity(0),
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          crossAxisCount: gameStateVariables.gameCanvas.numOfXPoints,
                          children: List.generate(allPoints.length, (index) {
                            return GridView.count(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              crossAxisCount: gameStateVariables.gameCanvas.numOfXPoints,
                              physics: NeverScrollableScrollPhysics(), // Disable scrolling
                              children: List.generate(allPoints.length, (index) {
                                return GestureDetector(
                                  onPanStart: (details) {
                                    setState(() {
                                      newLineOffset[0] = details.globalPosition;
                                      allPoints[index].isSelected = true;
                                      print('You started at point: ${allPoints[index]}');
                                    });
                                  },
                                  onPanUpdate: (details) {
                                    setState(() {
                                      newLineOffset[1] = details.globalPosition;
                                    });
                                  },
                                  onPanEnd: (details) {
                                    setState(() {
                                      // Check if the line drawn is valid or not.
                                      // The offsetAnalyzer function should return null for valid lines.
                                      if (offsetAnalyzer(
                                              newLineOffset[0], newLineOffset[1], allPoints[index] as Points) ==
                                          null) {
                                        print('Invalid Line');
                                        // Make the point unselected
                                        allPoints[index].isSelected = false;
                                      }
                                    });
                                  },
                                  child: PointUi(
                                    allPoints[index],
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayersBox extends StatefulWidget {
  const PlayersBox({
    super.key,
  });

  @override
  State<PlayersBox> createState() => _PlayersBoxState();
}

class _PlayersBoxState extends State<PlayersBox> {
//creating the state variables for the scores of the players

  @override
  Widget build(BuildContext context) {
    return PlayersDetail();
  }
}

class PlayersDetail extends StatelessWidget {
  const PlayersDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //container for User

        Container(
          height: 85,
          width: 170,
          decoration: BoxDecoration(
            //if the state variable isMyTurn is true then display the inversePrimary color otherwise display the onSurfaceVariant color
            color: gameStateVariables.isMyTurn
                ? Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2)
                : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //display only 9 characters of the name otherwise use overflowellipsis
                      gameStateVariables.myName.length > 9
                          ? gameStateVariables.myName.substring(0, 9) + '...'
                          : gameStateVariables.myName,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Score:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          gameStateVariables.myScore.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      //display current user profile image which is stored in imageFile variable if imageFIle is null then display the default profile image
                      backgroundImage: (imageFile == null)
                          ? AssetImage('assets/images/profile.jpg')
                          : Image.file(File(imageFile!.path)).image,
                    ),

                    //circular progress indicator
                    SizedBox(
                      width: 60,
                      height: 60,
                      //return the progressDemo only if it is the current user's turn otherwise return an empty container
                      child: gameStateVariables.isMyTurn ? CircularProgressDemo() : Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        //container for player 2

        Container(
          height: 85,
          width: 170,
          decoration: BoxDecoration(
            color: gameStateVariables.isMyTurn
                ? Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.05)
                : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/photos/beautiful-profile-picture-id182773387?k=6&m=182773387&s=612x612&w=0&h=kXCC5JaOAdOUE5iyd9F2YocAk2O3OEmj6scZs2-QtEk='),
                    ),

                    //circular progress indicator
                    //return the progressDemo only if it is the other user's turn otherwise return an empty container
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: gameStateVariables.isMyTurn ? Container() : CircularProgressDemo(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //display only 13 characters of the name otherwise use overflowellipsis
                      gameStateVariables.hisName.length > 10
                          ? gameStateVariables.hisName.substring(0, 10) + '...'
                          : gameStateVariables.hisName,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Score:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          gameStateVariables.hisScore.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularProgressDemo extends StatefulWidget {
  @override
  _CircularProgressDemoState createState() => _CircularProgressDemoState();
}

class _CircularProgressDemoState extends State<CircularProgressDemo> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20), // Set the duration to 20 seconds
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CircularProgressIndicator(
          value: _animation.value,
          strokeWidth: 4.0,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
      },
    );
  }
}
