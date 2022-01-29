import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/shared/loading.dart';
import 'package:get/get.dart';

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

  //Signin user with phone
  void signIn(PhoneAuthCredential phoneAuthCredential) async {
    startLoading();
    try {
      //Authenticate user
      await _auth.signInWithCredential(phoneAuthCredential);
      await Database(uid: _auth.currentUser!.uid).addNewUser(
        name: _auth.currentUser!.displayName,
        email: _auth.currentUser!.email,
        phoneNumber: _auth.currentUser!.phoneNumber,
      );
      stopLoading();

      //Redirect to home screen
      Navigator.popAndPushNamed(context, HomeScreen.id);
    } on FirebaseAuthException catch (e) {
      stopLoading();

      //show snackbar

      ShowSnackBar().error(e.message, context);
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
                'Phone Authentication'.tr,
                style: kComponentTitleStyle.copyWith(fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We will send you an One Time Password on this mobile number'
                    .tr,
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
                          'Enter your phone number'.tr,
                          style: kFormLabelStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(fontSize: 13),
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
                  label: 'Get OTP'.tr,
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
                          ShowSnackBar().error(e.message, context);
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
              Text(
                'OTP Verification'.tr,
                style: kComponentTitleStyle.copyWith(fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter the otp sent to :'.tr + '+977${_phoneController.text}',
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
                          'Enter OTP :'.tr,
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
                  label: 'Verify & Proceed'.tr,
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
