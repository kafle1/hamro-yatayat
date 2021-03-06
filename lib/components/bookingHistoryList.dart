import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/buildSheet.dart';
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
        .where('status', isNotEqualTo: 'Cancelled')
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
                bookingId: document.id,
                vehicleType: data['vehicleType'] ?? '',
                date: data['bookingDate'] ?? '',
                icon: data['icon'] ?? '',
                status: data['status'] ?? '',
                onClick: () {
                  //Check if booking status is confirmed or not
                  if (data['status'] == 'Pending') {
                    //Open sliding up panel
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => BuildSheet(
                        data: data,
                        docId: document.id,
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, BookingDetailsScreen.id,
                        arguments: document.id);
                  }
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
