import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  ErrorMessage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: TextStyle(
        fontSize: 20,
        color: Colors.red[900],
        height: 1.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
