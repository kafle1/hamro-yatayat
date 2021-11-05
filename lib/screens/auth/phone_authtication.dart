import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/shared/loading.dart';

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
  //Initialize firebase auth
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';

  //Handle loading screen
  bool showLoading = false;

  void startLoading() {
    return setState(() {
      showLoading = true;
    });
  }

  void stopLoading() {
    return setState(() {
      showLoading = false;
    });
  }

  //Screen state
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  //Contoller for the phone number
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  //Snackbar
  dynamic showSnackBar(String? text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xffe74c3c),
        content: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  //Signin user with phone
  void signIn(PhoneAuthCredential phoneAuthCredential) async {
    startLoading();
    try {
      //Authenticate user
      await _auth.signInWithCredential(phoneAuthCredential);

      stopLoading();

      //Redirect to home screen
      Navigator.popAndPushNamed(context, HomeScreen.id);
    } on FirebaseAuthException catch (e) {
      stopLoading();

      //show snackbar
      showSnackBar(e.message);
    }
  }

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
              YatayatButton(
                  label: 'Get OTP',
                  onClick: () async {
                    //Show loading
                    startLoading();

                    //User entered phone number
                    String userNumber = '+977' + _phoneController.text;
                    //Verify user phone number with firebase phone auth
                    await _auth.verifyPhoneNumber(
                        phoneNumber: userNumber,
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                            stopLoading();
                          });
                        },
                        verificationCompleted: (phoneAuthCred) async {
                          stopLoading();
                        },
                        verificationFailed: (e) {
                          stopLoading();
                          //Show snack bar
                          showSnackBar(e.message);
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {});
                  }),
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
                      decoration:
                          kInputFieldDecoration.copyWith(hintText: '******'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              YatayatButton(
                  label: 'Verify & Proceed',
                  onClick: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: _otpController.text);

                    signIn(phoneAuthCredential);
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
        body: showLoading
            ? Loading()
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOTPFormWidget(context));
  }
}
