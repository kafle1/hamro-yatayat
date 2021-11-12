import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/booking/createBooking/create_booking_screen.dart';
import 'package:yatayat/screens/home/home_screen.dart';
import 'package:yatayat/screens/booking/myBookings/my_bookings_screen.dart';
import 'package:yatayat/screens/notification/notifications_screen.dart';

class YatayatBottomNavigation extends StatefulWidget {
  final int index;
  YatayatBottomNavigation({required this.index});
  @override
  State<YatayatBottomNavigation> createState() =>
      _YatayatBottomNavigationState();
}

class _YatayatBottomNavigationState extends State<YatayatBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    var _selectedIndex = widget.index;
    return Container(
      color: kThemeColor,
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconBottomBar(
                    icon: Icons.home_rounded,
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                        Navigator.popAndPushNamed(context, HomeScreen.id);
                      });
                    }),
                IconBottomBar(
                    icon: Icons.history_rounded,
                    selected: _selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                        Navigator.popAndPushNamed(context, MyBookingScreen.id);
                      });
                    }),
                IconBottomBar(
                    icon: Icons.notifications_rounded,
                    selected: _selectedIndex == 2,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                        Navigator.popAndPushNamed(context, Notifications.id);
                      });
                    }),
                IconBottomBar(
                    icon: Icons.directions_car_rounded,
                    selected: _selectedIndex == 3,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                        Navigator.pushNamed(context, CreateBookingScreen.id,
                            arguments: {'vehicle': '', 'icon': ''});
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  const IconBottomBar(
      {required this.icon,
      required this.selected,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: selected ? 30 : 25,
              color: selected ? Colors.white : Colors.grey[350],
            )),
      ],
    );
  }
}
