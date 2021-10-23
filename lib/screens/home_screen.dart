import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YatayatAppbar(
        height: 65,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 147,
                  width: 361,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                    boxShadow: [kBoxShadow],
                  ),
                ),
              ),
            ),
            Container(
              width: 361,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book Now',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      VehicleCard(
                        iconPath: 'assets/images/icons/Bus.png',
                        onClick: () => {},
                        lable: 'Bus',
                        booking: false,
                      ),
                      VehicleCard(
                        iconPath: 'assets/images/icons/Car.png',
                        onClick: () => {},
                        lable: 'Car',
                        booking: false,
                      ),
                      VehicleCard(
                        iconPath: 'assets/images/icons/Taxi.png',
                        onClick: () => {},
                        lable: 'Taxi',
                        booking: false,
                      ),
                      VehicleCard(
                        iconPath: 'assets/images/icons/Other.png',
                        onClick: () => {},
                        lable: 'Other',
                        booking: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 361,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Bookings',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
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
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
