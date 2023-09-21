// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

//create a basic page with scaffold and a center widget

/*Uniform UI for the gameplay: 
The UI for the gameplay is should be  simple. For now we are gonna just integrate the basic ui where both the players will be able to see their names profile images, and their current scores all inside rounded-cornered containers. Circular avatars will also have a border composed of the circular progress indicator. The circular progress indicator will update its value starting from filled to empty. Something like this:
// Define a variable to hold the timer value
int _timerValue = 20;

// Define a function to update the timer value every second
void _startTimer() {
  Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      if (_timerValue > 0) {
        _timerValue--; // Decrease the timer value every second
      } else {
        timer.cancel(); // Stop the timer when it reaches zero
      }
    });
  });
}

// Wrap the CircularProgressIndicator with a SizedBox to set its size
SizedBox(
  width: 50,
  height: 50,
  child: CircularProgressIndicator(
    value: 1-(_timerValue / 20), // Set the value of the CircularProgressIndicator based on the timer value
  ),
);

// Call _startTimer function to start the timer
_startTimer();
 
 */

class PlayWithAi extends StatelessWidget {
  const PlayWithAi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leve: 1')),
      body: Center(
        child: Column(
          children: [PlayersBox()],
        ),
      ),
    );
  }
}

class PlayersBox extends StatefulWidget {
  const PlayersBox({
    super.key,
  });

  @override
  State<PlayersBox> createState() => _PlayersBoxState();
}

class _PlayersBoxState extends State<PlayersBox> {
//creating the timer

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //container for player 1

        Container(
          height: 85,
          width: 170,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Player 1',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Score: 234',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/R.24177f35eb1f98e7052571ff4285cf95?rik=wKI6fOqop2TWGg&pid=ImgRaw&r=0'),
                    ),

                    //circular progress indicator
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressDemo(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        //container for player 2

        Container(
          height: 85,
          width: 170,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/R.24177f35eb1f98e7052571ff4285cf95?rik=wKI6fOqop2TWGg&pid=ImgRaw&r=0'),
                    ),

                    //circular progress indicator
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressDemo(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Player 1',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Score: 234',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularProgressDemo extends StatefulWidget {
  @override
  _CircularProgressDemoState createState() => _CircularProgressDemoState();
}

class _CircularProgressDemoState extends State<CircularProgressDemo> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20), // Set the duration to 20 seconds
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CircularProgressIndicator(
          value: _animation.value,
          strokeWidth: 4.0,
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
      },
    );
  }
}
