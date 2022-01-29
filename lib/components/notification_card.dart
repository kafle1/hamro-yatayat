import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class NotificationCard extends StatelessWidget {
  final void Function()? onClick;
  final String title;
  final String body;

  NotificationCard({required this.title, required this.body, this.onClick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [kBoxShadow],
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: kThemeColor),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                body,
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }
}
