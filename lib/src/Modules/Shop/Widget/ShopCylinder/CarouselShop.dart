import 'dart:ui';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselShop extends StatefulWidget {
  @override
  _CarouselShopState createState() => _CarouselShopState();
}

class _CarouselShopState extends State<CarouselShop> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: shopCylinderBlocInstance.products,
      builder: (context, snapshot) => CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 0.27,
          height: 130.0,
          disableCenter: true,
        ),
        items: snapshot.data?.map<Widget>((Product product) {
          return Builder(builder: (BuildContext context) {
            return ItemSHOP(product);
          });
        })?.toList(),
      ),
    );
  }

  Widget ItemSHOP(Product product) {
    return Container(
      width: ((MediaQuery.of(context).size.width - 80) / 3),
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: product.isSelect == null || !product.isSelect
                  ? Colors.orange
                  : Colors.green,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.grey,
          child: FlatButton(
            onPressed: () {
              shopCylinderBlocInstance.selectProduct(product);
            },
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    product.urlImage,
                    height: 70,
                    width: 80,
                  ),
                  Text(product.description),
                  Text(product.price),
                ],
              ),
            ),
          )),
    );
  }
}
