import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:yatayat/components/biddings.dart';
import 'package:yatayat/shared/constants.dart';

class BookingPrice extends StatefulWidget {
  static const String id = 'bookingPrice';
  final Map userData;
  final String docId;

  BookingPrice({required this.docId, required this.userData});

  @override
  _BookingPriceState createState() => _BookingPriceState();
}

class _BookingPriceState extends State<BookingPrice> {
  @override
  Widget build(BuildContext context) {
    //Get data passed from the previous screen

    Map userData = widget.userData;
    String docId = widget.docId;

    return Column(
      children: [
        Text(
          'Booking ID: ${userData['bookingId']}\n' +
              'Choose a prefered price to confirm your booking!'.tr,
          style: kBookingTextStyle.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
        GetBiddings(docId, userData),
        SizedBox(
          height: 20,
        ),
        Text(
          'If you do not see prices, please wait. Price of your booking will be shown once your booking is processed !!'
              .tr,
          style: TextStyle(
            color: Color(0xffB7B3B3),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
