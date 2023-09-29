/* Joining Handeling:
After the user submits the value in the 

we need to create a  Future<bool> join(int intCode) async {} function that will be executed as the user submits the code in the alertdialogue box. The following is the logic inside the join() function:
we first check if there exisits a document in the collection ‘WaitingDocs’ under the same uid as the intJoinCode entered by the joiner. If there exists such document then we are going to update the state of Bool isWaitingStatus  to false. This way the inviter will be notified that the joiner has joined the invitation and along with this we also need to upload the profile document of the joiner to the ‘Users’ collection.
The following is the structure of the joiner document:
Uid Of the Document: …
Bool isInviter = false;
String Name = ‘Name of the joiner’
String imageUrl = ‘Image is Uploaded and its url is stored in here’;
Int Score = 0;

After the successful creation of the document we will return true. Otherwise in any case causing errors we will return false. These Boolean values are essential to display validCodeWidget or the invalidCodeWidget from the FutureBuilder.  The following details covers what the FutureBuilder in the join tab does:
In the join tab we are gonna use a Boolean variable named isJoinCodeSubmitted to show the future builder widget or not. Inside the future builder we have three different states. One is the waiting state, this is the state when the future has not been resolved yet. In this case we will display the ‘Loading’ widget. The other two states are possible after the future has resolved and it has either returned true or false. In case if true is returned by the future we will use the snapshot.data to display validCodeWidget or inValidCodeWidget in case if false is returned. 
The validCodeWidget is just a container with a row as its child which contains a tick icon and text ‘Code Correct! Lets Play’.
The inValidCodeWidget is also a similar widget with a cross icon and text ‘Can’t join your friend. Try again!’. 
The Loading widget is is a container with a column that has text ‘Validating’ and a LinearProgressIndicator as its children. 
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../main.dart';

Future<bool> join(int intCode) async {
  //we first check if there exisits a document in the collection ‘WaitingDocs’ under the same uid as the intJoinCode entered by the joiner. If there exists such document then we are going to update the state of Bool isWaitingStatus  to false. This way the inviter will be notified that the joiner has joined the invitation and along with this we also need to upload the profile document of the joiner to the ‘Users’ collection.
  //The following is the structure of the joiner document:
  //Uid Of the Document: …
  //Bool isInviter = false;
  //String Name = ‘Name of the joiner’
  //String imageUrl = ‘Image is Uploaded and its url is stored in here’;
  //Int Score = 0;

  if (await FirebaseFirestore.instance
      .collection('WaitingDocs')
      .doc(intCode.toString())
      .get()
      .then((value) => value.exists)) {
    //if the document exists then we will update the isWaitingStatus to false

    try {
      await FirebaseFirestore.instance.collection('WaitingDocs').doc(intCode.toString()).update({
        'isWaitingStatus': false,
      });
    } catch (error) {
      print('\nFailed to update the isWaitingStatus to false: $error\n');
      return false;
    }

    //now we will upload the profile document of the joiner to the ‘Users’ collection.
    try {
      //upload the imageFile to firebase storage if it is not null otherwise upload assets/profile.jpg and put its url in a string variable

      String? imageUrl;

      // Check if imageFile is null
      if (imageFile != null) {
        print('trying to upload imageFile');
        final ref = FirebaseStorage.instance.ref().child('user_profile_images').child(userUUID + '.jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
      } else {
        // If imageFile is null, upload the default image from assets
        print('trying to upload default');
        final ByteData data = await rootBundle.load('assets/images/profile.jpg');
        final List<int> bytes = data.buffer.asUint8List();

        final ref = FirebaseStorage.instance.ref().child('user_profile_images').child(userUUID + '.jpg');
        await ref.putData(bytes as Uint8List);
        imageUrl = await ref.getDownloadURL();
      }

      //now we will upload the profile document of the joiner to the ‘Users’ collection.
      await FirebaseFirestore.instance.collection('Users').doc(userUUID).set({
        'isInviter': false,
        'Name': userName,
        'imageUrl': imageUrl,
        'Score': 0,
      });
    } catch (error) {
      print('\nFailed to upload the profile document of the joiner to the ‘Users’ collection: $error\n');
      return false;
    }

    //if everything is successful then we will return true
    return true;
  } else {
    //if the document does not exist then we will return false
    return false;
  }
}
