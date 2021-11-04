import 'package:flutter/material.dart';
import 'package:yatayat/components/appbar.dart';
import 'package:yatayat/components/notification_card.dart';
import 'package:yatayat/components/yatayatDrawer.dart';
import 'package:yatayat/components/yatayat_bottom_navigation.dart';
import 'package:yatayat/shared/constants.dart';

class Notifications extends StatefulWidget {
  static const String id = 'notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
          'Notifications',
          style: kAppbarTitleStyle,
        ),
        actionIcon: Icons.delete_forever_rounded,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            NotificationCard(
                body:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
                title: 'Your booking has been confirmed !'),
            NotificationCard(body: 'body', title: 'title')
          ],
        ),
      ),
    );
  }
}
