import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatayat/components/vehicles.dart';
import 'package:yatayat/lang/localization_service.dart';
import 'package:yatayat/screens/auth/phone_authtication.dart';
import 'package:yatayat/screens/booking/bookingDetails/booking_details_screen.dart';
import 'package:yatayat/screens/booking/booking_success_screen.dart';
import 'package:yatayat/screens/booking/createBooking/create_booking_screen.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:yatayat/screens/booking/myBookings/my_bookings_screen.dart';
import 'package:yatayat/screens/notification/notifications_screen.dart';
import 'package:yatayat/screens/profile/profile_screen.dart';
import 'package:yatayat/screens/auth/signin_screen.dart';
import 'package:yatayat/screens/home/splash_screen.dart';
import 'package:yatayat/shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(Yatayat());
}

class Yatayat extends StatefulWidget {
  @override
  State<Yatayat> createState() => _YatayatState();
}

class _YatayatState extends State<Yatayat> {
  @override
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Nunito'),
      home: SplashScreen(),
      initialRoute: SplashScreen.id,
      translations: LocalizationService(),
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale: Locale('en', 'US'),
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
        PhoneAuthentication.id: (context) => PhoneAuthentication(),
        Loading.id: (context) => Loading(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
