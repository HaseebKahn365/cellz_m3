// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ElevationScreen extends StatelessWidget {
  const ElevationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color shadowColor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.primary;
    return Expanded(
      child: ListView(children: [
        /*
       •	The third screen on the navigation bar is the Patrios screen. This screen is for the donations for the app. Since I don’t want to implement ads in my game, the users who ae willing to donate for the app will be able to pay via this screen. This screen will load data from the firestore document which stores 5 of the latest donors. Here is what the UI looks like. At the center we will have a container which will display the image and the name of the top donor. Who is the top donor, it is the user that gives the most number of donations for today. And below this, we will have the other five donors that just made the most recent donations. 
        */
        //lets build the third screen. create an elevation card for the top donor and a list of elevation cards for the other five donors.

        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Level '),
                        )),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.play_arrow),
                      label: Text('Play'),
                    ),
                    const SizedBox(height: 10),
                    Text('High Score: 0'),
                    const SizedBox(height: 10),
                    Text('Total Score: 0'),
                    const SizedBox(height: 10),
                    Text('Experience: Low'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
