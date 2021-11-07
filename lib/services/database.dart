import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid;
  Database({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  int match = 0;
//Add new user to database
  Future<dynamic> addNewUser(
      {String? name, String? email, String? phoneNumber}) async {
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

  //Create a new booking
  Future<dynamic> createNewBooking(
      {String? name,
      String? vehicleType,
      String? pickupLocation,
      String? pickupDate,
      String? destinationLocation,
      String? noOfDays,
      String? noOfTrips,
      String? phoneNumber,
      String? email,
      bool? emergencyBooking}) async {
    try {
      print(uid);
      final newBooking =
          await usersCollection.doc(uid).collection('bookings').add({
        'name': name,
        'vehicleType': vehicleType,
        'pickupLocation': pickupLocation,
        'pickupDate': pickupDate,
        'destinationLocation': destinationLocation,
        'noOfDays': noOfDays,
        'noOfTrips': noOfTrips,
        'phoneNumber': phoneNumber,
        'email': email,
        'isEmergency': emergencyBooking
      });
      return newBooking;
    } catch (e) {
      throw e;
    }
  }
}
