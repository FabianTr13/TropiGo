import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/CarouselShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/Counter.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/ModalConfirmOrder.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ViewMapShop.dart';
import 'package:TropiGo/src/Services/ShopService.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

SlidingUpPanel panelShop(BuildContext context) {
  PanelController _pc = new PanelController();
  ShopService().getProducts();

  return SlidingUpPanel(
      maxHeight: 310,
      minHeight: 60,
      controller: _pc,
      renderPanelSheet: false,
      panel: panelProducts(context),
      collapsed: floatingCollapsedPanel(panelController: _pc),
      body: ViewMapShop());
}

Widget panelProducts(BuildContext context) {
  doBuy() {
    ModalConfirmation().confirmationOrder(context);
  }

  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      child: ListView(children: [
        Container(height: 55),
        Counter(),
        CarouselShop(),
        ButtonLargeSubmit(
            text: "PEDIR",
            callback: doBuy,
            stream: shopCylinderBlocInstance.submitValidShop,
            nullText: "Seleccione un producto")
      ]));
}

Widget floatingCollapsedPanel({PanelController panelController}) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      child: FlatButton(
          onPressed: () => {panelController.open()},
          child: Center(
              child: Text("ORDENAR AHORA",
                  style: TextStyle(color: Colors.white, fontSize: 22)))));
}
