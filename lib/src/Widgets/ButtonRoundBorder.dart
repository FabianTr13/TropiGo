import 'package:flutter/material.dart';

class ButtonRoundBorder extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final IconData icon;
  final VoidCallback callback;
  final double marginRound;

  const ButtonRoundBorder({
    Key key,
    this.text = "Boton",
    this.callback,
    this.color = Colors.white,
    this.icon,
    this.backgroundColor = Colors.transparent,
    this.marginRound = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
      height: 60,
      width: (MediaQuery.of(context).size.width * 0.8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(this.marginRound),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    )),
                color: this.backgroundColor,
                onPressed: this.callback,
                child: Row(
                  children: [
                    Icon(
                      this.icon,
                      color: Colors.white,
                      size: 35,
                    ),
                    Divider(
                      height: 60,
                    ),
                    Expanded(
                      child: Text(
                        this.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: this.color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
