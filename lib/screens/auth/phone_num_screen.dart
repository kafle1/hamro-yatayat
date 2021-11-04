import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/input_field.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/auth/otp_verify_screen.dart';

class PhoneAuthScreen extends StatelessWidget {
  static const String id = 'phoneAuth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/phoneAuth.png'),
                  height: 300,
                ),
                Text(
                  'OTP Verification',
                  style: kComponentTitleStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
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
                SizedBox(
                  height: 20,
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
          ),
        ),
      ),
    );
  }
}
