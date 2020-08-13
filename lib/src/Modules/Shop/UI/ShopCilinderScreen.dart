import 'dart:async';
import 'dart:collection';
import 'package:TropiGo/src/Modules/Shop/Widget/GoogleMap.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/PanelBottonShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/PopupMenuShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/SideMenu.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/SideMenuItem.dart';
import 'package:flutter/material.dart';

class ShopCilinderScreen extends StatefulWidget {
  @override
  State<ShopCilinderScreen> createState() => ShopCilinderState();
}

class ShopCilinderState extends State<ShopCilinderScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.grey),
          actions: <Widget>[
            PopupMenuShop(),
          ],
          backgroundColor: Colors.white,
          title: Center(
            child: Image.asset(
              'assets/logo/logo.png',
              height: 50,
              width: 50,
            ),
          )),
      body: GoogleMapView(),
      drawer: Drawer(child: SideMenu()),
      persistentFooterButtons: [PanelButtonShop()],
    );
  }
}
