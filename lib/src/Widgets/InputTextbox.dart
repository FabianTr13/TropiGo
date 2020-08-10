import 'package:flutter/material.dart';

class InputTextFiel extends StatefulWidget {
  final String hintText;
  final String title;
  final bool obscureText;
  final TextInputType keyboardType;

  const InputTextFiel({
    Key key,
    @required this.title,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _InputTextFielState createState() => _InputTextFielState();
}

class _InputTextFielState extends State<InputTextFiel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.redAccent, width: 0.5, style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              keyboardType: widget.keyboardType,
              style: TextStyle(fontSize: 20),
              obscureText: widget.obscureText,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.title,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
