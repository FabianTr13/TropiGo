import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ButtonLargeSubmit extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final VoidCallback callback;
  final String nullText;
  final Stream<bool> stream;

  const ButtonLargeSubmit({
    Key key,
    this.text = "Boton",
    this.callback,
    this.color = Colors.white,
    this.backgroundColor = Colors.redAccent,
    this.stream,
    this.nullText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nullText() {
      showToast(
        this.nullText,
        position: StyledToastPosition.center,
        backgroundColor: Colors.red,
        animation: StyledToastAnimation.slideFromTop,
      );
    }

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                  color: this.backgroundColor,
                  disabledColor: this.backgroundColor,
                  onPressed: snapshot.hasData ? this.callback : _nullText,
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
