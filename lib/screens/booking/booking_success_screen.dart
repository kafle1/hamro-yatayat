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
            Spacer(),
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
              'We will be updating you with your booking from Phone Call or Phone Message. To get more information about your booking go to \'Notifications\' or  \'My Bookings\' Screen.',
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            YatayatButton(
                label: 'Back to Home',
                onClick: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, HomeScreen.id);
                })
          ],
        ),
      ),
    );
  }
}
