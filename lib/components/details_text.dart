import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class DetailsText extends StatelessWidget {
  final String lable;
  final String value;

  DetailsText({required this.lable, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          lable,
          style: TextStyle(
              fontSize: 15, color: kThemeColor, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
