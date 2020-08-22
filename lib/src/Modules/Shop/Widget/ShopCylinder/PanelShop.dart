import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/CarouselShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/Counter.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ViewMapShop.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

SlidingUpPanel PanelShop() {
  PanelController _pc = new PanelController();

  return SlidingUpPanel(
    maxHeight: 285,
    minHeight: 60,
    controller: _pc,
    renderPanelSheet: false,
    panel: PanelProducts(),
    collapsed: FloatingCollapsedPanel(
      panelController: _pc,
    ),
    body: ViewMapShop(),
  );
}

Widget PanelProducts() {
  _getData() {
    List<Product> items = [
      Product(
        id: 1,
        price: "107.07",
        description: "Gas 10LB",
        urlImage: CilinderImg,
        count: 0,
      ),
      Product(
        id: 2,
        price: "214.59",
        description: "Gas 20",
        urlImage: CilinderImg,
        count: 0,
      ),
      Product(
        id: 3,
        price: "215.46",
        description: "Gas 25LB",
        urlImage: CilinderImg,
        count: 0,
      ),
      Product(
        id: 4,
        price: "635.29",
        description: "Gas 60LB",
        urlImage: CilinderImg,
        count: 0,
      ),
      Product(
        id: 5,
        price: "1,170.61",
        description: "Gas 100LB",
        urlImage: CilinderImg,
        count: 0,
      ),
    ];

    shopCylinderBlocInstance.changeProduct(items);
  }

  _doBuy() {
    print("comprando");
  }

  _getData();

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
    ),
    child: Column(
      children: [
        Container(
          height: 25,
        ),
        Counter(),
        CarouselShop(),
        ButtonLargeSubmit(
          text: "Realizar pedido",
          callback: _doBuy,
          stream: shopCylinderBlocInstance.submitValidShop,
        ),
      ],
    ),
  );
}

Widget FloatingCollapsedPanel({PanelController panelController}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: FlatButton(
      onPressed: () => {
        panelController.open(),
      },
      child: Center(
        child: Text(
          "ORDENAR AHORA",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    ),
  );
}
