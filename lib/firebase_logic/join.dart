/*On the joiner side:
Now that we are able to validate the code entered by the joiner and creating the document for the joiner in the collection of ‘Users’ and changing the state of isWaitingStatus to false, we will now download the essential data from the invitation document before deleting it.
We will store the inviter’s document uid in a String inviterDocUid and also store the Level in an Int Level. These values will be used in the main document for the game play, which is a document in the ‘GamePlayDocs’ collection.
Now we create a document in the ‘GamePlayDocs’ collection in firestore which will be the main document where the actual game play between the players will happen. The following is the structure of the game play document:
Uid Of the Document: ‘inviterDocUid+intCode’
Int Level = storedLevel on joiner end
inviterRef = inviterDocUid
joinerRef = current uid of the joiner
Bool Turn = true(for the invitor’s turn) / false (for the  joiner’s turn)
String  Move= ‘34’ (these two values indicate the points of the line drawn in this case allPoints[3] and allPoints[4])
The above is just a representation of the fields. The initial values for the fields will be bool Turn = 0; and String Move = ‘’. After creation of the above document, we will now delete the invitation document. 
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../main.dart';

Future<bool> join(int intCode) async {
  bool documentExists = await FirebaseFirestore.instance
      .collection('WaitingDocs')
      .doc(intCode.toString())
      .get()
      .then((value) => value.exists);

  if (documentExists) {
    // Update isWaitingStatus to false
    await FirebaseFirestore.instance.collection('WaitingDocs').doc(intCode.toString()).update({
      'isWaitingStatus': false,
    });

    // Upload the profile image if available or use the default image
    String? imageUrl;
    if (imageFile != null) {
      final ref = FirebaseStorage.instance.ref().child('user_profile_images').child(userUUID + '.jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
    } else {
      final ByteData data = await rootBundle.load('assets/images/profile.jpg');
      final List<int> bytes = data.buffer.asUint8List();
      final ref = FirebaseStorage.instance.ref().child('user_profile_images').child(userUUID + '.jpg');
      await ref.putData(bytes as Uint8List);
      imageUrl = await ref.getDownloadURL();
    }

    // Upload user document
    await FirebaseFirestore.instance.collection('Users').doc(userUUID).set({
      'isInviter': false,
      'Name': userName,
      'imageUrl': imageUrl,
      'Score': 0,
    });
    print('user document created successfully');

    // Fetch data from invitation document
    // String? inviterDocUid;
    // int? storedLevel;
    // final invitationDoc = await FirebaseFirestore.instance.collection('WaitingDocs').doc(intCode.toString()).get();

    // inviterDocUid = invitationDoc.data()!['inviterDocUid'];
    // storedLevel = invitationDoc.data()!['Level'];

    // print('inviterDocUid: $inviterDocUid and storedLevel: $storedLevel');

    // await FirebaseFirestore.instance.collection('GamePlayDocs').doc(inviterDocUid! + intCode.toString()).set({
    //   'Level': storedLevel,
    //   'inviterRef': inviterDocUid,
    //   'joinerRef': userUUID,
    //   'Turn': true,
    //   'Move': '',
    //   'intCode': intCode.toString(),
    // });
    // print('gameplay document created successfully');

    return true;

    //the following code seem to run repeatedly and cause problems so we will take care of the following things in the game screen itself

    // print('inviterDocUid: $inviterDocUid and storedLevel: $storedLevel');

    // // Create gameplay document
    // print('inviterDocUid: $inviterDocUid and storedLevel: $storedLevel');

    // // Delete the invitation document
    // await FirebaseFirestore.instance.collection('WaitingDocs').doc(intCode.toString()).delete();
    // print('invitation document deleted successfully');

    // //set the documentExists to false
    // documentExists = false;
    // print('setting documentExists to false');

    // return true;
  } else {
    return false;
  }
}
