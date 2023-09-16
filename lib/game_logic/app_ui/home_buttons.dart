import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

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
          onPressed: () {},
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
            primary: Theme.of(context).colorScheme.secondaryContainer,
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
          onPressed: () {},
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
            primary: Theme.of(context).colorScheme.secondaryContainer,
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
