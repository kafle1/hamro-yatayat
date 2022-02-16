import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yatayat/components/drawer_list.dart';
import 'package:yatayat/components/snackbar.dart';
import 'package:yatayat/screens/booking/myBookings/my_bookings_screen.dart';
import 'package:yatayat/screens/feedback.dart';
import 'package:yatayat/screens/profile/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class YatayatDrawer extends StatefulWidget {
  @override
  _YatayatDrawerState createState() => _YatayatDrawerState();
}

class _YatayatDrawerState extends State<YatayatDrawer> {
//Terms and conditions url
  String url =
      'https://www.termsandconditionsgenerator.com/live.php?token=KZ5SrqJyovjZuWuLyEcbvRDWkMRQiBt7';

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
                  'https://i.ibb.co/qDv60Cw/logo.png',
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
            icon: Icons.message,
            title: 'Contact / Feedback',
            onClick: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, FeedbackContact.id)
            },
          ),
          DrawerListBuilder(
            icon: Icons.description_outlined,
            title: 'Terms and Conditions',
            onClick: () async => {
              Navigator.pop(context),
              if (!await launch(url)) throw 'Could not launch the url'
            },
          ),
          DrawerListBuilder(
            icon: Icons.person_outline_rounded,
            title: 'Contact Us',
            onClick: () => {
              Navigator.pop(context),
              ShowSnackBar().info(
                  'Ph No: 9829490671, 9861595869 \nFacebook: @yatayatnep',
                  context)
            },
          ),
          DrawerListBuilder(
            icon: Icons.share_outlined,
            title: 'Share App',
            onClick: () => {
              Navigator.pop(context),
              Share.share(
                  'If you need vehicle in rent then Hamro Yatayat is here for you. Download our app now and rent a vehicle of your choice. \nhttps://play.google.com/store/apps/details?id=com.hamroyatayat.customer',
                  subject: 'Hamro Yatayat, Hire any Vehicle')
            },
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
