import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/CarouselShop.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/ModalConfirmOrder.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/Counter.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ViewMapShop.dart';
import 'package:TropiGo/src/Services/LoadingService.dart';
import 'package:TropiGo/src/Services/ShopService.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:TropiGo/src/Widgets/AppBar/NavBar.dart';
import 'package:TropiGo/src/Widgets/AppBar/SideMenu.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:flutter/material.dart';

class ShopCylinderScreen extends StatefulWidget {
  const ShopCylinderScreen({Key key}) : super(key: key);
  _ShopCylinderScreen createState() => _ShopCylinderScreen();
}

class _ShopCylinderScreen extends State<ShopCylinderScreen> {
  @override
  void initState() {
    super.initState();
  }

  doBuy() async {
    final String getAddress = await UtilsService().getAddress();
    if (getAddress != null && getAddress.isNotEmpty) {
      shopCylinderBlocInstance.changeAddress(getAddress);
    }
    loadingBloc.setIsLoading(false);
    Navigator.pop(context);
    ModalConfirmation().confirmationOrder(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: navBar(),
      drawer: sideMenu(context),
      body: SafeArea(child: _buildUI(context)));

  Widget _buildUI(BuildContext context) => Stack(children: [
        ViewMapShop(),
        Container(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                child: buttonToOrder(),
                onTap: () {
                  ShopService().getProducts();
                  _buildOrderModal(context, doBuy);
                }))
      ]);

  void _buildOrderModal(BuildContext context, VoidCallback doBuy) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) => Container(
            color: Color(0xFF737373),
            child: Container(
                height: 320,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: Column(children: [
                      GestureDetector(
                          child: buttonToOrder(),
                          onTap: () => {Navigator.pop(context)}),
                      SizedBox(height: 5),
                      Counter(),
                      CarouselShop(),
                      SizedBox(height: 5),
                      ButtonLargeSubmit(
                          width: 200,
                          text: "PEDIR",
                          callback: doBuy,
                          stream: shopCylinderBlocInstance.submitValidShop,
                          nullText: "Seleccione un producto")
                    ])),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15))))));
  }

  Widget buttonToOrder() => Container(
      height: 65,
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      child: Center(
          child: Text("ORDENAR AHORA",
              style: TextStyle(color: Colors.white, fontSize: 22))));
}
