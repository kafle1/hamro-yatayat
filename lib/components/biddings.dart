import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/snackbar.dart';
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
        .orderBy('amount', descending: true)
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
            return ListTile(
              leading: Text('$count.'),
              title: Text(
                "Rs. ${data['amount']}",
                style: kDetailsLableStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${data['remarks']}'),
              trailing: Icon(
                Icons.price_check_rounded,
                size: 32,
                color: Colors.green[900],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm Booking ?'.tr),
                    content: Text('Do you want to confirm this booking ?'.tr +
                        '\nPrice: Rs. ${data['amount']}'),
                    actions: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green[900]),
                        onPressed: () {
                          if (widget.userData['status'] == 'Pending') {
                            //Process this booking
                            Database(uid: currentUser!.uid)
                                .processBooking(
                                    bookingDocID: widget.docId,
                                    driverId: data['driverId'],
                                    price: data['amount'].toString(),
                                    bidId: document.id,
                                    bookingId:
                                        widget.userData['bookingId'].toString())
                                .then((value) => {
                                      Navigator.pop(context),
                                      ShowSnackBar().success(
                                          'Your booking is confirmed with final price of Rs.${data['amount']}. You will get more details via SMS',
                                          context)
                                    })
                                .catchError((err) => {
                                      ShowSnackBar().error(
                                          'Error while processing the booking !',
                                          context)
                                    });
                          } else {
                            Navigator.pop(context);
                            ShowSnackBar().info(
                                'Your booking status is ${widget.userData['status']} !',
                                context);
                          }
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Confirm'.tr,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red[900]),
                        onPressed: () {
                          if (widget.userData['status'] == 'Pending') {
                            //Process this booking
                            Database(uid: currentUser!.uid)
                                .cancelBooking(bookingDocID: widget.docId)
                                .then((value) => {
                                      Navigator.pop(context),
                                      ShowSnackBar().success(
                                          'Your booking is cancelled. ',
                                          context)
                                    })
                                .catchError((err) => {
                                      ShowSnackBar().error(
                                          'Error while cancelling the booking !',
                                          context)
                                    });
                          } else {
                            Navigator.pop(context);
                            ShowSnackBar().info(
                                'Your booking status is ${widget.userData['status']} !',
                                context);
                          }
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Cancel'.tr,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}