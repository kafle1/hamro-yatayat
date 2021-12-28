import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/screens/auth/phone_authtication.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:yatayat/screens/offline.dart';
import 'package:yatayat/services/auth.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  static const String id = 'SigninScreen';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  bool loggedIn = false;
  //Check internet connection of the user
  bool? _isOnline;
  void checkConnection() async {
    Connectivity connectivity = Connectivity();
    var status = await connectivity.checkConnectivity();
    if (status == ConnectivityResult.none) {
      setState(() {
        _isOnline = false;
      });
    } else {
      setState(() {
        _isOnline = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
//Check if use is logged in or not
    if (_auth.currentUser != null) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }

    if (_isOnline == true) {
      return loggedIn
          ? HomeScreen()
          : Scaffold(
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Yatayat'.tr,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Hire any Vehicle'.tr,
                      style: TextStyle(
                          color: Color(0xffB7B3B3),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                      child: Image(
                        image: AssetImage('assets/images/signin.png'),
                        height: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, PhoneAuthentication.id);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: kThemeColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [kBoxShadow],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                'SIGN IN WITH PHONE'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () async {
                          //login using google

                          await MyAuthentication().signInWithGoogle();

                          await Database(uid: _auth.currentUser!.uid)
                              .addNewUser(
                            name: _auth.currentUser!.displayName,
                            email: _auth.currentUser!.email,
                            phoneNumber: _auth.currentUser!.phoneNumber,
                          );

                          Navigator.popAndPushNamed(context, HomeScreen.id);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [kBoxShadow],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                                color: kThemeColor,
                                size: 30,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                'SIGN IN WITH GOOGLE'.tr,
                                style: TextStyle(
                                    color: kThemeColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'I agree all the terms and conditions'.tr,
                      style: TextStyle(color: Color(0xffB7B3B3), fontSize: 12),
                    )
                  ],
                ),
              ),
            );
    } else {
      return Offline();
    }
  }
}
