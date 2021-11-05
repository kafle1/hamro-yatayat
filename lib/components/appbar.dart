import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';
import 'package:yatayat/screens/profile/profile_screen.dart';

class YatayatAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget title;
  final IconData? actionIcon;
  final IconButton? leadingIcon;
  final VoidCallback? onActionClick;

  YatayatAppbar(
      {required this.height,
      required this.title,
      this.actionIcon,
      this.leadingIcon,
      this.onActionClick});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kThemeColor,
      elevation: 0,
      leading: leadingIcon,
      title: title,
      actions: [
        IconButton(
            onPressed: onActionClick,
            icon: Icon(
              actionIcon,
              size: 25,
            )),
        IconButton(
          icon: Icon(
            Icons.person_rounded,
            size: 25,
          ),
          onPressed: () => {Navigator.pushNamed(context, ProfileScreen.id)},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
