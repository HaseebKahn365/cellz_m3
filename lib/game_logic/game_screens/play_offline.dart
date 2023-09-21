import 'package:flutter/material.dart';

//create a basic page with scaffold and a center widget
/*Firebase architecture for online play with friends:

Now that we have the userInterface ready for the basic interaction with the app and adjusting the settings. We yet have to implement the ui for the gameplay but before that we have to integrate the connection with the firebase firestore. We need it for the players to send invitation and join to play game. This is gonna be done through the connection via an integer code. Here is a brief passage that explains what playing with friend looks like. 
Once the user1 clicks on the share button, it causes the creation of a document in the collection ‘Users’ for the user that just pressed the share button. The following shows what this document looks like:
Uid Of the Document: …
Bool isInviter = true;
String Name = ‘Name of the inviter’
String imageUrl = ‘Image is Uploaded and its url is stored in here’;
Int Score = 0;
 After the creation of the above document of the inviter, we need to create a document in the collection ‘WaitingDocs’. The waiting docs contains all the documents that are waiting for the joiner. A joiner has to enter the 4 digit code to identify the right waiting person or the invitor. Here is what the logic for creation of a document in the ‘WaitingDocs’ looks like. 
We first have to create a random number between 0 to 9999, we will call it intCode. Then we need to check if there exists a document in the ‘WaitingDocs’ collection with the same name as the intCode. If there exists such document, then we need to increment the intCode and check again. And we will keep on checking like this using a while look until we find an intCode for which there is no document with its name as its uid. After finding a unique intCode we need to create a document in the ‘WaitingDocs’ collection with the same name as the current intCode. Here is what the contents of this document looks like:
Uid Of the Document: intCode
Int Level = SelectedLevel
Bool isWaitingStatus = true;
String inviterDocUid = ‘Uid Of the Document of the inviter’
After the creation of the above document the inviter will now wait for the isWaitingStatus of the document to change. Once it changes this will cause the inviter to delete the invitation document. Inorder to free up the space on the ‘WaitingDocs’ thus reducing the chances for the randomly generate intCode to match the documents in the collection. Afterwards we look for a document under the name that matches the string: inviter’suid+intCode. But before deleting this invitation document, we need to the joiner to enter the proper code into the AlertDialogue box to join the game. The following lines are about what happens when the user submits the intCode.
We look for the documents in the WaitingDocs collection then see if the intCode matches if not, then the user is notified about the invalid join request otherwise if there does exist a document with the uid matching the intCode entered by the joiner, store its inviterDocUid in a variable and also the level, then we will update the isWaitingStatus of the invitation document to false. After this, on the joiner end, we create a document in the ‘GamePlayDocs’ collection in firestore which will be the main document where the actual game play between the players will happen. The following is the structure of the game play document:
Uid Of the Document: ‘inviterDocUid+intCode’
Int Level = storedLevel on joiner end
inviterRef = inviterDocUid
joinerRef = current uid of the joiner
Bool Turn = true(for the invitor’s turn) / false (for the  joiner’s turn)
String  Move= ‘34’ (these two values indicate the points of the line drawn in this case allPoints[3] and allPoints[4])
The above is just a representation of the fields. The initial values for the fields will be bool Turn = 0; and String Move = ‘’. After this both the joiner and inviter will look for updates in the game play document and so the game will be played between the two friends over the firebase firestore.

Uniform UI for the gameplay: 
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
      appBar: AppBar(title: const Text('Play Offline')),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Play Offline'), ElevatedButton(onPressed: () {}, child: Text('data'))])),
    );
  }
}
