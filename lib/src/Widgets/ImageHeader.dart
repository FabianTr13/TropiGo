import 'package:TropiGo/src/Multimedia/IconsTropiGo.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final String title;

  ImageHeader({this.title = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(height: 30),
          Center(
            child: Image.asset(
              LogoImg,
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
