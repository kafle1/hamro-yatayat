import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yatayat/shared/constants.dart';

class Loading extends StatelessWidget {
  static const String id = 'loading';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: kThemeColor,
                size: 50.0,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please wait...',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
