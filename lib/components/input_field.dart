import 'package:flutter/material.dart';
import 'package:yatayat/constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final void Function(String)? onChange;

  InputField(
      {required this.label, required this.placeholder, required this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label :',
            style: kFormLabelStyle,
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
