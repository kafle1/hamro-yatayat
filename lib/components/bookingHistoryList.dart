import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';

import 'my_booking_card.dart';

class BookingHistoryList extends StatefulWidget {
  @override
  _BookingHistoryListState createState() => _BookingHistoryListState();
}

class _BookingHistoryListState extends State<BookingHistoryList> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Get details of current user
    final currentUser = _auth.currentUser;

    //Getting stream of bookings from firebase
    final Stream<QuerySnapshot> _bookingStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('bookings')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _bookingStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return MyBookingCard(
                vehicleType: data['vehicleType'] ?? '',
                date: data['bookingDate'] ?? '',
                status: data['status'] ?? '',
                onClick: () {
                  Navigator.pushNamed(context, BookingDetailsScreen.id,
                      arguments: data);
                },
              );
            }).toList(),
          );
        } else {
          return Text("No data");
        }
      },
    );
  }
}
