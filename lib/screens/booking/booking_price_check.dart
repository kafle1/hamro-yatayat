import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';

class BookingPrice extends StatefulWidget {
  static const String id = 'bookingPrice';

  @override
  _BookingPriceState createState() => _BookingPriceState();
}

class _BookingPriceState extends State<BookingPrice> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //Get data passed from the previous screen
    dynamic state = ModalRoute.of(context)!.settings.arguments as Map;
    Map userData = state['data'];
    String docId = state['docId'];
    //Get details of current user
    final currentUser = _auth.currentUser;

    return Scaffold(
      appBar: YatayatAppbar(
        height: 60,
        title: Text(
          'Total Booking Price'.tr,
          style: kAppbarTitleStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Text(
                'Booking ID: ${userData['bookingId']}',
                style: kDetailsLableStyle.copyWith(fontSize: 16),
              ),
              Text(
                'The Total Price is:',
                style: kDetailsLableStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${userData['price'] != null ? 'Rs. ' + userData['price'].toString() : '---'}',
                style: kComponentTitleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Price of your booking will be shown once your booking is processed!!',
                style: TextStyle(
                  color: Color(0xffB7B3B3),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              YatayatButton(
                label: 'I agree with this price, Confirm Booking',
                onClick: () {
                  if (userData['price'] != null &&
                      userData['status'] == 'Pending') {
                    //Process this booking
                    Database(uid: currentUser!.uid)
                        .processBooking(bookingDocID: docId)
                        .then((value) => Navigator.pop(context))
                        .catchError((err) => {
                              ShowSnackBar().error(
                                  'Error while processing the booking !',
                                  context)
                            });
                  } else if (userData['status'] == 'Pending') {
                    ShowSnackBar().info(
                        'Your booking price is not finalled yet, Please wait !',
                        context);
                  } else {
                    ShowSnackBar().info(
                        'Your booking status is ${userData['status']} !',
                        context);
                  }
                },
                bgColor: Colors.green[900],
              ),
              YatayatButton(
                label: 'I disagree with this price, Cancel Booking',
                onClick: () {
                  if (userData['price'] != null &&
                      userData['status'] == 'Pending') {
                    Database(uid: currentUser!.uid)
                        .cancelBooking(bookingDocID: docId)
                        .then((value) => Navigator.pop(context))
                        .catchError((err) => {
                              ShowSnackBar().error(
                                  'Error while cancelling the booking !',
                                  context)
                            });
                  } else if (userData['status'] == 'Pending') {
                    ShowSnackBar().info(
                        'Your booking price is not finalled yet, Please wait !',
                        context);
                  } else {
                    ShowSnackBar().info(
                        'Your booking status is ${userData['status']} !',
                        context);
                  }
                },
                bgColor: Colors.red[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
