import 'package:flutter/material.dart';

BoxDecoration boxGradient() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: const FractionalOffset(0, 1.8),
          end: const FractionalOffset(0, 0),
          colors: [Colors.yellowAccent, Colors.deepOrange],
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp));
}
