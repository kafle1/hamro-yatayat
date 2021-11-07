import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/bookingHistoryList.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
import 'package:yatayat/shared/constants.dart';

class MyBookingScreen extends StatefulWidget {
  static const String id = 'MyBookingsScreen';
  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: YatayatDrawer(),
      bottomNavigationBar: YatayatBottomNavigation(
        index: 1,
      ),
      appBar: YatayatAppbar(
        height: 65,
        title: Text(
          'My Bookings',
          style: kAppbarTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BookingHistoryList()),
        ),
      ),
    );
  }
}
