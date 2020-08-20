import 'package:TropiGo/src/Modules/Shop/Widget/HomeShop/MenuStores.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import "package:flutter/material.dart";

class HomeShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(HeaderShopImg),
          MenuStores(context: context),
        ],
      ),
    );
  }
}
