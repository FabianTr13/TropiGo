import 'package:flutter/material.dart';

class ButtonRoundBorder extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final IconData icon;
  final VoidCallback callback;

  const ButtonRoundBorder({
    Key key,
    this.text = "Boton",
    this.callback,
    this.color = Colors.white,
    this.icon,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
      // alignment: Alignment.center,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  side: BorderSide(color: Colors.grey)),
              color: this.backgroundColor,
              onPressed: () => {this.callback()},
              child: Row(
                children: [
                  Icon(
                    this.icon,
                    color: Colors.white,
                    size: 35,
                  ),
                  Divider(
                    height: 60,
                  ),
                  Expanded(
                    child: Text(
                      this.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: this.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
