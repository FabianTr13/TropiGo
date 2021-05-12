import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:TropiGo/src/Services/LoadingService.dart';
import 'package:TropiGo/src/Services/ShopService.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/run-loading.dart';
import 'package:flutter/material.dart';

class ModalCancelOrder {
  Future<void> cancelOrder(BuildContext context) async {
    cancelOrden() async {
      final String getObservation = shopCylinderBlocInstance.getObservation();

      if (getObservation != null && getObservation.isNotEmpty) {
        loadingBloc.setIsLoading(true);
        await ShopService().cancelOrder(context);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeShop()));
      }
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
                height: 240,
                child: Stack(children: [
                  ListView(children: [
                    Center(
                        child: Text("Cancelar Orden",
                            style: TextStyle(
                                color: TropiColors.orange, fontSize: 22))),
                    SizedBox(height: 10),
                    InputTextbox(
                        title: "Observación",
                        stream: shopCylinderBlocInstance.observation,
                        onChange: shopCylinderBlocInstance.changeObservation,
                        hintText:
                            "Escribe aqui porque desea cancelar la orden...",
                        maxLines: 2,
                        fontSizeHint: 12),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                        height: 40,
                        child: Row(children: [
                          Expanded(
                              child: Container(
                                  height: 50,
                                  child: RaisedButton(
                                      color: TropiColors.orangeButons,
                                      disabledColor: TropiColors.orangeButons,
                                      onPressed: () => cancelOrden(),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5))),
                                      child: Text("Aceptar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)))))
                        ])),
                    ButtonRoundBorder(
                        text: "Cerrar",
                        callback: () => Navigator.pop(context),
                        backgroundColor: TropiColors.orangeButons,
                        height: 40,
                        widthPorcent: 0.88)
                  ]),
                  RunLoading()
                ]))));
  }
}
