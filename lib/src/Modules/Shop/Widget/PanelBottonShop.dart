import 'package:flutter/material.dart';

class PanelButtonShop extends StatelessWidget {
  const PanelButtonShop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
