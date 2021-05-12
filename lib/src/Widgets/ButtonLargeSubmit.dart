import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ButtonLargeSubmit extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final VoidCallback callback;
  final String nullText;
  final Stream<bool> stream;
  final double height;
  final double width;

  const ButtonLargeSubmit(
      {Key key,
      this.text = "Boton",
      this.callback,
      this.color = Colors.white,
      this.backgroundColor = Colors.red,
      this.stream,
      this.nullText,
      this.width,
      this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nullText() {
      showToast(this.nullText,
          position: StyledToastPosition.center,
          backgroundColor: Colors.red,
          animation: StyledToastAnimation.slideFromTop);
    }

    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) => Container(
            width: width ?? MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            height: this.height,
            child: Row(children: [
              Expanded(
                  child: Container(
                      height: 50,
                      child: RaisedButton(
                          color: this.backgroundColor,
                          disabledColor: this.backgroundColor,
                          onPressed:
                              snapshot.hasData ? this.callback : _nullText,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Colors.white.withOpacity(0.5))),
                          child: Text(this.text,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: this.color, fontSize: 16)))))
            ])));
  }
}
