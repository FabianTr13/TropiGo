import 'package:flutter/material.dart';

BoxDecoration BoxGradient() {
  return BoxDecoration(
    gradient: new LinearGradient(
      colors: [Colors.yellowAccent, Colors.deepOrange],
      begin: const FractionalOffset(0, 1.3),
      end: const FractionalOffset(0, 0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
    ),
  );
}
