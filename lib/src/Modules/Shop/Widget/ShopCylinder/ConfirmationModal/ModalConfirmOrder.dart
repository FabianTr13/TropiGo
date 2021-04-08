import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/PayButton.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/TableProducts.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:TropiGo/src/Services/ShopService.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';

class ModalConfirmation {
  Future<void> confirmationOrder(BuildContext context) async {
    _crearOrden() async {
      await ShopService().createOrder(context);
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
                height: 490,
                child: ListView(children: [
                  Center(
                      child: Text("Confirmar Orden",
                          style: TextStyle(
                              color: TropiColors.orange, fontSize: 22))),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    PayButton(isSelect: true, text: "Efectivo", img: MoneyImg),
                    PayButton(isSelect: false, text: "Tarjeta", img: CreditImg)
                  ]),
                  SizedBox(height: 10),
                  InputTextbox(
                      title: "Direccion",
                      stream: shopCylinderBlocInstance.address,
                      onChange: shopCylinderBlocInstance.changeAddress,
                      hintText:
                          "Escribe aqui Dirección/Referencias, Calle, Avenida. Casa, Color",
                      maxLines: 2,
                      fontSizeHint: 12),
                  Container(height: 200, child: tableProduct()),
                  ButtonLargeSubmit(
                      stream: shopCylinderBlocInstance.submitValidOrder,
                      text: "ACEPTAR",
                      nullText: "Ingrese su dirección",
                      callback: _crearOrden,
                      backgroundColor: TropiColors.orangeButons,
                      height: 40),
                  ButtonRoundBorder(
                      text: "Cerrar",
                      callback: () => Navigator.pop(context),
                      backgroundColor: TropiColors.orangeButons,
                      height: 40,
                      widthPorcent: 0.88)
                ]))));
  }
}
