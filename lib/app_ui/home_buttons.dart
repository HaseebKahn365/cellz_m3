// ignore_for_file: prefer_const_constructors

import 'package:cellz_m3/game_logic/game_screens/play_with_friend_BSDesign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../game_logic/game_screens/play_with_ai.dart';

List<String> tempLevels = ['Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5'];

List<Widget> buildHomeButtons(BuildContext context) {
  return [
    //create 3 elevated buttons using cards with a gesture detector each containing an icon on the left and text on the right
    SizedBox(
      height: 20,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: SizedBox(
        width: 115,
        //elevated button with leading icon
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayWithAi()));
          },
          icon: const Icon(
            FluentIcons.play_24_regular,
            size: 30,
          ),
          label: const Text(
            "Play",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          //create a button style with a background color and no elevation and greater size
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            elevation: 2,
            minimumSize: const Size(50, 50),
          ),
        ),
      ),
    ), //end of the play button

    //create the Play with friends button
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40),
      child: SizedBox(
        width: 115,
        //elevated button with leading icon
        child: ElevatedButton.icon(
          onPressed: () {
            // Display a bottom sheet to show the user the option to invite or joing a friend. this is done using a tab view inside the bottom sheet. the first tab is to invite a friend using a code generated and a share button and the second tab is to join a friend using a text field and a join button

            showModalBottomSheet(
              context: context,
              transitionAnimationController: AnimationController(
                vsync: Navigator.of(context),
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 250),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    // Place your code here to delete the invitation document

                    try {
                      await FirebaseFirestore.instance
                          .collection('waitingDocs')
                          .doc(tempIntCode.toString())
                          .delete()
                          .then((value) => print('deleted the document with intCode = $tempIntCode'));
                    } catch (error) {
                      print('\nFailed to delete the document with intCode = $tempIntCode: $error\n');
                    }

                    //show toast to show 'invite cancelled'
                    Fluttertoast.showToast(
                      msg: "Invite Dismissed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM_LEFT,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    // Return true to allow the bottom sheet to be popped
                    return true;
                  },
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    ),
                    child: PlayOrJoin(),
                  ),
                );
              },
            );
          },
          icon: const Icon(
            FluentIcons.person_32_regular,
            size: 30,
          ),
          label: const Text(
            "Play with friend",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          //create a button style with a background color and no elevation and greater size
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            elevation: 2,
            minimumSize: const Size(50, 50),
          ),
        ),
      ),
    ), //end of the play with friends button

    //create the play offline button

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: SizedBox(
        width: 115,
        //elevated button with leading icon
        child: ElevatedButton.icon(
          onPressed: () {
            //create a cupertino alert dialogue box that asked the user for the level using a dropdown menu and then navigate to the game screen
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String inputText;
                return CupertinoAlertDialog(
                  //create a slow bounce in animation
                  insetAnimationCurve: Curves.easeInOutCubic,
                  insetAnimationDuration: const Duration(milliseconds: 400),

                  title: Text(
                    'Enter a level\n',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  content: SizedBox(
                    height: 150,
                    child: CupertinoPicker(
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        inputText = tempLevels[value];
                        print(inputText);
                      },
                      children: tempLevels.map((e) => Text(e)).toList(),
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        //navigate to the game screen
                        Navigator.pop(context);
                      },
                      child: const Text('Play'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            FluentIcons.cloud_48_regular,
            size: 35,
          ),
          label: const Text(
            "Play offline",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          //create a button style with a background color and no elevation and greater size
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondaryContainer,
            elevation: 2,
            minimumSize: const Size(50, 50),
          ),
        ),
      ),
    ), //end of the play offline button
    SizedBox(
      height: 20,
    )
  ];
}
