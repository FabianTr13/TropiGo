import 'dart:async';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/OrdersUrl.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopService {
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<List<Product>> getProducts() async {
    http.Response response = await http
        .get("http://apitropigas.hol.es/apiKio/public/api/productos/34");

    var data = json.decode(response.body);
    // var data = [
    //   {
    //     "codProducto": "43",
    //     "exento": 1,
    //     "nombreProducto": "Gas 10LB",
    //     "impuesto": 0,
    //     "precio": "107.07",
    //     "manejaInventario": "0",
    //     "precioDigitadoManual": "0",
    //     "cantidad": "0"
    //   },
    //   {
    //     "codProducto": "44",
    //     "exento": 1,
    //     "nombreProducto": "Gas 20LB",
    //     "impuesto": 0,
    //     "precio": "214.59",
    //     "manejaInventario": "0",
    //     "precioDigitadoManual": "0",
    //     "cantidad": "0"
    //   },
    //   {
    //     "codProducto": "31",
    //     "exento": 1,
    //     "nombreProducto": "Gas 25LB",
    //     "impuesto": 0,
    //     "precio": "215.46",
    //     "manejaInventario": "0",
    //     "precioDigitadoManual": "0",
    //     "cantidad": "0"
    //   },
    //   {
    //     "codProducto": "39",
    //     "exento": 1,
    //     "nombreProducto": "Gas 60LB",
    //     "impuesto": 0,
    //     "precio": "635.29",
    //     "manejaInventario": "0",
    //     "precioDigitadoManual": "0",
    //     "cantidad": "0"
    //   },
    //   {
    //     "codProducto": "40",
    //     "exento": 1,
    //     "nombreProducto": "Gas 100LB",
    //     "impuesto": 0,
    //     "precio": "1170.61",
    //     "manejaInventario": "0",
    //     "precioDigitadoManual": "0",
    //     "cantidad": "0"
    //   }
    // ];

    shopCylinderBlocInstance.changeProductSelect(null);
    List<Product> products =
        data.map<Product>((item) => new Product(item)).toList();
    shopCylinderBlocInstance.changeProduct(products);
    return products;
  }

  createOrder(BuildContext context) async {
    try {
      String uriOrder = OrdersUrl().getOrder();
      http.Response responseOrder = await http.post(uriOrder);
      var data = json.decode(responseOrder.body);
      var codOrder = data["codOrden"].toString();

      if (codOrder == null) throw Exception("Creando orden");

      //insert del detalle
      List<Product> products = shopCylinderBlocInstance.getProductsSelect();

      products.forEach((Product item) async {
        String uriDetail =
            OrdersUrl().getOrderDetails(product: item, codOrder: codOrder);
        http.Response response = await http.post(uriDetail);

        var detailResult = json.decode(response.body);
        if (detailResult["respuesta"]?.toString() != "true")
          throw Exception("Ocurrio un error al agregar producto");
      });

      //insert del finalizar orden
      String uriEnd = await OrdersUrl().getEndOrder(codOrder: codOrder);
      http.Response response = await http.post(uriEnd);
      var endResult = json.decode(response.body);
      if (endResult["respuesta"]?.toString() != "true")
        throw Exception("Ocurrio un error al agregar datos del cliente");

      // //Insert in firebase
      var orderRef = databaseReference.child("Orders").push();
      orderRef.set(OrdersUrl().orderToFirebase(
        codOrder: codOrder,
      ));

      //InsertOrderLoc
      databaseReference
          .child("OrdersLoc")
          .child(orderRef.key)
          .set(OrdersUrl().orderLocToFirebase());

      showToast(
        "Tu orden fue enviada!",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 10),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeShop(),
        ),
      );

      shopCylinderBlocInstance.changeProductSelect(null);
    } catch (e) {
      print(e);
      showToast(
        "Ocurrio un error al crear su orden: ${e.toString()}",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 20),
      );
    }
  }
}
