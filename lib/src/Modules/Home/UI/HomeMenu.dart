import 'package:TropiGo/src/Modules/Contact/UI/ContactScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Kitchen/UI/KitchenScreen.dart';
import 'package:TropiGo/src/Modules/Tips/TipsScreen.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gotoMenu(Widget option) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => option,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.yellow, Colors.deepOrange],
              begin: const FractionalOffset(0, 0.9),
              end: const FractionalOffset(0, 0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: new Column(
        children: <Widget>[
          Divider(height: 30),
          Container(
            child: Center(
                child: Image.asset(
              'assets/logo/logo.png',
              width: 250,
              height: 250,
            )),
          ),
          ButtonRoundBorder(
            text: "Pide tu cilindro de GAS",
            icon: Icons.favorite,
            callback: () => gotoMenu(HomeShop()),
          ),
          ButtonRoundBorder(
            text: "Cocina con tropi",
            icon: Icons.fastfood,
            callback: () => gotoMenu(KitchenScreen()),
          ),
          ButtonRoundBorder(
            text: "Tropi Tips",
            icon: Icons.lightbulb_outline,
            callback: () => gotoMenu(TipsScreen()),
          ),
          ButtonRoundBorder(
            text: "Sugerencias Tropigas",
            icon: Icons.email,
            callback: () => gotoMenu(ContactScreen()),
          )
        ],
      ),
    );
  }
}
