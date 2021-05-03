import 'package:flutter/material.dart';

class ButtonIconCircle extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final VoidCallback callback;
  final String nullText;
  final IconData icon;

  const ButtonIconCircle(
      {Key key,
      this.callback,
      this.color = Colors.white,
      this.backgroundColor = Colors.red,
      this.nullText,
      this.icon = Icons.arrow_forward})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ClipOval(
      child: Material(
          color: this.backgroundColor,
          child: InkWell(
              splashColor: Colors.red,
              child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Icon(this.icon, color: Colors.white, size: 44)),
              onTap: this.callback)));
}
