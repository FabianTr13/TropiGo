import 'package:TropiGo/src/Modules/Contact/UI/ContactScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Modules/Kitchen/UI/KitchenScreen.dart';
import 'package:TropiGo/src/Modules/Tips/TipsScreen.dart';
import 'package:TropiGo/src/Multimedia/tropi_icons_icons.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
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
            tileMode: TileMode.clamp),
      ),
      child: new Column(
        children: [
          Container(
            child: ImageHeader(),
          ),
          ButtonRoundBorder(
            text: "Pide tu cilindro de GAS",
            icon: TropiIcons.corazon,
            callback: () => gotoMenu(HomeShop()),
          ),
          ButtonRoundBorder(
            text: "Cocina con tropi",
            icon: TropiIcons.cocina,
            callback: () => gotoMenu(KitchenScreen()),
          ),
          ButtonRoundBorder(
            text: "Tropi Tips",
            icon: TropiIcons.idea,
            callback: () => gotoMenu(TipsScreen()),
          ),
          ButtonRoundBorder(
            text: "Sugerencias Tropigas",
            icon: TropiIcons.correo,
            callback: () => gotoMenu(ContactScreen()),
          )
        ],
      ),
    );
  }
}
