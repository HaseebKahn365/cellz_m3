// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//this is a page with tab views to invite a friend or join a friend

class PlayOrJoin extends StatelessWidget {
  const PlayOrJoin({Key? key}) : super(key: key);

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Invite a friend'),
                          ElevatedButton(
                              onPressed: () {
                                //create a code and share it with the friend
                              },
                              child: Text('Share')),
                        ],
                      ),
                      //join a friend tab
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Join a friend'),
                          ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String inputText;
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
                                          inputText = value;
                                            print(inputText);
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
                                            String inputText = '';
                                            int? inputNumber = int.tryParse(inputText);
                                            if (inputNumber != null && inputNumber.toString().length == 5) {
                                              // Do something with the inputNumber
                                              print(inputText);
                                              Navigator.of(context).pop();
                                            } else {
                                              // Show an error message
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
