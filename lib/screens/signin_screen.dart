import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';
import 'package:yatayat/screens/phone_auth_screen.dart';

class SigninScreen extends StatelessWidget {
  static const String id = 'SigninScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Yatayat',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'Hire any vehicle',
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
                  Navigator.popAndPushNamed(context, PhoneAuthScreen.id);
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
                        'SIGN IN WITH PHONE',
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
                onTap: () {
                  //login using google
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
                        'SIGN IN WITH GOOGLE',
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
              'I agree all the terms and conditions',
              style: TextStyle(color: Color(0xffB7B3B3), fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
