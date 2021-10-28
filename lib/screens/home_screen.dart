import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
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
      bottomNavigationBar: YatayatBottomNavigation(index: 0),
      appBar: YatayatAppbar(
        height: 65,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Yatayat',
              style: kAppbarTitleStyle,
            ),
            Text(
              'Hire any Vehicle',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      drawer: YatayatDrawer(),
      body: HomePage(),
    );
  }
}

//HomePage
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Expanded(
              child: Container(
                height: 147,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                  boxShadow: [kBoxShadow],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book Now',
                  style: kComponentTitleStyle,
                ),
                SizedBox(
                  height: 10,
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
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Bookings',
                  style: kComponentTitleStyle,
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
    );
  }
}
