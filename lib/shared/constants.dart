import 'package:flutter/material.dart';

const kBoxShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25), offset: Offset(0, 2), blurRadius: 10);

const kThemeColor = Color(0xff0C3CFF);

const kBookingTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13);

const kAppbarTitleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

const kComponentTitleStyle =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

const kFormLabelStyle = TextStyle(fontSize: 15);

const kInputFieldDecoration = InputDecoration(
  hintText: 'Enter your placeholder',
  prefixStyle: TextStyle(fontSize: 13),
  hintStyle: TextStyle(fontSize: 13),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);
