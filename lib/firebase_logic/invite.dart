import 'package:cellz_m3/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  try {
    //upload the image to firebase storage

    await FirebaseFirestore.instance.collection('Users').doc(userUUID).set({
      'UidOfTheDocument': userUUID,
      'isInviter': true,
      'Name': FirebaseAuth.instance.currentUser?.displayName,
      'imageUrl': FirebaseAuth.instance.currentUser?.photoURL,
      'Score': 0,
    });

    print('user document created successfully');
  } catch (e) {
    print(e);
    return false;
  }

  //create a document in the collection ‘WaitingDocs’ only if there doesn't exist a document with the same intCode in the collection ‘WaitingDocs’.
  //the document will have the following fields:
  // Uid Of the Document: intCode
  // Int Level = SelectedLevel
  // Bool isWaitingStatus = true;
  // String inviterDocUid = ‘Uid Of the Document of the inviter’
  try {
    await FirebaseFirestore.instance.collection('WaitingDocs').doc(intCode.toString()).set({
      'Uid Of the Document': intCode,
      'Level': level,
      'isWaitingStatus': true,
      'inviterDocUid': FirebaseAuth.instance.currentUser?.uid,
    });
  } catch (e) {
    //if there is a document with the same intCode in the collection ‘WaitingDocs’ the
    print(e);
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).delete();
    return false;
  }
  return true;
}
