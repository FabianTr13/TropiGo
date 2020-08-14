import 'package:TropiGo/src/Modules/Shop/UI/GasStoresScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/GranelScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/ShopCylinderScreen.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/CardMenuItem.dart';
import 'package:flutter/material.dart';

Widget MenuStores({BuildContext context}) {
  //Unique function to redirec all page with dynamic widget
  gotoMenu(Widget option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => option,
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(left: 5, right: 5),
    child: new Column(
      children: [
        Row(
          children: [
            CardMenuItem(
              imagen: Image.asset('assets/logo/logo.png'),
              callback: () => gotoMenu(ShopCylinderScreen()),
            ),
            CardMenuItem(
              imagen: Image.asset('assets/logo/stores.jpg'),
              callback: () => gotoMenu(GasStoresScreen()),
            )
          ],
        ),
        Row(
          children: [
            CardMenuItem(
              imagen: Image.asset('assets/logo/ganel.png'),
              callback: () => gotoMenu(GranelScreen()),
            ),
            Column(
              children: [
                CardMenuItem(
                  imagen: Image.asset('assets/logo/face.png'),
                  height: 55,
                ),
                CardMenuItem(
                  imagen: Image.asset('assets/logo/insta.png'),
                  height: 55,
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}
