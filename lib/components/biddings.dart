import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';
import 'package:yatayat/screens/payment.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';

class GetBiddings extends StatefulWidget {
  final String docId;
  final Map userData;
  const GetBiddings(this.docId, this.userData);

  @override
  _GetBiddingsState createState() => _GetBiddingsState();
}

class _GetBiddingsState extends State<GetBiddings> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //Get details of current user
    final currentUser = _auth.currentUser;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('biddings')
        .where('bookingId', isEqualTo: widget.docId)
        .orderBy(
          'amount',
        )
        .limit(5)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }

        int count = 0;
        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            count++;
            return Column(
              children: [
                Material(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                  child: ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: Text('$count.'),
                    title: Text(
                      "Rs. ${data['amount']}",
                      style: kDetailsLableStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text(data['remarks'] == '' ? '---' : data['remarks']),
                    trailing: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green[900]),
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text('Confirm Booking ?'.tr),
                            content: Text(
                                'Do you want to confirm this booking ?'.tr +
                                    '\nPrice: Rs. ${data['amount']}'),
                            actions: [
                              //Confirm this booking

                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green[900],
                                ),
                                onPressed: () {
                                  //Process this booking
                                  Database(uid: currentUser!.uid)
                                      .processBooking(
                                          customerDocId: currentUser.uid,
                                          bookingDocID: widget.docId,
                                          driverId: data['driverId'],
                                          price: data['amount'].toString(),
                                          bidId: document.id,
                                          bookingId: widget
                                              .userData['bookingId']
                                              .toString())
                                      .then((value) async => {
                                            //Send confirm notification
                                            await Database
                                                .sendConfirmNotification(
                                                    id: data['driverId'],
                                                    bookingId: widget
                                                        .userData['bookingId']
                                                        .toString(),
                                                    bidId: document.id),

                                            Navigator.pop(context),
                                            showDialog(
                                                context: context,
                                                builder: (ctxt) => AlertDialog(
                                                      title: Text(
                                                          'Choose a Payment Method !'
                                                              .tr),
                                                      content: Text(
                                                          'Select payment method for this booking .'
                                                              .tr),
                                                      actions: [
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .green[900],
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(ctxt);
                                                            Navigator.pop(ctxt);
                                                            Navigator.pushNamed(
                                                                ctxt,
                                                                PaymentMethod
                                                                    .id);
                                                            ShowSnackBar().success(
                                                                'Your booking is confirmed with final price of Rs.${data['amount']}. Happy Journey !!',
                                                                ctxt);
                                                          },
                                                          child: Text(
                                                              'Pay Now'.tr,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                kThemeColor,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(ctxt);
                                                            Navigator.pop(ctxt);
                                                            Navigator.pushNamed(
                                                                ctxt,
                                                                BookingDetailsScreen
                                                                    .id,
                                                                arguments:
                                                                    widget
                                                                        .docId);
                                                            ShowSnackBar().success(
                                                                'Your booking is confirmed with final price of Rs.${data['amount']}. Happy Journey !!',
                                                                ctxt);
                                                          },
                                                          child: Text(
                                                            'Pay Later'.tr,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                barrierDismissible: false),
                                          })
                                      .catchError((err) => {
                                            Navigator.pop(context),
                                            ShowSnackBar().error(
                                                'Error while processing the booking !',
                                                context)
                                          });
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Confirm'.tr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),

                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red[900],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'No'.tr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
