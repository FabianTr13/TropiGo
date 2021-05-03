import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ButtonIconCircleSubmit extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final VoidCallback callback;
  final String nullText;
  final Stream<bool> stream;
  final IconData icon;

  const ButtonIconCircleSubmit(
      {Key key,
      this.callback,
      this.color = Colors.white,
      this.backgroundColor = Colors.red,
      this.stream,
      this.nullText,
      this.icon = Icons.arrow_forward})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nullText() {
      showToast(this.nullText, backgroundColor: Colors.red);
    }

    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) => ClipOval(
            child: Material(
                color: this.backgroundColor,
                child: InkWell(
                    splashColor: Colors.red,
                    child: SizedBox(
                        width: 66,
                        height: 66,
                        child: Icon(this.icon, color: Colors.white, size: 50)),
                    onTap: snapshot.hasData ? this.callback : _nullText))));
  }
}
