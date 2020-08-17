import 'package:flutter/material.dart';

class InputTextbox extends StatelessWidget {
  final String hintText;
  final String title;
  final bool obscureText;
  final bool autofocus;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final dynamic onChange;
  final Stream<String> stream;

  const InputTextbox({
    Key key,
    @required this.title,
    this.hintText,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
    this.onChange,
    this.stream,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.redAccent,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  onChanged: onChange,
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: autofocus,
                  keyboardType: keyboardType,
                  style: TextStyle(fontSize: 18),
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: title,
                    errorText: snapshot.error,
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
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
