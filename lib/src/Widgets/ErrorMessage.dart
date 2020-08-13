import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  bool visible;

  ErrorMessage({
    this.errorMessage,
    this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Text(
        errorMessage,
        style: TextStyle(
          fontSize: 20,
          color: Colors.red[900],
          height: 1.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
