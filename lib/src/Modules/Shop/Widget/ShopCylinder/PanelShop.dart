import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/CarouselShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/Counter.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/GoogleMap.dart';
import 'package:TropiGo/src/Widgets/ButtonLarge.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

SlidingUpPanel PanelShop() {
  PanelController _pc = new PanelController();
  return SlidingUpPanel(
    maxHeight: 350,
    minHeight: 60,
    controller: _pc,
    renderPanelSheet: false,
    panel: PanelProducts(),
    collapsed: FloatingCollapsedPanel(
      panelController: _pc,
    ),
    body: GoogleMapView(),
  );
}

Widget PanelProducts() {
  _agregar() {
    List<Product> items = [
      Product(
        id: 1,
        price: "100",
        description: "Gas 10L",
        urlImage: "assets/logo/cilynder.png",
      ),
      Product(
        id: 2,
        price: "154",
        description: "Gas 10L",
        urlImage: "assets/logo/cilynder.png",
      ),
      Product(
        id: 3,
        price: "151",
        description: "Gas 10L",
        urlImage: "assets/logo/cilynder.png",
      ),
      Product(
        id: 4,
        price: "111",
        description: "Gas 10L",
        urlImage: "assets/logo/cilynder.png",
      ),
      Product(
        id: 5,
        price: "155",
        description: "Gas 10L",
        urlImage: "assets/logo/cilynder.png",
      ),
    ];

    shopCylinderBlocInstance.changeProduct(items);
  }

  _doBuy() {
    print("comprando");
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
    ),
    child: Column(
      children: [
        InputTextbox(
          title: "Direccion",
          stream: shopCylinderBlocInstance.address,
          onChange: shopCylinderBlocInstance.changeAddress,
        ),
        Counter(),
        CarouselShop(),
        ButtonLargeSubmit(
          text: "Realizar pedido",
          callback: _doBuy,
          stream: shopCylinderBlocInstance.submitValidShop,
        ),
        ButtonLarge(
          text: "agg",
          callback: _agregar,
        )
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