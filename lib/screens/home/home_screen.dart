import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/bookingHistoryList.dart';
import 'package:yatayat/components/my_booking_card.dart';
import 'package:yatayat/components/vehicle_card.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
import 'package:yatayat/lang/localization_service.dart';
import 'package:yatayat/screens/auth/signin_screen.dart';
import 'package:yatayat/screens/booking/book_driver.screen.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/booking/createBooking/create_booking_screen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String lng;

  void initState() {
    super.initState();

    lng = LocalizationService().getCurrentLang();
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
                    'Hamro Yatayat'.tr,
                    style: kAppbarTitleStyle,
                  ),
                  Text(
                    'Hire any Vehicle'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              actionIcon: Icons.translate_rounded,
              onActionClick: () {
                if (lng == 'English') {
                  setState(() {
                    lng = 'Nepali';
                    LocalizationService().changeLocale('Nepali');
                    NepaliUtils(Language.nepali);
                  });
                } else if (lng == 'Nepali') {
                  setState(() {
                    lng = 'English';
                    LocalizationService().changeLocale('English');
                    NepaliUtils(Language.english);
                  });
                }
              },
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
  @override
  void initState() {
    super.initState();
  }

  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Get details of current user
    final currentUser = _auth.currentUser;

    //add token to db

    if (GetStorage().read('token') == null) {
      final _firebaseMessaging = FirebaseMessaging.instance;
      _firebaseMessaging.getToken().then((value) async {
        FirebaseMessaging messaging = FirebaseMessaging.instance;

        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          print('User granted permission');
        } else if (settings.authorizationStatus ==
            AuthorizationStatus.provisional) {
          print('User granted provisional permission');
        } else {
          print('User declined or has not accepted permission');
        }
        await Database(uid: currentUser!.uid).createToken(token: '$value');
        GetStorage().write("token", '$value');
      });
    }

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
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [kBoxShadow],
            ),
            child: Database(uid: currentUser.uid).createCrousel(),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book Now'.tr,
                  style: kComponentTitleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: kThemeColor),
                    onPressed: () {
                      Navigator.pushNamed(context, CreateBookingScreen.id,
                          arguments: {'vehicle': '', 'icon': ''});
                    },
                    icon: Icon(Icons.directions_car),
                    label: Text(
                      'Hire a Vehicle'.tr,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: kThemeColor),
                    onPressed: () {
                      Navigator.pushNamed(context, BookDriver.id);
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                      'Hire a Driver'.tr,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
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
                  'My Bookings'.tr,
                  style: kComponentTitleStyle,
                ),
                SizedBox(
                  height: 15,
                ),
                BookingHistoryList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
