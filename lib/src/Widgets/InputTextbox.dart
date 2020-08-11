import 'package:flutter/material.dart';

class InputTextbox extends StatelessWidget {
  final String hintText;
  final String title;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;

  const InputTextbox({
    Key key,
    @required this.title,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
  }) : super(key: key);
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
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              style: TextStyle(fontSize: 20),
              obscureText: obscureText,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: title,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
