import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/screens/auth/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //Hide Status Bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    //Goto another screen after 3 sec
    new Future.delayed(const Duration(seconds: 3),
        () => Navigator.popAndPushNamed(context, SigninScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Yatayat',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              'HIRE ANY VEHICLE',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
