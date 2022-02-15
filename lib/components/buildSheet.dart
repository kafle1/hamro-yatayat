import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';
import 'package:yatayat/screens/booking/booking_price_check.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';

class BuildSheet extends StatefulWidget {
  final String docId;
  final Map data;
  const BuildSheet({Key? key, required this.docId, required this.data})
      : super(key: key);

  @override
  _BuildSheetState createState() => _BuildSheetState();
}

class _BuildSheetState extends State<BuildSheet> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //Get details of current user
    final currentUser = _auth.currentUser;
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          padding: EdgeInsets.all(10),
          child: ListView(
            controller: controller,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 140),
                height: 7,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                height: 15,
              ),
              BookingPrice(
                docId: widget.docId,
                userData: widget.data,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: kThemeColor),
                  onPressed: () {
                    Navigator.pushNamed(context, BookingDetailsScreen.id,
                        arguments: widget.docId);
                  },
                  icon: Icon(Icons.description),
                  label: Text(
                    'Booking Details',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (builder) => AlertDialog(
                        title: Text('Cancel Booking ? '),
                        content: Text(
                            'Are you sure you want to cancel this booking. You cant revert back once you cancel this booking !'),
                        actions: [
                          TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red[900],
                              ),
                              onPressed: () {
                                //Cancel this booking
                                Database(uid: currentUser!.uid)
                                    .cancelBooking(bookingDocID: widget.docId)
                                    .then((value) => {
                                          Navigator.pop(context),
                                          Navigator.pop(context),
                                          ShowSnackBar().success(
                                              'Your booking is cancelled. ',
                                              context),
                                        })
                                    .catchError((err) => {
                                          Navigator.pop(context),
                                          Navigator.pop(context),
                                          ShowSnackBar().success(
                                              'Error while canceling the booking',
                                              context),
                                        });
                              },
                              icon: Icon(Icons.cancel, color: Colors.white),
                              label: Text(
                                'Yes Cancel',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.cancel),
                  label: Text(
                    'Cancel Booking',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
