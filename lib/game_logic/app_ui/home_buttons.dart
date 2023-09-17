// ignore_for_file: prefer_const_constructors

import 'package:cellz_m3/game_logic/game_screens/play_with_friend.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../game_screens/play_with_ai.dart';

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
              //make the height adjustable with the keyboard pops up

              transitionAnimationController: AnimationController(
                //make the animation accelerate curve
                vsync: Navigator.of(context),
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 250),
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              builder: (context) => Material(
                clipBehavior: Clip.antiAlias, // Add this line
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: PlayOrJoin(),
              ),
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
          onPressed: () {},
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
