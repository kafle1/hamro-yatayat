import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/details_text.dart';
import 'package:yatayat/constants.dart';

class BookingDetailsScreen extends StatelessWidget {
  static const String id = 'bookingScreen';
  @override
  Widget build(BuildContext context) {
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
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            width: double.infinity,
            child: Align(
              child: Column(
                children: [
                  DetailsText(
                    lable: 'Name',
                    value: 'Niraj Kafle',
                  ),
                  DetailsText(
                    lable: 'Order ID',
                    value: '#44567',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
