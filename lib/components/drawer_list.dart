import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';

class DrawerListBuilder extends StatelessWidget {
  final IconData? icon;
  final String title;
  final void Function()? onClick;

  DrawerListBuilder({required this.icon, required this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      onTap: onClick,
    );
  }
}

Widget buildHeader({
  required String image,
  required String name,
  required String email,
  required void Function()? onClick,
}) =>
    InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Image(
                image: AssetImage(image),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: kThemeColor,
                    fontSize: 13,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
