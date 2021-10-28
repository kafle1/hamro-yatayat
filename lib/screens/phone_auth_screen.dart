import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/input_field.dart';
import 'package:yatayat/constants.dart';
import 'package:yatayat/screens/otp_screen.dart';

class PhoneAuthScreen extends StatelessWidget {
  static const String id = 'phoneAuth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/phoneAuth.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'OTP Verification',
                style: kComponentTitleStyle.copyWith(fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We will send you an One Time Password on this mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kThemeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              InputField(
                  label: 'Enter Mobile Number',
                  placeholder: '+9779861212121',
                  onChange: (value) {}),
              YatayatButton(
                  label: 'Get OTP',
                  onClick: () {
                    Navigator.popAndPushNamed(context, OTPScreen.id);
                  })
            ],
          ),
        )),
      ),
    );
  }
}
