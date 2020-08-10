import 'package:flutter/material.dart';

class CardMenuItem extends StatelessWidget {
  final Image imagen;
  final String text;
  final double size;

  const CardMenuItem({
    Key key,
    this.size = 120,
    this.text = "",
    @required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Container(
        height: this.size,
        width: (MediaQuery.of(context).size.width / 2) - 30,
        alignment: Alignment.center,
        child: this.imagen,
      ),
    );
  }
}
