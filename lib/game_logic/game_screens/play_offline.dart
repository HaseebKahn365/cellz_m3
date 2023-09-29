import 'package:flutter/material.dart';

class PlayWithAi extends StatelessWidget {
  const PlayWithAi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Play Offline')),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Play Offline'), ElevatedButton(onPressed: () {}, child: Text('data'))])),
    );
  }
}
