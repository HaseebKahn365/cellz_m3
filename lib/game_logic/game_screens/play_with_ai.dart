// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cellz_m3/game_logic/game_classes/game_canvas.dart';
import 'package:cellz_m3/game_logic/game_classes/unlocked_experience.dart';
import 'package:cellz_m3/main.dart';
import 'package:flutter/material.dart';

import '../lists_of_objects.dart';

// P1C0P1:
// In this part we initialize the variables to set the level in the appbar to the selected level. In the scaffold we will have two profiles. The first one is of the current user and the second one is that of the aiFunction.

// We simply display the profile of the user and name for the first Player’s Container. But for the profile of ai we will randomly pick an image from list of URLs and names specified in the AiProfiles class.
// We will use state variables for the scores of the user as well as the controlling the Shifting colors of the container and for returning an animated circular container in case of the current players turn.

// we will also override the popping of the back button to make sure that the user really  wants to exit the game.

// P1C0P2:
// Point representation:
// There will be a canvasContainer in the middle that will contain a stack widget with its first widget of the stack being the gridview for the allPoints where each point has a gesture detector allowing the user to pan and create line.
// The point object has four Boolean control states. These states are as:
// isUntouched: This boolean member of the point will be used to make the point appear like an outlined circle thus indication that the point is not used yet.
// isSelected: This boolean member of the point will be used to make the point appear like a filled circle but its radius will be larger that the normal point.
// isMarked: This boolean member of the point will be used to make the point appear like a filled circle of normal radius.
// isDisabled: This boolean is used to indicate that whether or not the point is disabled. This member is not going to be used for any UI but it will be used to ignore the gesture detector the point that is disabled. A disabled point is a point that is present four times in the allUsedPoints list.
// Line  representation:
// The second widget of the stack will be a gridview for lines that will be used to return linear progress indicators for representing the lines. The new line which gets created will be animated using LinearProgressIndicator widget.
// Square  representation:
// The third widget of the stack will be a gridview for squares. To calculate the number of squares we will use the following algorithm: no. of squares = (no. of XPoints – 1) * (no. of YPoints – 1). The number of squares will be used  in the gridview for creating the number of squares.
// P1C0P3:
// This part of the game contains the createPoints function which is responsible for the creation of points UI. It works by returning a Container with a gesture detector for the gridview. The offset Analyzer is called after the drag detection by point. The offset Analyzer uses two offset objects to create the proper line. After the Line is created using the createLine method the checkSquare method is called for the detection of squares.
// P1C0P3:
// UpdateUI:
// This method is called to update the states variables and make the changes visible on the game canvas by calling the setState on the local variables so that the scores and widgets may update.
// SwtichTurn:
// This method is called after the update of the UI to switch the turn to the other player. This causes to make the gesture detector of the points for current users useless and unresponsive.
// createLine(aiFunction()):
// This is called after the player has already done his move. This causes the line to be created after the aiFunction returns the line.
// P1C1P1 to P1C1P4:
// This part of the game focuses on the development of the game play for the two users that will be connected via Firebase. The code for the players’ connection has already been implemented now we need to implement the state-management and data transfer via Firebase to both inviter and the joiner.
// Inviter-side Logic:
// P1C1P1:
// On the inviter side we will first initialize the local variables from the firestore’s game play document. After this we will delete the inviter’s document. Then after first move is done on the inviter’s side, we will do the work explained as follows:
// P1C1P2:
// We will then update the UI and encode the line in a string variable and update the string representing the line in the firestore.
// P1C1P3:
// we will switch the turn and inform the joiner using stream builder on the joiner’s side.
// Now on the inviter’s side we will listen for changes in the turn value of the firestore’s game play document using stream Builder and once it is the inviter’s turn the gesture detector will be enabled again.

// Joiner-side Logic:
// P1C1P4:
// On the joiner’s side we will decode the string representing the line and pass it to the createLine function. Thus, creating the line and also checking for the squares. After this the joiner will make his move and after creating the line, we will update the UI and encode the line in a string variable and update the string representing the line in the firestore. And so the game will be played
// P1C1P4:
// We will also calculate the created line and when the remaining moves are 0 we will display an Alert Dialogue box after navigating to the Home screen. This is not the only way to win. In case if the 20 seconds passes without the creation of any lines we will also do the same and return an AlertDialogue  box for losing the game.

// P1C2P1 to P1C2P2:
// The Play offline screen:
// On this screen, we will use most of the above logic with only the following two basic changes:
// P1C2P1:
// We will load the profile using the profile image in the assets folder and also give a name “AI”.
// P1C2P2:
// We will call the aiFunction for creating line with the isMediocre set to true. The game play is pretty similar to the aiFunction.

// P1C3P1 to P1C3P2:
// The Contributions Screen:
// P1C3P1:
// We will implement the google pay for the android version of the app and if the platform is Ios we will implement the apple pay. There will be three payment selection options of 1$ , 5$ and 10$.
// P1C3P2:
// After the payment  we will update the document in the firestore that contains the details of the contributions. However, the changes will be visible to the users who reopen the Cellz app. This is because the data for the Contributions screen is only downloaded in the init method of myApp widget.

// P1C4P1:
// The Journey and Patrios Screen:
// P1C3P1:
// Updating the data on the Journey and Patrios screen in done in the part of the development. We simply have to load the data from the following lists:
// List<UnlockedExperience> unlockedExperienceList = [];

//Working on P1C0P1
class GameStateVariables {
  int hisScore = 0;
  int myScore = 0;
  bool isMyTurn = true;
  String myName = userName;
  String hisName = 'Dynamic Ai';
  GameCanvas gameCanvas = GameCanvas(level: 1); //this is just for init

  GameStateVariables({required this.hisScore, required this.myScore, required this.isMyTurn}) {
    int level = gameLevelFinder();
    gameCanvas = GameCanvas(level: level);
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

dynamic gameStateVariables;
//creating an instance of the class

class PlayWithAi extends StatefulWidget {
  PlayWithAi({Key? key}) : super(key: key) {
    gameStateVariables = GameStateVariables(hisScore: 0, myScore: 0, isMyTurn: true);
  }

  @override
  State<PlayWithAi> createState() => _PlayWithAiState();
}

class _PlayWithAiState extends State<PlayWithAi> {
  //lets override the back button to make sure that user doesn't leave the game accidently
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
              //create a test button to swritch turns and increment the scores
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
