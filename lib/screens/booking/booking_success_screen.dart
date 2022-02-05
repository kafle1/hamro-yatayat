import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:get/get.dart';

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
              'Your Booking has been successfully completed!'.tr,
              style: kComponentTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please go to Booking Details section to check your booking\'s total price. It might take some time for the total price to appear as our drivers will be bidding their prices for your booking. So please have patience and keep checking the app. You can confirm this booking by choosing the price suitable for you after the bidding price is updated in your app.'
                  .tr,
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            YatayatButton(
                label: 'Back to Home'.tr,
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
