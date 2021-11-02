import 'package:flutter/material.dart';
import 'package:yatayat/components/vehicles.dart';
import 'package:yatayat/screens/booking_details.dart';
import 'package:yatayat/screens/booking_success.dart';
import 'package:yatayat/screens/create_booking_screen.dart';
import 'package:yatayat/screens/home_screen.dart';
import 'package:yatayat/screens/my_bookings_screen.dart';
import 'package:yatayat/screens/notifications_screen.dart';
import 'package:yatayat/screens/otp_screen.dart';
import 'package:yatayat/screens/phone_auth_screen.dart';
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
      initialRoute: HomeScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SigninScreen.id: (context) => SigninScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        MyBookingScreen.id: (context) => MyBookingScreen(),
        BookingDetailsScreen.id: (context) => BookingDetailsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        CreateBookingScreen.id: (context) => CreateBookingScreen(),
        Vehicles.id: (context) => Vehicles(),
        Notifications.id: (context) => Notifications(),
        BookingSuccess.id: (context) => BookingSuccess(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        OTPScreen.id: (context) => OTPScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
