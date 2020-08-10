import 'package:flutter/material.dart';

class ButtonLarge extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final VoidCallback callback;

  const ButtonLarge({
    Key key,
    this.text = "Boton",
    this.callback,
    this.color = Colors.white,
    this.backgroundColor = Colors.redAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      // alignment: Alignment.center,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              color: this.backgroundColor,
              onPressed: this.callback,
              child: Text(
                this.text,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: this.color, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
