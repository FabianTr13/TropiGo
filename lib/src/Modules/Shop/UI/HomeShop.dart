import 'package:TropiGo/src/Modules/Shop/Widget/HomeShop/MenuStores.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

class HomeShop extends StatefulWidget {
  @override
  _HomeShopState createState() => _HomeShopState();
}

class _HomeShopState extends State<HomeShop> {
  String imageBackground = "";

  @override
  void initState() {
    super.initState();

    UtilsService().getImageStore(HeaderShopImg).then((value) {
      setState(() {
        imageBackground = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        CachedNetworkImage(
            imageUrl: imageBackground,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container()),
        menuStores(context: context)
      ]));
}
