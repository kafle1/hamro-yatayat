import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  int match = 0;
//Add new user to database
  Future<dynamic> addNewUser(
      {String? uid, String? name, String? email, String? phoneNumber}) async {
    try {
      if (phoneNumber == null) {
        final user =
            await usersCollection.doc(uid).set({'name': name, 'email': email});
        return user;
      } else {
        final user =
            await usersCollection.doc(uid).set({'phoneNumber': phoneNumber});
        return user;
      }
    } catch (e) {
      return e;
    }
  }
}
