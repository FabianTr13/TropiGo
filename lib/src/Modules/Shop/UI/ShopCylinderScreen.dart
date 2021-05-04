import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/PanelShop.dart';
import 'package:TropiGo/src/Widgets/AppBar/NavBar.dart';
import 'package:TropiGo/src/Widgets/AppBar/SideMenu.dart';
import 'package:flutter/material.dart';

class ShopCylinderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: navBar(), drawer: sideMenu(context), body: panelShop(context));
}
