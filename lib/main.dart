import 'package:flutter/material.dart';
import 'package:yatayat/screens/home_screen.dart';
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
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
