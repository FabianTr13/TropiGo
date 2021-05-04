import 'package:TropiGo/src/Modules/Shop/UI/GasStoresScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/GranelScreen.dart';
import 'package:TropiGo/src/Modules/Shop/UI/ShopCylinderScreen.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/HomeShop/MenuItem.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:url_launcher/url_launcher.dart';

Widget menuStores({BuildContext context}) {
  gotoMenu(Widget option) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => option));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast("No se pudo contactar al proveedor");
    }
  }

  return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(children: [
        Row(children: [
          CardMenuItem(
              imagen: Image.asset(LogoImg),
              callback: () => gotoMenu(ShopCylinderScreen())),
          CardMenuItem(
              imagen: Image.asset(GasVehicularImg),
              callback: () => gotoMenu(GasStoresScreen()))
        ]),
        Row(children: [
          CardMenuItem(
              imagen: Image.asset(GranelImg),
              callback: () => gotoMenu(GranelScreen())),
          Column(children: [
            CardMenuItem(
                imagen: Image.asset(FacebookImg),
                height: 44,
                callback: () =>
                    _launchURL('https://www.facebook.com/TropigasHND/')),
            CardMenuItem(
                imagen: Image.asset(InstagranImg),
                height: 44,
                callback: () => _launchURL(
                    'https://www.instagram.com/tropigashn/?hl=es-la'))
          ])
        ])
      ]));
}
