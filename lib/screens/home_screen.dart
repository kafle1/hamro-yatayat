import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
import 'package:yatayat/constants.dart';
import 'package:yatayat/screens/create_booking_screen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();

    //Hide Status Bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

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
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
              boxShadow: [kBoxShadow],
            ),
            child: Carousel(
              images: [
                Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover,
                )
              ],
              dotSize: 6,
              dotSpacing: 15,
              indicatorBgPadding: 5,
              dotBgColor: Colors.transparent,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
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
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id)
                      },
                      lable: 'Bus',
                      booking: false,
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/Car.png',
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id)
                      },
                      lable: 'Car',
                      booking: false,
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/Taxi.png',
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id)
                      },
                      lable: 'Taxi',
                      booking: false,
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/Other.png',
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id)
                      },
                      lable: 'Other',
                      booking: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
