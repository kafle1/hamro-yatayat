import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/components/input_field.dart';
import 'package:yatayat/screens/auth/signin_screen.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/shared/loading.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;

  //UserDetails
  String? name;

  //Show loading screen
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    //Get details of current user
    final currentUser = _auth.currentUser;

    return showLoading
        ? Loading()
        : Scaffold(
            appBar: YatayatAppbar(
              height: 60,
              title: Text(
                'Profile',
                style: kAppbarTitleStyle,
              ),
              actionIcon: Icons.logout_rounded,
              onActionClick: () async {
                await _auth.signOut();
                Navigator.popAndPushNamed(context, SigninScreen.id);
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    color: kThemeColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                            height: 65,
                            width: 65,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentUser!.displayName ?? 'New User',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              Text(
                                currentUser.email ?? 'newuser@yatayat.com',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Details',
                          style: kComponentTitleStyle,
                        ),
                        InputField(
                            label: 'Name',
                            placeholder: 'Enter your Name',
                            value: name ?? currentUser.displayName,
                            onChange: (newValue) {
                              name = newValue;
                            }),
                        InputField(
                            label: 'Email',
                            placeholder: 'Enter your Email',
                            value: currentUser.email != null
                                ? currentUser.email
                                : '',
                            enabled: false,
                            onChange: (neValue) {}),
                        InputField(
                            label: 'Phone Number',
                            placeholder: 'Enter your Phone Number',
                            value: currentUser.phoneNumber != null
                                ? currentUser.phoneNumber
                                : '',
                            enabled: false,
                            onChange: (neValue) {}),
                        YatayatButton(
                          label: 'Save',
                          onClick: () async {
                            if (name != null) {
                              setState(() {
                                showLoading = true;
                              });
                              await currentUser.updateDisplayName(name!);
                              setState(() {
                                showLoading = false;
                              });
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
