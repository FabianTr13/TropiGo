import 'package:flutter/material.dart';

class ButtonLarge extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final VoidCallback callback;

  const ButtonLarge(
      {Key key,
      this.text = "Boton",
      this.callback,
      this.color = Colors.white,
      this.backgroundColor = Colors.redAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(children: <Widget>[
        Expanded(
            child: FlatButton(
                color: this.backgroundColor,
                disabledColor: this.backgroundColor,
                onPressed: this.callback,
                child: Text(this.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: this.color, fontWeight: FontWeight.bold))))
      ]));
}
