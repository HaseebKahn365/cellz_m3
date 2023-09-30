// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

/*
On the joiner side:
Now that we are able to validate the code entered by the joiner, we create a document in the ‘GamePlayDocs’ collection in firestore which will be the main document where the actual game play between the players will happen. The following is the structure of the game play document:
Uid Of the Document: ‘inviterDocUid+intCode’
Int Level = storedLevel on joiner end
inviterRef = inviterDocUid
joinerRef = current uid of the joiner
Bool Turn = true(for the invitor’s turn) / false (for the  joiner’s turn)
String  Move= ‘34’ (these two values indicate the points of the line drawn in this case allPoints[3] and allPoints[4])
The above is just a representation of the fields. The initial values for the fields will be bool Turn = 0; and String Move = ‘’. After creation of the above document, we download the invitation document from which we will find the uid of the inviter and use it as an argument in the GameplayScreenForInviter(String inviterUid) we set the isWaiting to false and immediately navigate to the GameplayScreenForInviter(inviterUid). On this screen we will simply display the a text ‘Connected with ${inviterName}’. 


On the inviter side:
on the inviter side we listen for any changes on the bottomSheet as soon as we observe a change in the bool isWaitingStatus, we will delete the invitation document and navigate to the GameplayScreenForInviter(String inviterUid
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../play_with_friend_BSDesign.dart';

class GameplayScreenForInviter extends StatefulWidget {
  final String? inviterUid;
  const GameplayScreenForInviter({
    Key? key,
    required this.inviterUid,
  }) : super(key: key);

  @override
  State<GameplayScreenForInviter> createState() => _GameplayScreenForInviterState();
}

class _GameplayScreenForInviterState extends State<GameplayScreenForInviter> {
  //we are going to delete the invitation document in the intiState of the gameplay screen
  @override
  void initState() {
    super.initState();
    //delete the invitation document
    // FirebaseFirestore.instance
    //     .collection('WaitingDocs')
    //     .doc(tempIntCode.toString())
    //     .delete()
    //     .then((value) => print('deleted the document with intCode = $tempIntCode because game has started'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leve: 1')),
      body: Center(
        child: Column(
          children: [
            PlayersBox(),
            const SizedBox(height: 20),
            Text('connected with: '),
          ],
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
    return Column(
      children: [
        PlayersDetail(),
        const SizedBox(height: 20),
        Text('connected with: '),
      ],
    );
  }
}

class PlayersDetail extends StatelessWidget {
  const PlayersDetail({
    super.key,
  });

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
