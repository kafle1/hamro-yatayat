import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/models/create_booking_pdf.model.dart';
import 'package:yatayat/screens/booking/booking_price_check.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:get/get.dart';

class BookingDetailsScreen extends StatefulWidget {
  static const String id = 'bookingScreen';

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  late Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    //Get data passed from the previous screen
    dynamic docId = ModalRoute.of(context)!.settings.arguments as String;

    //Get details of current user
    final currentUser = _auth.currentUser;

//Collection reference
    CollectionReference bookingsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('bookings');

    return Scaffold(
      appBar: YatayatAppbar(
        height: 60,
        title: Text(
          'Booking Details'.tr,
          style: kAppbarTitleStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: bookingsCollection.doc(docId).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      data = snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Booking ID :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Vehicle ID :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Vehicle Type :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Pickup Location :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Destination Location :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'No. Of Trip :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Pickup Date :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Days of Booking :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Booking Type :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Phone Number :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Email :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Booking Date :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Booking Status :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Driver\'s Name :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Driver\'s Phone Number :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Vehicle Number :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Total Amount :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                  Text(
                                    'Payment Status :'.tr,
                                    style: kDetailsLableStyle,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    '#${data['bookingId']}',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['vehicleId'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['vehicleType'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['pickupLocation'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['destinationLocation'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['noOfTrips'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['pickupDate'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['noOfDays'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['isEmergency']
                                        ? 'Emergency'
                                        : 'Normal',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['phoneNumber'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['email'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['bookingDate'],
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['status'],
                                    style: kDetailsValueStyle,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data['driverName'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['driverNumber'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['vehicleNumber'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['amount'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                  Text(
                                    data['paymentStatus'] ?? '---',
                                    style: kDetailsValueStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          YatayatButton(
                              label: 'Check Total Price',
                              onClick: () {
                                Navigator.popAndPushNamed(
                                    context, BookingPrice.id,
                                    arguments: {'data': data, 'docId': docId});
                              }),
                          YatayatButton(
                              label: 'Download Details as PDF'.tr,
                              bgColor: Colors.black,
                              onClick: () async {
                                createPdf(data);
                              }),
                          YatayatButton(
                              label: 'Delete Booking',
                              bgColor: Colors.red[900],
                              onClick: () {
                                if (data['status'] == "Pending") {
                                  //Delete Booking
                                  Database(uid: currentUser.uid)
                                      .deleteBooking(bookingDocID: docId)
                                      .then((value) => Navigator.pop(context))
                                      .catchError((err) => {
                                            ShowSnackBar().error(
                                                'Error occured deleting the booking !',
                                                context)
                                          });
                                } else {
                                  ShowSnackBar().info(
                                      'Cannot delete this booking as it\'s status is ${data['status']!}',
                                      context);
                                }
                              }),
                        ],
                      );
                    }

                    return Text("Loading...");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
