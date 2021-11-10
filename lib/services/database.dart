import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Database {
  String uid;
  Database({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Collection references
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> _imagesStream =
      FirebaseFirestore.instance.collection('images').snapshots();

  int match = 0;
//Add new user to database
  Future<dynamic> addNewUser(
      {String? name, String? email, String? phoneNumber}) async {
    try {
      String title = 'Welcome to Yatayat ! यातायातमा तपाइलाई स्वागत  छ !';
      String body =
          'Yatayat is a company established to provide rental service for all kinds of vehicles to its customers with best service possible. You can go to Create Booking page to create a new booking. To contact or learn more about us check out our facebook page @yatayatnep or mail us to yatayatnep@gmail.com. Thank you for downloading Yatayat. \n \n यातायात आफ्ना ग्राहकहरूलाई भएसम्म सबै प्रकारका सवारी साधनहरू भाडामा लिने सेवा प्रदान गर्न स्थापना गरिएको कम्पनी हो। तपाईंले नयाँ बुकिङ सिर्जना गर्न \'Create Booking\' पेजमा जान सक्नुहुन्छ। सम्पर्क गर्न वा हाम्रो बारेमा थप जान्नको लागि हाम्रो फेसबुक पेज @yatayatnep हेर्नुहोस् वा हामीलाई yatayatnep@gmail.com मा मेल गर्नुहोस्। यातायात डाउनलोड गर्नुभएकोमा धन्यवाद । ';
      if (phoneNumber == null) {
        //create new user
        final user =
            await usersCollection.doc(uid).set({'name': name, 'email': email});
        //create new notification for the new user
        await usersCollection
            .doc(uid)
            .collection('notifications')
            .doc(uid)
            .set({
          'title': title,
          'body': body,
          'timestamp':
              DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.now()).toString()
        });
        return user;
      } else {
        final user =
            await usersCollection.doc(uid).set({'phoneNumber': phoneNumber});
        await usersCollection
            .doc(uid)
            .collection('notifications')
            .doc(uid)
            .set({
          'title': title,
          'body': body,
          'timestamp':
              DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.now()).toString()
        });
        return user;
      }
    } catch (e) {
      throw e;
    }
  }

  //Create a new booking
  Future<DocumentReference> createNewBooking(
      {String? name,
      String? vehicleType,
      String? pickupLocation,
      String? pickupDate,
      String? destinationLocation,
      String? noOfDays,
      String? noOfTrips,
      String? phoneNumber,
      String? email,
      String? icon,
      bool? emergencyBooking}) async {
    try {
      //Create a random order id
      Random random = new Random();

      //Save the details to firestore database
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
        'isEmergency': emergencyBooking,
        'status': 'Pending',
        'bookingId': random.nextInt(1000000),
        'paymentStatus': 'Pending',
        'icon': icon,
        'bookingDate':
            DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.now()).toString()
      });
      return newBooking;
    } catch (e) {
      throw e;
    }
  }

  //Create new notification
  Future<DocumentReference> createNotification(
      {required String title, required String body}) async {
    try {
      final newNotification =
          await usersCollection.doc(uid).collection('notifications').add({
        'title': title,
        'body': body,
        'timestamp':
            DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.now()).toString()
      });
      return newNotification;
    } catch (e) {
      throw e;
    }
  }

  //Delete Notifications
  Future<void> deleteNotification() async {
    try {
      return await usersCollection
          .doc(uid)
          .collection('notifications')
          .get()
          .then((snapshot) => {
                for (DocumentSnapshot ds in snapshot.docs)
                  {ds.reference.delete()}
              });
    } catch (e) {
      throw e;
    }
  }

  //Image Crousel
  StreamBuilder<QuerySnapshot<Object?>> createCrousel() {
    return StreamBuilder<QuerySnapshot>(
      stream: _imagesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        }

        return Carousel(
          images: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Image.network(
              data['url'],
              fit: BoxFit.cover,
            );
          }).toList(),
          dotSize: 5,
          dotSpacing: 15,
          indicatorBgPadding: 5,
          dotColor: Colors.white60,
          dotBgColor: Colors.transparent,
        );
      },
    );
  }
}
