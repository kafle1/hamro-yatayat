import 'package:flutter/material.dart';

class ShowSnackBar {
  //error snackbar
  dynamic error(String? text, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xffe74c3c),
        content: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

//Success
  dynamic success(String? text, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[900],
        content: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

//Info
  dynamic info(String? text, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff2980b9),
        content: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
