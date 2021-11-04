import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class YatayatButton extends StatelessWidget {
  final String label;
  final void Function() onClick;

  YatayatButton({required this.label, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: kThemeColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [kBoxShadow],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
