import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final void Function(String) onChange;
  final String otherDetails;

  InputField(
      {required this.label,
      required this.placeholder,
      required this.onChange,
      this.otherDetails = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$label :',
                style: kFormLabelStyle,
              ),
              Text(
                otherDetails,
                style: TextStyle(fontSize: 12, color: Color(0xff7F8C8D)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              onChanged: onChange,
              decoration:
                  kInputFieldDecoration.copyWith(hintText: placeholder)),
        ],
      ),
    );
  }
}
