import 'package:flutter/material.dart';

class CardMenuItem extends StatelessWidget {
  final Image imagen;
  final double height;
  final VoidCallback callback;

  const CardMenuItem({
    Key key,
    this.height = 120,
    @required this.imagen,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
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
