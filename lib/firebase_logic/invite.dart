import 'dart:typed_data';

import 'package:cellz_m3/game_logic/game_screens/play_with_friend_BSDesign.dart';
import 'package:cellz_m3/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

//The invite function is a future which may return true or false or throw an error. the invite will recieve intCode and level as arguments.
//First the invite function creates a new document in the 'Users' Collection for the profile of the inviter. the document will have the following fields:

// Uid Of the Document= current user’s uid;
// Bool isInviter = true;
// String Name = ‘Name of the inviter’
// String imageUrl = ‘Image is Uploaded and its url is stored in here’;
// Int Score = 0;

//After the creation of the above document of the inviter, we need to create a document in the collection ‘WaitingDocs’ only if there doesn't exist a document with the same intCode in the collection ‘WaitingDocs’.
//The document in the collection ‘WaitingDocs’ will have the following fields:

// Uid Of the Document: intCode
// Int Level = SelectedLevel
// Bool isWaitingStatus = true;
// String inviterDocUid = ‘Uid Of the Document of the inviter’

// Now lets implement the invite function:

Future<bool> invite(int intCode, int level) async {
  //create a new document in the 'Users' Collection for the profile of the inviter
  //the document will have the following fields:
  // Uid Of the Document= current user’s uid;
  // Bool isInviter = true;
  // String Name = ‘Name of the inviter’
  // String imageUrl = ‘Image is Uploaded and its url is stored in here’;
  // Int Score = 0;

  //right now it is genrating multiple documents for the same user if the user presses the invite button multiple times
  //we are now going to use a global variable called userUUID

  //adding a safety layer by checking if there already exists a document in the waiitng docs collection with the same intCode. if there is a document with the same intCode in the collection ‘WaitingDocs’ then we will return false
  //this return value will be used to show a snackbar to the user that the invite failed

  if (await FirebaseFirestore.instance
      .collection('WaitingDocs')
      .doc(intCode.toString())
      .get()
      .then((value) => value.exists)) {
    return false;
  }

  //otherwise we will create a new document in the 'Users' Collection for the profile of the inviter
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

    await FirebaseFirestore.instance.collection('Users').doc(userUUID).set({
      'UidOfTheDocument': userUUID,
      'isInviter': true,
      'Name': FirebaseAuth.instance.currentUser?.displayName,
      'imageUrl': imageUrl,
      'Score': 0,
    });

    print('user document created successfully');
  } catch (e) {
    print(e);
    return false;
  }

  try {
    await FirebaseFirestore.instance.collection('WaitingDocs').doc(intCode.toString()).set({
      'Uid Of the Document': intCode,
      'Level': level,
      'isWaitingStatus': true,
      'inviterDocUid': FirebaseAuth.instance.currentUser?.uid,
      'createdAt': Timestamp.now(),
    });

    print('waiting document created successfully');
    //changing the tempIntCode to intCode so that if the user pops the bottomsheet then we would delete the document with the same intCode from the waitingDocs collection

    tempIntCode = intCode;
  } catch (e) {
    //if there is a document with the same intCode in the collection ‘WaitingDocs’ the
    print(e);
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).delete();
    return false; //this return value will be used to show a snackbar to the user that the invite failed
  }
  return true;
}
