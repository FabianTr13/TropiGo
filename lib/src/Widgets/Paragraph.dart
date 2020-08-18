import 'package:flutter/material.dart';

Widget Paragraph(String text, double size) {
  return Container(
    margin: EdgeInsets.only(
      top: 25,
      left: 20,
      right: 20,
    ),
    child: Text(
      text ?? "",
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
