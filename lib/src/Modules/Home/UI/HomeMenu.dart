import 'package:TropiGo/src/Modules/Auth/UI/SignupScreen.dart';
import 'package:TropiGo/src/Modules/Contact/UI/ContactScreen.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Kitchen/UI/KitchenScreen.dart';
import 'package:TropiGo/src/Modules/Tips/TipsScreen.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/buttonLarge.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenu createState() => new _HomeMenu();
}

class _HomeMenu extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height, child: MenuPage());
  }

  gotoShop() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeShop()),
    );
  }

  gotoTips() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TipsScreen()),
    );
  }

  gotoKitchen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KitchenScreen()),
    );
  }

  gotoContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactScreen()),
    );
  }

  Widget MenuPage() {
    return new Scaffold(
      body: Container(
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
              callback: gotoShop,
            ),
            ButtonRoundBorder(
                text: "Cocina con tropi",
                icon: Icons.fastfood,
                callback: gotoKitchen),
            ButtonRoundBorder(
                text: "Tropi Tips",
                icon: Icons.lightbulb_outline,
                callback: gotoTips),
            ButtonRoundBorder(
              text: "Sugerencias Tropigas",
              icon: Icons.email,
              callback: gotoContact,
            )
          ],
        ),
      ),
    );
  }
}
