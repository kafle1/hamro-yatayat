import 'package:flutter/material.dart';
import 'package:yatayat/components/vehicles.dart';
import 'package:yatayat/screens/booking/booking_success_screen.dart';
import 'package:yatayat/screens/bookingdetails/booking_details.dart';
import 'package:yatayat/screens/booking/createBooking/create_booking_screen.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:yatayat/screens/booking/myBookings/my_bookings_screen.dart';
import 'package:yatayat/screens/notification/notifications_screen.dart';
import 'package:yatayat/screens/auth/otp_verify_screen.dart';
import 'package:yatayat/screens/auth/phone_num_screen.dart';
import 'package:yatayat/screens/profile/profile_screen.dart';
import 'package:yatayat/screens/auth/signin_screen.dart';
import 'package:yatayat/screens/home/splash_screen.dart';

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
