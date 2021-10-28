import 'package:flutter/material.dart';
import 'package:yatayat/components/drawer_list.dart';
import 'package:yatayat/screens/my_bookings_screen.dart';
import 'package:yatayat/screens/profile_screen.dart';

class YatayatDrawer extends StatefulWidget {
  @override
  _YatayatDrawerState createState() => _YatayatDrawerState();
}

class _YatayatDrawerState extends State<YatayatDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          buildHeader(
              image: 'assets/images/avatar.png',
              name: 'Niraj Kafle',
              email: 'kafleniraj@gmail.com',
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
            icon: Icons.history_rounded,
            title: 'My Boookings',
            onClick: () => selectedItem(context, 1),
          ),
          DrawerListBuilder(
            icon: Icons.help_outline_rounded,
            title: 'FAQs',
            onClick: () => selectedItem(context, 2),
          ),
          DrawerListBuilder(
            icon: Icons.description_outlined,
            title: 'Terms and Conditions',
            onClick: () => selectedItem(context, 3),
          ),
          DrawerListBuilder(
            icon: Icons.person_outline_rounded,
            title: 'Contact Us',
            onClick: () => selectedItem(context, 4),
          ),
          DrawerListBuilder(
            icon: Icons.share_outlined,
            title: 'Share App',
            onClick: () => selectedItem(context, 5),
          ),
          DrawerListBuilder(
            icon: Icons.logout_outlined,
            title: 'Logout',
            onClick: () => selectedItem(context, 5),
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
