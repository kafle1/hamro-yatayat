import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';

class YatayatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget title;
  final IconData? actionIcon;
  final IconButton? leadingIcon;

  YatayatAppbar(
      {required this.height,
      required this.title,
      this.actionIcon,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kThemeColor,
      elevation: 0,
      leading: leadingIcon,
      title: title,
      actions: [
        IconButton(
            onPressed: () => null,
            icon: Icon(
              actionIcon,
              size: 25,
            )),
        IconButton(
          icon: Icon(
            Icons.person_rounded,
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
