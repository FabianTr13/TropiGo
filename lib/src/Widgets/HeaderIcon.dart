import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';

class HeaderIcon extends StatelessWidget {
  final String title;
  final String imagen;

  HeaderIcon({
    this.title = "",
    this.imagen = LogoImg,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 80,
          ),
          Center(
            child: Image.asset(
              this.imagen,
              width: 80,
              height: 80,
            ),
          ),
          Container(
            height: 15,
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(
              top: 10,
              bottom: 50,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
