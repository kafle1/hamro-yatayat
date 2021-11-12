import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yatayat/components/drawer_list.dart';
import 'package:yatayat/screens/booking/myBookings/my_bookings_screen.dart';
import 'package:yatayat/screens/profile/profile_screen.dart';

class YatayatDrawer extends StatefulWidget {
  @override
  _YatayatDrawerState createState() => _YatayatDrawerState();
}

class _YatayatDrawerState extends State<YatayatDrawer> {
  //Initialize firebase auth
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          buildHeader(
              image: _auth.currentUser!.photoURL ??
                  'https://i.ibb.co/4W0rPzP/logo.png',
              name: _auth.currentUser!.displayName ?? 'New User',
              email: _auth.currentUser!.email ?? 'newuser@yatayat.com',
              onClick: () =>
                  {Navigator.popAndPushNamed(context, ProfileScreen.id)}),
          SizedBox(
            height: 16,
          ),
          DrawerListBuilder(
            icon: Icons.home_outlined,
            title: 'Home',
            onClick: () => selectedItem(context, 0),
          ),
          DrawerListBuilder(
            icon: Icons.help_outline_rounded,
            title: 'FAQs',
            onClick: () => selectedItem(context, 0),
          ),
          DrawerListBuilder(
            icon: Icons.description_outlined,
            title: 'Terms and Conditions',
            onClick: () => selectedItem(context, 0),
          ),
          DrawerListBuilder(
            icon: Icons.person_outline_rounded,
            title: 'Contact Us',
            onClick: () => selectedItem(context, 0),
          ),
          DrawerListBuilder(
            icon: Icons.share_outlined,
            title: 'Share App',
            onClick: () => selectedItem(context, 0),
          ),
          DrawerListBuilder(
            icon: Icons.logout_outlined,
            title: 'Logout',
            onClick: () async {
              await _auth.signOut();
              Navigator.pop(context);
              Navigator.pop(context);
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      break;
    case 1:
      Navigator.popAndPushNamed(context, MyBookingScreen.id);
      break;
    case 2:
      Navigator.popAndPushNamed(context, MyBookingScreen.id);
      break;
    case 3:
      Navigator.popAndPushNamed(context, MyBookingScreen.id);
      break;
    case 4:
      Navigator.popAndPushNamed(context, MyBookingScreen.id);
      break;
    case 5:
      Navigator.popAndPushNamed(context, MyBookingScreen.id);
      break;
    default:
  }
}
