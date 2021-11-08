import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
import 'package:yatayat/screens/auth/signin_screen.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/booking/createBooking/create_booking_screen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();

    //Show Status Bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    //Check if use is logged in or not
    if (_auth.currentUser != null) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }

    return loggedIn
        ? Scaffold(
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
          )
        : SigninScreen();
  }
}

//HomePage
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Get details of current user
    final currentUser = _auth.currentUser;

    //Getting stream of bookings from firebase
    final Stream<QuerySnapshot> _bookingStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('bookings')
        .orderBy('bookingDate', descending: true)
        .limit(4)
        .snapshots();

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
              dotSize: 5,
              dotSpacing: 15,
              indicatorBgPadding: 5,
              dotColor: Colors.white60,
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
                        Navigator.pushNamed(context, CreateBookingScreen.id,
                            arguments: 'Bus')
                      },
                      lable: 'Bus',
                      booking: false,
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/Car.png',
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id,
                            arguments: "Car")
                      },
                      lable: 'Car',
                      booking: false,
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/Taxi.png',
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id,
                            arguments: "Taxi")
                      },
                      lable: 'Taxi',
                      booking: false,
                    ),
                    VehicleCard(
                      iconPath: 'assets/images/icons/Other.png',
                      onClick: () => {
                        Navigator.pushNamed(context, CreateBookingScreen.id,
                            arguments: '')
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'My Bookings',
                  style: kComponentTitleStyle,
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _bookingStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return MyBookingCard(
                            vehicleType: data['vehicleType'] ?? '',
                            date: data['bookingDate'] ?? '',
                            status: data['status'] ?? '',
                            onClick: () {
                              Navigator.pushNamed(
                                  context, BookingDetailsScreen.id,
                                  arguments: document.id);
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return Text("No data");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
