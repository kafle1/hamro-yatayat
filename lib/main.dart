import 'package:flutter/material.dart';
import 'package:yatayat/screens/booking_details.dart';
import 'package:yatayat/screens/home_screen.dart';
import 'package:yatayat/screens/my_bookings_screen.dart';
import 'package:yatayat/screens/profile_screen.dart';
import 'package:yatayat/screens/signin_screen.dart';
import 'package:yatayat/screens/splash_screen.dart';

void main() {
  runApp(Yatayat());
}

class Yatayat extends StatelessWidget {
  const Yatayat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Nunito'),
      home: SplashScreen(),
      initialRoute: ProfileScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SigninScreen.id: (context) => SigninScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        MyBookingScreen.id: (context) => MyBookingScreen(),
        BookingDetailsScreen.id: (context) => BookingDetailsScreen(),
        ProfileScreen.id: (context) => ProfileScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
