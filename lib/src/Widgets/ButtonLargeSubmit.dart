import 'package:flutter/material.dart';

class ButtonLargeSubmit extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final VoidCallback callback;
  final Stream<bool> stream;

  const ButtonLargeSubmit({
    Key key,
    this.text = "Boton",
    this.callback,
    this.color = Colors.white,
    this.backgroundColor = Colors.redAccent,
    this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          // alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                  color: this.backgroundColor,
                  disabledColor: this.backgroundColor,
                  onPressed: snapshot.hasData ? this.callback : null,
                  child: Text(
                    this.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: this.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
