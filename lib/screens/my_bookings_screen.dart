import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/constants.dart';

class MyBookingScreen extends StatefulWidget {
  static const String id = 'MyBookingsScreen';
  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YatayatAppbar(
        height: 65,
        title: Text(
          'My Bookings',
          style: kAppbarTitleStyle,
        ),
        leadingIcon: Icons.chevron_left,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                MyBookingCard(
                  vehicleType: 'Bus',
                  date: '20th Nov, 2021',
                  status: 'Pending',
                ),
                MyBookingCard(
                    vehicleType: 'Car',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Taxi',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Taxi',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Taxi',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Taxi',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Taxi',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Taxi',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
                MyBookingCard(
                    vehicleType: 'Other',
                    date: '20th Nov, 2021',
                    status: 'Completed'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
