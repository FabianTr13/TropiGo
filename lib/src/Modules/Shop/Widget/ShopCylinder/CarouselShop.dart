import 'dart:ui';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselShop extends StatefulWidget {
  @override
  _CarouselShopState createState() => _CarouselShopState();
}

class _CarouselShopState extends State<CarouselShop> {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: shopCylinderBlocInstance.products,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              height: 135.0, child: Center(child: CircularProgressIndicator()));
        }

        return CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
                initialPage: 1,
                viewportFraction: 0.27,
                height: 135.0,
                disableCenter: true),
            items: snapshot.data?.map<Widget>((Product product) {
              return Builder(builder: (BuildContext context) {
                return itemSHOP(product);
              });
            })?.toList());
      });

  Widget itemSHOP(Product product) => Container(
      child: Card(
          color: product.isSelect == null || !product.isSelect
              ? Colors.white
              : Colors.deepOrangeAccent.withAlpha(70),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orangeAccent),
              borderRadius: BorderRadius.circular(10)),
          shadowColor: Colors.orange,
          child: FlatButton(
              onPressed: () {
                shopCylinderBlocInstance.selectProduct(product);
              },
              child: Container(
                  child: ListView(children: [
                SizedBox(height: 8),
                Image.asset(CilinderImg, height: 65, width: 65),
                Text(product.nombreProducto, textAlign: TextAlign.center),
                Text(product.precio.toString(), textAlign: TextAlign.center)
              ])))));
}
