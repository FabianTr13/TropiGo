import 'package:flutter/material.dart';

class CardMenuItem extends StatelessWidget {
  final Image imagen;
  final double height;
  final VoidCallback callback;
  final Color background;
  final double radius;
  final String text;

  const CardMenuItem({
    Key key,
    this.height = 100,
    @required this.imagen,
    this.callback,
    this.background = Colors.white,
    this.radius = 25,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(this.radius),
        ),
      ),
      child: Container(
          height: this.height,
          width: (MediaQuery.of(context).size.width / 2) - 30,
          alignment: Alignment.center,
          child: FlatButton(
            child: this.imagen,
            onPressed: callback,
          )),
    );
  }
}
