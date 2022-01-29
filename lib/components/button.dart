import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class YatayatButton extends StatelessWidget {
  final String label;
  final void Function() onClick;
  final Color? bgColor;

  YatayatButton({required this.label, required this.onClick, this.bgColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: bgColor != null ? bgColor : kThemeColor,
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
