import 'package:TropiGo/src/Multimedia/IconsTropiGo.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final String title;
  final double size;

  ImageHeader({this.title = "", this.size = 200});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(height: 50),
          Center(
            child: Image.asset(
              LogoImg,
              width: this.size,
              height: this.size,
            ),
          ),
          Visibility(
            visible: this.title != "",
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
