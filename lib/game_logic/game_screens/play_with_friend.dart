// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cellz_m3/game_logic/lists_of_objects.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game_classes/unlocked_experience.dart';

//this is a page with tab views to invite a friend or join a friend

class PlayOrJoin extends StatefulWidget {
  const PlayOrJoin({Key? key}) : super(key: key);

  @override
  State<PlayOrJoin> createState() => _PlayOrJoinState();
}

class _PlayOrJoinState extends State<PlayOrJoin> {
  int selectedLevel = 2;
  //create a random integer from 0 to 9999
  int intCode = Random().nextInt(9999);
  String inputCode = '';

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

                          Row(
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
                                    color: Theme.of(context).colorScheme.primary), // The style of the dropdown menu
                                borderRadius: BorderRadius.circular(10), // The border radius of the dropdown menu
                                isDense: true,
                                onChanged: (int? newValue) {
                                  // The callback function that is called when the user selects a new value from the dropdown menu
                                  setState(() {
                                    if (unlockedExperienceList[newValue! - 1].isUnlocked == true && newValue > 1) {
                                      selectedLevel = newValue; // Update the selected level variable with the new value
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

                          ElevatedButton(
                              onPressed: () {
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
                                          future: Future.delayed(Duration(seconds: 2), () => 'data'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return CodeGenerated(
                                                intCode: intCode,
                                              );
                                            } else {
                                              return WaitingSimulation();
                                            }
                                          },
                                        ),
                                      );
                                    });
                              },
                              child: Text('Invite Friend')),
                        ],
                      ),
                      //join a friend tab
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Join a friend'),
                          ElevatedButton(
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
                                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),
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
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) => GameScreen(
                                                //       level: selectedLevel,
                                                //       isMultiplayer: true,
                                                //     ),
                                                //   ),); //to be implemented
                                              }
                                              Navigator.of(context).pop();
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
