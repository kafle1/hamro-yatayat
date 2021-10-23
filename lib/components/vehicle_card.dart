import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';

class VehicleCard extends StatelessWidget {
  final String iconPath;
  final void Function()? onClick;
  final String lable;
  final bool booking;

  VehicleCard(
      {required this.iconPath,
      this.onClick,
      required this.lable,
      required this.booking});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(horizontal: booking ? 0 : 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(iconPath),
              height: 40,
              width: 40,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              lable,
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [booking ? BoxShadow() : kBoxShadow],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(booking ? 0 : 5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(booking ? 0 : 5),
            bottomRight: Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
