import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/home/home_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneAuthentication extends StatefulWidget {
  static const String id = 'phoneAuth';
  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  final currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  //Contoller for the phone number
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  //Mobile enter form
  getMobileFormWidget(context) {
    return SingleChildScrollView(
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Enter Phone Number :',
                          style: kFormLabelStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _phoneController,
                      maxLength: 10,
                      onChanged: (value) {},
                      decoration: kInputFieldDecoration.copyWith(
                          hintText: '9800000000'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              YatayatButton(label: 'Get OTP', onClick: () {})
            ],
          ),
        ),
      ),
    );
  }

  //OTP Verification
  getOTPFormWidget(context) {
    return SingleChildScrollView(
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
                      controller: _otpController,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
            ? getMobileFormWidget(context)
            : getOTPFormWidget(context));
  }
}
