// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cellz_m3/game_logic/lists_of_objects.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebase_logic/invite.dart';
import '../../firebase_logic/join.dart';
import '../game_classes/unlocked_experience.dart';

//this is a page with tab views to invite a friend or join a friend

class PlayOrJoin extends StatefulWidget {
  const PlayOrJoin({Key? key}) : super(key: key);

  @override
  State<PlayOrJoin> createState() => _PlayOrJoinState();
}

var tempIntCode =
    0; //this is just the global version of the intCode variable for deleting the document in the WaitingDocs collection

class _PlayOrJoinState extends State<PlayOrJoin> {
  int selectedLevel = 2;
  //create a random integer from 0 to 9999
  int intCode = Random().nextInt(9999);

  String inputCode = '';

  int joinCode = 0;

  bool isCodeGenerated = false;
  bool isJoinCodeSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //tab view with two tabs to invite a friend or join a friend

          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: 'Invite',
                    ),
                    Tab(
                      text: 'Join',
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 300,
                  width: 320,
                  //make the corners rounded
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: TabBarView(
                    children: [
                      //invite a friend tab
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //We need to allow the inviter to select only the levels that he/she has unlocked using the class list of unlockedExperience. And we also want to be able to store the selected level in a variable so that it can be used as an int value for the joiner.
                          //create a dropdown menu for level selection and store the selected level in a variable
                          Text('Selected Level: $selectedLevel'),

                          (isCodeGenerated)
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Create a text widget to display the label for the dropdown menu
                                    Text(
                                      'Select a level:  ',
                                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                    ),

                                    // Create a dropdown menu for level selection
                                    DropdownButton<int>(
                                      value: selectedLevel, // The currently selected level
                                      // The dropdown menu icon
                                      iconSize: 20, // The size of the dropdown menu icon

                                      elevation: 16, // The elevation of the dropdown menu

                                      focusColor:
                                          Theme.of(context).colorScheme.primary, // The focus color of the dropdown menu
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).colorScheme.primary), // The style of the dropdown menu
                                      borderRadius: BorderRadius.circular(10), // The border radius of the dropdown menu
                                      isDense: true,
                                      onChanged: (int? newValue) {
                                        // The callback function that is called when the user selects a new value from the dropdown menu
                                        setState(() {
                                          if (unlockedExperienceList[newValue! - 1].isUnlocked == true &&
                                              newValue > 1) {
                                            selectedLevel =
                                                newValue; // Update the selected level variable with the new value
                                          }
                                        });
                                        print(selectedLevel); // Print the selected level to the console
                                      },
                                      items: unlockedExperienceList
                                          .map<DropdownMenuItem<int>>((UnlockedExperience unlockedExperience) {
                                        return DropdownMenuItem<int>(
                                          // Only the unlocked levels are displayed in the dropdown menu
                                          value: unlockedExperience.level,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0), // Adjust the padding as needed
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  unlockedExperience.level.toString(),
                                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                                ),
                                                (unlockedExperience.isUnlocked == false)
                                                    ? Icon(
                                                        FluentIcons.lock_closed_32_regular,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        size: 10,
                                                      )
                                                    : SizedBox(
                                                        width: 0,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: ElevatedButton(
                              onPressed: isCodeGenerated
                                  ? null
                                  : () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              //create a slow bounce in animation
                                              insetAnimationCurve: Curves.easeInOutCubic,
                                              insetAnimationDuration: Duration(milliseconds: 400),
                                              title: Text(
                                                'Share Link',
                                                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                              ),

                                              content: FutureBuilder(
                                                future: invite(intCode, selectedLevel),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    //the invite will return true or false after it is resolved. we will use the false value to show snakebar that says 'Sorry! Failed to generate code'
                                                    if (snapshot.data == true) {
                                                      //make sure to pop the context after 2 seconds and setState(() {
                                                      //   isCodeGenerated = true;
                                                      // });

                                                      Future.delayed(Duration(seconds: 2), () {
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          isCodeGenerated = true;
                                                        });
                                                      });

                                                      return CodeGenerated(
                                                        intCode: intCode,
                                                      );
                                                    }
                                                  }
                                                  if (snapshot.data == false) {
                                                    //pop the alert dialogue box
                                                    Navigator.of(context).pop();
                                                    // Show a Snackbar with an error message
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content:
                                                            Text('Sorry! Failed to generate code. Try again later'),
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  }
                                                  return WaitingSimulation();
                                                },
                                              ),
                                            );
                                          });
                                    },

                              //make sure to display 'Waiting' as label if the code is generated
                              child: isCodeGenerated
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Waiting...',
                                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: LinearProgressIndicator(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '(Ask your friend to enter $intCode in the join tab)',
                                          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Text('Invite Friend'),
                            ),
                          ),
                        ],
                      ),
                      //join a friend tab
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Join a friend'),

                          /* Joining Handeling:
After the user submits the value in the 

we need to create a  Future<bool> join(int intCode) async {} function that will be executed as the user submits the code in the alertdialogue box. The following is the logic inside the join() function:
we first check if there exisits a document in the collection ‘WaitingDocs’ under the same uid as the intJoinCode entered by the joiner. If there exists such document then we are going to update the state of Bool isWaitingStatus  to false. This way the inviter will be notified that the joiner has joined the invitation and along with this we also need to upload the profile document of the joiner to the ‘Users’ collection.
The following is the structure of the joiner document:
Uid Of the Document: …
Bool isInviter = false;
String Name = ‘Name of the joiner’
String imageUrl = ‘Image is Uploaded and its url is stored in here’;
Int Score = 0;

After the successful creation of the document we will return true. Otherwise in any case causing errors we will return false. These Boolean values are essential to display validCodeWidget or the invalidCodeWidget from the FutureBuilder.  The following details covers what the FutureBuilder in the join tab does:
In the join tab we are gonna use a Boolean variable named isJoinCodeSubmitted to show the future builder widget or not. Inside the future builder we have three different states. One is the waiting state, this is the state when the future has not been resolved yet. In this case we will display the ‘Loading’ widget. The other two states are possible after the future has resolved and it has either returned true or false. In case if true is returned by the future we will use the snapshot.data to display validCodeWidget or inValidCodeWidget in case if false is returned. 
The validCodeWidget is just a container with a row as its child which contains a tick icon and text ‘Code Correct! Lets Play’.
The inValidCodeWidget is also a similar widget with a cross icon and text ‘Can’t join your friend. Try again!’. 
The Loading widget is is a container with a column that has text ‘Validating’ and a LinearProgressIndicator as its children. 
 */
                          (isJoinCodeSubmitted)
                              ? FutureBuilder(
                                  //if the isJoinCodeSubmitted is true then we will display the future builder instead of the join button
                                  future: join(joinCode),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //if the future has returned true then we will display the validCodeWidget
                                      if (snapshot.data == true) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FluentIcons.checkmark_24_regular,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                Text(
                                                  'Code Correct! Lets Play',
                                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        );
                                      }
                                    }
                                    if (snapshot.data == false) {
                                      //if the future has returned false then we will display the inValidCodeWidget
                                      return Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FluentIcons.dismiss_24_regular,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                              Text(
                                                'Can\'t join your friend!',
                                                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                              ),
                                            ],
                                          ),
                                          //create an outline text button to try again which sets the isJoinCodeSubmitted to false

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                isJoinCodeSubmitted = false;
                                              });
                                            },
                                            child: Text(
                                              'Try again',
                                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    //if the future has not been resolved yet then we will display the loading widget
                                    return Container(
                                        child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Validating',
                                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        LinearProgressIndicator(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ));
                                  },
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          //create a slow bounce in animation
                                          insetAnimationCurve: Curves.easeInOutCubic,
                                          insetAnimationDuration: Duration(milliseconds: 400),

                                          title: Text(
                                            'Enter a 4-digit code\n',
                                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                          ),
                                          content: CupertinoTextField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 4,
                                            style:
                                                TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),
                                            onChanged: (value) {
                                              inputCode = value;
                                            },
                                          ),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('OK'),
                                              onPressed: () {
                                                int? inputNumber = int.tryParse(inputCode);
                                                if (inputNumber != null && inputNumber >= 0 && inputNumber <= 9999) {
                                                  //if the inviter tries to enter the same intCode that he generated then display a snakebar that says 'Sorry! You cannot join yourself'
                                                  if (inputNumber == intCode) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Sorry! You cannot join yourself'),
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  } else {
                                                    //if the inviter enters a valid code then navigate to the game screen
                                                    Navigator.of(context).pop();
                                                    joinCode = inputNumber;
                                                    setState(() {
                                                      isJoinCodeSubmitted = true;
                                                    });
                                                  }
                                                } else {
                                                  print('error in input');
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Join')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class WaitingSimulation extends StatelessWidget {
  const WaitingSimulation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        CupertinoActivityIndicator(
          radius: 20,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Generating code',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}

class CodeGenerated extends StatelessWidget {
  final int intCode;
  const CodeGenerated({
    required this.intCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Generated code:     ',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            Text(
              '${intCode}',
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Share this code with your friend',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        Text(
          '(Expires in 5 mins)',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}
