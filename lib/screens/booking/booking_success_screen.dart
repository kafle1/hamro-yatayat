import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/home/home_screen.dart';

class BookingSuccess extends StatelessWidget {
  static const String id = 'bookingConfirm';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/book_confirm.png'),
              height: 300,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Your Booking has been successfully completed!',
              style: kComponentTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'We will be updating you with your booking from Email and Phone Message',
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            YatayatButton(
                label: 'Back to Home',
                onClick: () {
                  Navigator.popAndPushNamed(context, HomeScreen.id);
                })
          ],
        ),
      ),
    );
  }
}
