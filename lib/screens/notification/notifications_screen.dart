import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/notificationList.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  static const String id = 'notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: YatayatDrawer(),
      bottomNavigationBar: YatayatBottomNavigation(
        index: 2,
      ),
      appBar: YatayatAppbar(
        height: 60,
        title: Text(
          'Notifications'.tr,
          style: kAppbarTitleStyle,
        ),
        actionIcon: Icons.delete_forever_rounded,
        onActionClick: () async {
          await Database(uid: _auth.currentUser!.uid).deleteNotification();
        },
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: NotificationList()),
    );
  }
}
