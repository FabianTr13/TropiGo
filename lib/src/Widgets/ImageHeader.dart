import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final String title;
  final double size;
  final bool underLine;
  final String image;

  const ImageHeader(
      {this.title = "",
      this.size = 200,
      this.underLine = false,
      this.image = LogoImg});

  @override
  Widget build(BuildContext context) => Container(
          child: Column(children: [
        Container(height: 50),
        Center(
            child:
                Image.asset(this.image, width: this.size, height: this.size)),
        Visibility(
            visible: this.title != "",
            child: Center(
                child: Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 24)))),
        Visibility(
            visible: this.underLine,
            child: Container(
                width: 200,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.white)))))
      ]));
}
