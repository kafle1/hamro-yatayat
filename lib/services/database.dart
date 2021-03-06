import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:nepali_date_picker/nepali_date_picker.dart';

class Database {
  String uid;
  Database({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Collection references
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');

  CollectionReference biddingCollection =
      FirebaseFirestore.instance.collection('biddings');
  final Stream<QuerySnapshot> _imagesStream =
      FirebaseFirestore.instance.collection('images').snapshots();

  int match = 0;
//Add new user to database
  Future<dynamic> addNewUser(
      {String? name, String? email, String? phoneNumber}) async {
    try {
      String title =
          'Welcome to Hamro Yatayat ! हाम्रो यातायातमा तपाइलाई स्वागत  छ !';
      String body =
          'Hamro Yatayat is a company established to provide rental service for all kinds of vehicles to its customers with best service possible. You can go to Create Booking page to create a new booking. To contact or learn more about us check out our facebook page @yatayathamro. Thank you for downloading Hamro Yatayat. \n \n हाम्रो यातायात आफ्ना ग्राहकहरूलाई भएसम्म सबै प्रकारका सवारी साधनहरू भाडामा लिने सेवा प्रदान गर्न स्थापना गरिएको कम्पनी हो। तपाईंले नयाँ बुकिङ सिर्जना गर्न \'Create Booking\' पेजमा जान सक्नुहुन्छ। सम्पर्क गर्न वा हाम्रो बारेमा थप जान्नको लागि हाम्रो फेसबुक पेज @yatayatnep हेर्नुहोस् । हाम्रो यातायात डाउनलोड गर्नुभएकोमा धन्यवाद । ';
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
          'timestamp': DateFormat('yyyy-MM-dd  kk:mm')
              .format(NepaliDateTime.now())
              .toString()
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
          'timestamp': DateFormat('yyyy-MM-dd  kk:mm')
              .format(NepaliDateTime.now())
              .toString()
        });
        return user;
      }
    } catch (e) {
      throw e;
    }
  }

  //Add this booking to available biddings
  static Future<String> addToAvailableBiddings(
      {required Map<String, dynamic> booking}) async {
    try {
      await FirebaseFirestore.instance
          .collection('availableBiddings')
          .doc(booking['id'])
          .set(booking);
      return 'Added to available bookings successfully';
    } catch (e) {
      return 'Error adding the booking to available biddings';
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
      Map<String, dynamic> details = {
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
        'bookingDate': DateFormat('yyyy-MM-dd  kk:mm')
            .format(NepaliDateTime.now())
            .toString()
      };
      //Save the details to firestore database
      final newBooking =
          await usersCollection.doc(uid).collection('bookings').add(details);
      details['id'] = newBooking.id;
      details['docId'] = uid;

      //Add to available bookings
      await addToAvailableBiddings(booking: details);
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
        'timestamp': DateFormat('yyyy-MM-dd  kk:mm')
            .format(NepaliDateTime.now())
            .toString()
      });
      return newNotification;
    } catch (e) {
      throw e;
    }
  }

  //Process the booking
  Future<String> processBooking(
      {required String bookingDocID,
      required String driverId,
      required String price,
      required String bidId,
      required String bookingId,
      required String customerDocId}) async {
    try {
      //Get driver details of this driver
      DocumentSnapshot driverData = await driverCollection.doc(driverId).get();
      dynamic data = driverData.data();

//Add 5% to pending amount of the driver
      await driverCollection.doc(driverId).set(
          {'pendingAmount': 5 / 100 * (double.parse(price) * 100 / 102.5)},
          SetOptions(merge: true));

      //Update the booking accordingly
      await usersCollection
          .doc(uid)
          .collection('bookings')
          .doc(bookingDocID)
          .update({
        'status': 'Confirmed',
        'driverName': data['driverName'],
        'driverNumber': data['driverNumber'],
        'vehicleNumber': data['vehicleNumber'],
        'vehicleId': driverId,
        'amount': price
      });
      await biddingCollection.doc(bidId).set({
        "bookingStatus": "Confirmed",
        'bookingNo': bookingId,
        'customerDocId': customerDocId
      }, SetOptions(merge: true));
      return 'Process Success';
    } catch (e) {
      throw e;
    }
  }

  //Send feedback message to the driver

  static Future sendMessage(
      {required String customerId,
      required String subject,
      required String messsage}) async {
    try {
      await FirebaseFirestore.instance.collection('messages').add(
          {'customerId': customerId, 'subject': subject, 'message': messsage});

      return 'Added New Feedback Successfully';
    } catch (e) {
      return e;
    }
  }

//Create Driver Booking
  static Future createDriverBooking(
      {required String name,
      required String number,
      required String address,
      required String bookingDays}) async {
    try {
      await FirebaseFirestore.instance.collection('driverBookings').add({
        'name': name,
        'number': number,
        'address': address,
        'bookingDays': bookingDays
      });

      return 'Added New Feedback Successfully';
    } catch (e) {
      return e;
    }
  }

  //Create a token in db
  Future createToken({required String token}) async {
    try {
      await FirebaseFirestore.instance
          .collection('tokens')
          .doc(uid)
          .set({'id': uid, 'token': token});
    } catch (e) {
      return e;
    }
  }

  //Send notification to the customer
  static Future sendConfirmNotification(
      {required String id,
      required String bookingId,
      required String bidId}) async {
    try {
      var info =
          await FirebaseFirestore.instance.collection('tokens').doc(id).get();
      Map<String, dynamic>? token = info.data();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAbFMLzsw:APA91bHfAEwznjJUX5mY31SlsA0UafLrKI_wdhWH1noQCRSddc_p1KmROT79UdVnf8XWM27-q9vddtTiQYWJ7VH71RgNoezGsNIXu7k8j0OrKWVPJgXl7hWzrFTeErYOZlG70T5BlnZ2 '
      };
      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
      request.body = json.encode({
        "registration_ids": [token!['token']],
        "notification": {
          "title": "बधाई छ, तपाईको गाडीको बुकिङ्ग कन्फर्म भएको छ !",
          "body":
              "तपाईले बुकिङ्ग (ID): $bookingId को लागि गरेको बिड ग्राहकद्वारा कन्फर्म गरिएको छ | तपाईको गाडीको बुकिङ्ग कन्फर्म भएकाले यस बुकिङ्गको सम्पूर्ण जानकारीकोलागी छिटो भन्दा छिटो एप हेर्नुहोला | सुभ यात्रा |",
          "sound": "default"
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        return response.reasonPhrase;
      }
    } catch (e) {
      return e;
    }
  }

  //Cancel the booking
  Future<String> cancelBooking({required String bookingDocID}) async {
    try {
      await usersCollection
          .doc(uid)
          .collection('bookings')
          .doc(bookingDocID)
          .update({
        'status': 'Cancelled',
      });

      return 'Cancel Success';
    } catch (e) {
      throw e;
    }
  }

  //Delete the booking
  Future<String> deleteBooking({required String bookingDocID}) async {
    try {
      await usersCollection
          .doc(uid)
          .collection('bookings')
          .doc(bookingDocID)
          .delete();

      return 'Cancel Success';
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
              fit: BoxFit.fill,
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

//Get Biddings
  static Future<List> getBiddings(String id) async {
    List biddings = [];

    await FirebaseFirestore.instance
        .collection('biddings')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['bookingId'] == id) {
          biddings.add(doc.data());
        }
      });
    }).catchError((err) {
      return err;
    });

    return biddings;
  }
}
