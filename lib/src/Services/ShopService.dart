import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Models/City.dart';
import 'package:TropiGo/src/Modules/Auth/Models/UserProfile.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/OrdersUrl.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Services/OrderService.dart';
import 'package:TropiGo/src/Services/UtilsService.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ShopService {
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<List<Product>> getProducts() async {
    final String cityId = await orderBloc.getCityId() ?? "1";

    final Response response = await http.post(
        "https://tropigohn.com/api/public/api/app/productos",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, dynamic>{"codCiudad": (cityId.isEmpty) ? "1" : cityId}));
    List<Product> products = [];
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      bool validateData = data is String || data is Map;
      if (!validateData) {
        shopCylinderBlocInstance.changeProductSelect(null);
        products = data.map<Product>((item) => Product(item)).toList();
        shopCylinderBlocInstance.changeProduct(products);
      }
    }
    return products;
  }

  Future<Map> thisUserHasAPendingOrder() async {
    Map result = {"orderPending": false, "withoutDriver": false};

    UserProfile user = await AuthService().getCurrentUser();
    final String orderId = await orderBloc.getOrderId() ?? "";

    final getOrderFromFirebase =
        databaseReference.child("OrdersLoc").child(user.uid);

    final orderValue = await getOrderFromFirebase.onValue.first;
    final order = orderValue.snapshot.value;

    final orderDriver = databaseReference.child("Orders");
    final orderValueDriver = await orderDriver.onValue.first;
    final orderriver = orderValueDriver.snapshot.value;

    Map orderFromDatabase;
    for (var item in orderriver.values) {
      if (item["numOrden"] == orderId) {
        orderFromDatabase = item;
        break;
      }
    }

    result["orderPending"] = (order == null) ? false : true;
    result["withoutDriver"] = (order == null)
        ? false
        : (orderFromDatabase == null)
            ? true
            : orderFromDatabase["driver"].isEmpty;
    return result;
  }

  cancelOrder(BuildContext context) async {
    try {
      final String orderId = await orderBloc.getOrderId() ?? "";
      final UserProfile user = await AuthService().getCurrentUser();
      final String uriOrder = OrdersUrl().cancelOrder();

      // //Insert in firebase
      // var orderRef = databaseReference.child("Orders").push();
      // orderRef.remove();

      //remove OrderLoc
      databaseReference.child("OrdersLoc").child(user.uid).remove();

      final String orderBody = jsonEncode(<String, dynamic>{
        "codOrden": orderId,
        "observacion": shopCylinderBlocInstance.getObservation() ?? ""
      });

      final Response response = await http.post(uriOrder,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: orderBody);

      if (response.statusCode != 200) {
        throw Exception("cancelar orden");
      }

      showToast("Tu orden fue cancelada!",
          backgroundColor: Colors.green, duration: Duration(seconds: 10));

      Navigator.pop(context);
    } catch (e) {
      print(e);
      showToast("Ocurrió un error al cancelar su orden",
          backgroundColor: Colors.red, duration: Duration(seconds: 20));
    }
  }

  createOrder(BuildContext context) async {
    try {
      String uriOrder = OrdersUrl().getOrder();
      UserProfile user = await AuthService().getCurrentUser();
      LocationData location = shopCylinderBlocInstance.getLocation();

      final String orderBody = jsonEncode(<String, dynamic>{
        "codTienda": 34,
        "estacion": "tropigo",
        "latitud": location.latitude.toString(),
        "longitud": location.longitude.toString(),
        "keyUser": user.uid
      });

      final Response responseOrder = await http.post(uriOrder,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: orderBody);
      var data = json.decode(responseOrder.body);

      final String codOrder = data["codOrden"].toString();
      if (codOrder == null) {
        throw Exception("Creando orden");
      }

      orderBloc.saveOrderId(codOrder);

      //insert del detalle
      List<Product> products = shopCylinderBlocInstance.getProductsSelect();

      products.forEach((Product item) async {
        final String uriDetail = OrdersUrl().getOrderDetails();

        final String body = jsonEncode(<String, dynamic>{
          "codOrden": int.parse(codOrder),
          "codProducto": int.parse(item.codProducto),
          "cantidad": item.cantidad,
          "precio": item.precio.toString()
        });

        final Response response = await http.post(uriDetail,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: body);

        final detailResult = json.decode(response.body);
        if (detailResult["respuesta"]?.toString() != "true") {
          throw Exception("Ocurrio un error al agregar producto");
        }
      });

      //insert del finalizar orden
      String uriEnd = OrdersUrl().getEndOrder();

      final String body = jsonEncode(<String, dynamic>{
        "codOrden": int.parse(codOrder),
        "telefono": user.phoneNumber ?? " ",
        "nombre": user.name ?? " ",
        "rtn": " ",
        "codColonia": 1,
        "codRepartidor": 1,
        "direccion": shopCylinderBlocInstance.getAddress() ?? "",
        "formaPago": "ef",
        "cantidadRecibidaEfectivo": 0
      });
      UtilsService().saveAddress(shopCylinderBlocInstance.getAddress());

      final Response response = await http.post(uriEnd,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
      var endResult = json.decode(response.body);
      if (endResult["respuesta"]?.toString() != "true")
        throw Exception("Ocurrio un error al agregar datos del cliente");

      // //Insert in firebase
      var orderRef = databaseReference.child("Orders").push();
      orderRef.set(OrdersUrl().orderToFirebase(codOrder: codOrder));

      //InsertOrderLoc
      databaseReference
          .child("OrdersLoc")
          .child(user.uid)
          .set(OrdersUrl().orderLocToFirebase());

      showToast("Tu orden fue enviada!",
          backgroundColor: Colors.green, duration: Duration(seconds: 10));
      Navigator.pop(context);

      shopCylinderBlocInstance.changeProductSelect(null);
    } catch (e) {
      print(e);
      showToast("Ocurrió un error al crear su orden",
          backgroundColor: Colors.red, duration: Duration(seconds: 20));
    }
  }

  Future<List<City>> getCities() async {
    final Response response = await http.post(
        "https://tropigohn.com/api/public/api/app/ciudades",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"codTienda ": 0}));

    if (response.statusCode == 200) {
      return buildCities(response.body);
    } else {
      return [];
    }
  }

  List<City> buildCities(String getCities) {
    List<City> cities = [];

    if (getCities.isNotEmpty) {
      final List<dynamic> cityList = json.decode(getCities);

      for (var city in cityList) {
        cities.add(City(codCiudad: city['codCiudad'], nombre: city['nombre']));
      }
    }
    return cities;
  }
}
