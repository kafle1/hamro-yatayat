import 'package:flutter/material.dart';
import 'package:yatayat/shared/constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final void Function(String) onChange;
  final String otherDetails;
  final String? value;
  final int? maxLength;
  final bool? enabled;
  final TextInputType? keyboard;
  final String? Function(String?)? validation;

  InputField(
      {required this.label,
      required this.placeholder,
      required this.onChange,
      this.value,
      this.maxLength,
      this.enabled,
      this.validation,
      this.keyboard,
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
          TextFormField(
              validator: validation,
              enabled: enabled,
              initialValue: value,
              maxLength: maxLength,
              onChanged: onChange,
              style: TextStyle(fontSize: 13),
              keyboardType: keyboard,
              decoration:
                  kInputFieldDecoration.copyWith(hintText: placeholder)),
        ],
      ),
    );
  }
}
