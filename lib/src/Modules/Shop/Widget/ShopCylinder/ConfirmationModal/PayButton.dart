import 'package:flutter/material.dart';

class PayButton extends StatelessWidget {
  final bool isSelect;
  final String text;
  final String img;

  const PayButton({
    Key key,
    this.isSelect,
    this.text,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      child: Card(
          color: !this.isSelect ? Colors.white : Colors.red.withAlpha(60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: Colors.orange,
          child: FlatButton(
              onPressed: null,
              child: Container(
                  width: 115,
                  child: Column(children: [
                    Image.asset(this.img, height: 36, width: 36),
                    Text(this.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54))
                  ])))));
}
