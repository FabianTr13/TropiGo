import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/Headers.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/RowConfirmationModal.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/ShopCylinder/ConfirmationModal/SummaryRow.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:flutter/material.dart';

Future<void> _askedToLead(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTextbox(
                    title: "Direccion",
                    stream: shopCylinderBlocInstance.address,
                    onChange: shopCylinderBlocInstance.changeAddress,
                    hintText:
                        "Escribe aqui Dirección/Referencias, Calle, Avenida. Casa, Color",
                    maxLines: 2,
                    fontSizeHint: 12,
                  ),
                  Container(
                    height: 150,
                    child: Table(
                      children: [
                        HeadersConfirmation(),
                        rowData(
                          product: new Product(
                            description: "Gas LB",
                            count: 2,
                            total: 125.25,
                          ),
                        ),
                        rowData(
                          product: new Product(
                            description: "Gas LB",
                            count: 2,
                            total: 125.25,
                          ),
                        ),
                        rowData(
                          product: new Product(
                            description: "Gas LB",
                            count: 2,
                            total: 125.25,
                          ),
                        ),
                        rowData(
                          product: new Product(
                            description: "Gas LB",
                            count: 2,
                            total: 125.25,
                          ),
                        ),
                        summaryRow(),
                      ],
                    ),
                  ),
                  ButtonRoundBorder(
                    text: "ACEPTAR",
                    callback: () => {},
                    backgroundColor: Colors.red,
                  ),
                  ButtonRoundBorder(
                    text: "Cerrar",
                    callback: () => {},
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
