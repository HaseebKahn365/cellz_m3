import 'package:flutter/material.dart';

//create a basic page with scaffold and a center widget

class PlayWithAi extends StatelessWidget {
  const PlayWithAi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Play Offline'), ElevatedButton(onPressed: () {}, child: Text('data'))])),
    );
  }
}
