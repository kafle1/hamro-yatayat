import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/home/home_screen.dart';

class OTPScreen extends StatefulWidget {
  static const String id = 'otp';

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/otp.png'),
                  height: 300,
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
                  'Enter the otp sent to : +9779861212121',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kThemeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Enter OTP :',
                            style: kFormLabelStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        maxLength: 6,
                        onChanged: (value) {},
                        decoration:
                            kInputFieldDecoration.copyWith(hintText: '******'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                YatayatButton(
                    label: 'Verify & Proceed',
                    onClick: () {
                      Navigator.popAndPushNamed(context, HomeScreen.id);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
