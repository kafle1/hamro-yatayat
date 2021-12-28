import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class Offline extends StatelessWidget {
  static const String id = 'Offline';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image(image: AssetImage('assets/images/noInternet.png')),
            Text(
              'Uhh Oh ! No Internet Connection',
              style: kComponentTitleStyle,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Please check your internet connection and try again.',
              style: kDetailsLableStyle,
            )
          ],
        ),
      ),
    );
  }
}
