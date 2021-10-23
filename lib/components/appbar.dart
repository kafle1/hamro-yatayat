import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';

class YatayatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  YatayatAppbar({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kThemeColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 25,
        ),
        onPressed: () => null,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            'Yatayat',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Hire any Vehicle',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.person,
            size: 25,
          ),
          onPressed: () => null,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
