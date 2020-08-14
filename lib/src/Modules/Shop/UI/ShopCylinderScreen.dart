import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/PanelShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/AppBar/NavBar.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/AppBar/SideMenu.dart';
import 'package:flutter/material.dart';

class ShopCylinderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      drawer: SideMenu(),
      body: PanelShop(),
    );
  }
}