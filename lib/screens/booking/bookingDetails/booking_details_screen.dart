import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/shared/constants.dart';

class BookingDetailsScreen extends StatefulWidget {
  static const String id = 'bookingScreen';

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

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
          'Booking Details',
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
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Order ID :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Vehicle ID :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Vehicle Type :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Pickup Location :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Destination Location :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'No. Of Trip :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Pickup Date :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Days of Booking :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Booking Type :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Phone Number :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Email :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Status :',
                                style: kDetailsLableStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Driver\'s Name :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Driver\'s Phone Number :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Vehicle Number :',
                                style: kDetailsLableStyle,
                              ),
                              Text(
                                'Total Amount :',
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
                                '#${data['orderId']}',
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
                                data['isEmergency'] ? 'Emergency' : 'Normal',
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
                            ],
                          ),
                        ],
                      );
                    }

                    return Text("Loading...");
                  },
                ),
                YatayatButton(label: 'Download Details as PDF', onClick: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
