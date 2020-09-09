import 'package:flutter/material.dart';

class InputTextbox extends StatelessWidget {
  final String hintText;
  final String title;
  final bool obscureText;
  final bool autofocus;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final dynamic onChange;
  final Stream<String> stream;
  final Color colorLines;
  final int maxLines;
  final double fontSizeHint;
  final VoidCallback onTap;
  final bool allowEdit;

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
    this.nextFocus,
    this.colorLines = Colors.grey,
    this.maxLines = 1,
    this.fontSizeHint = 18,
    this.onTap,
    this.allowEdit = false,
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
                color: this.colorLines,
                width: 1,
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
                  textInputAction: TextInputAction.next,
                  maxLines: this.maxLines,
                  onChanged: onChange,
                  onTap: this.onTap,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(nextFocus);
                  },
                  readOnly: this.allowEdit,
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: autofocus,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontSize: 18,
                    color: this.colorLines,
                  ),
                  cursorColor: this.colorLines,
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: title,
                    errorText: snapshot.error,
                    errorStyle: TextStyle(
                      color: this.colorLines,
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: this.colorLines,
                      fontSize: this.fontSizeHint,
                    ),
                    labelStyle: TextStyle(
                      color: this.colorLines,
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
