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
              'Thank you for booking ! Click on the booking to see all the details of your booking. Please have patience as it might take some time to update the prices. Once prices are updated you can click on \'Confirm\'  beside the bidding price to confirm your booking. Thank you for using Yatayat !'
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
