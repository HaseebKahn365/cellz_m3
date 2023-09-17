// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
              const SizedBox(
                height: 30,
              ),
              //this is the top contributor
              //apply gradient to it from top left to bottom right
              Stack(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        //add elevation to the container

                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Theme.of(context).colorScheme.inversePrimary, Theme.of(context).colorScheme.primary],
                        )),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              //apply shader mask to the icon
                              child: ShaderMask(
                                shaderCallback: (rect) {
                                  return RadialGradient(
                                    center: Alignment.topLeft,
                                    radius: 1.0,
                                    colors: <Color>[surfaceTint.withOpacity(0.3), surfaceTint.withOpacity(0.5)],
                                    tileMode: TileMode.mirror,
                                  ).createShader(rect);
                                },
                                child: Icon(
                                  FluentIcons.checkmark_starburst_24_regular,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        const SizedBox(height: 10),
                        Text('Abdul Haseeb',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Contribution: 1000', style: TextStyle(color: Colors.white, fontSize: 15)),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  //creating a shadow from the bottom center top top center completely transparent
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 250,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 0.3],
                              colors: [shadowColor.withOpacity(0.3), shadowColor.withOpacity(0.0)])),
                    ),
                  ),
                ],
              ), //end of the top contributor
              //create a text button that says 'why should i contribute?'

              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Why should I contribute?'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    'Enjoying the game? 🎮 Want to support us?',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 150,
                                    child: SingleChildScrollView(
                                        child: Text(
                                      'I try my best to keep this game free without ads. Contributions from players like you help keep the game running smoothly and support further development. If you\'d like, you can make a small contribution to cover database costs and improve your gaming experience. Your support is greatly appreciated, but it\'s entirely optional! 🙌\nTop contributors are updated here daily 🎊',
                                      style: TextStyle(fontSize: 11),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'))
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Why should I contribute?',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),

              //create a row of three elevatedButtons.icon for the payment methods having 1$ , 5$ and 10$ as the text
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {}, icon: Icon(FluentIcons.wallet_credit_card_24_regular), label: Text('1\$')),
                  ElevatedButton.icon(
                      onPressed: () {}, icon: Icon(FluentIcons.wallet_credit_card_24_regular), label: Text('5\$')),
                  ElevatedButton.icon(
                      onPressed: () {}, icon: Icon(FluentIcons.wallet_credit_card_24_regular), label: Text('10\$')),
                ],
              ),

              //creating five simple cards using elevation
              const SizedBox(height: 30),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      child: ListTile(
                        leading: Text(
                          '${index + 2}',
                          style: TextStyle(fontSize: 13),
                        ),
                        title: Text('Name: Abdul Haseeb'),
                        subtitle: Text('Total contribution: 1000'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
