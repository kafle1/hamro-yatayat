import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(Yatayat());
}

class Yatayat extends StatefulWidget {
  @override
  State<Yatayat> createState() => _YatayatState();
}

class _YatayatState extends State<Yatayat> {
  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("ic_launcher");

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description, icon: 'ic_launcher'
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('notification clicked!');

      //Navigate to page
    });
  }

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
