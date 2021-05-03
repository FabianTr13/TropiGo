import 'package:flutter/material.dart';

class ButtonRoundBorder extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final IconData icon;
  final VoidCallback callback;
  final double width;
  final double radius;
  final double fontSize;
  final double height;
  final double widthPorcent;
  final String img;

  const ButtonRoundBorder(
      {Key key,
      this.text = "Boton",
      this.callback,
      this.color = Colors.white,
      this.icon,
      this.backgroundColor = Colors.transparent,
      this.width = 1,
      this.radius = 25,
      this.fontSize = 16,
      this.height = 60,
      this.widthPorcent = 0.85,
      this.img = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
      child: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          height: this.height,
          width: (MediaQuery.of(context).size.width * this.widthPorcent),
          child: Row(children: [
            Expanded(
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(this.radius),
                        side: BorderSide(
                            color: Colors.white.withOpacity(0.8),
                            width: this.width)),
                    color: this.backgroundColor,
                    onPressed: this.callback,
                    child: Row(children: [
                      Visibility(
                          visible: this.icon != null,
                          child:
                              Icon(this.icon, color: Colors.white, size: 35)),
                      Visibility(
                          visible: this.img != "",
                          child: Image.asset(this.img, height: 45, width: 45)),
                      SizedBox(height: 60),
                      Expanded(
                          child: Text(this.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: this.color, fontSize: this.fontSize)))
                    ])))
          ])));
}
