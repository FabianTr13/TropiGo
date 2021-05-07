import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Models/City.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/OrdersUrl.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class ShopService {
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<List<Product>> getProducts() async {
    final String cityId = await getCityId() ?? "1";

    final Response response = await http.post(
        "https://tropigohn.com/api/public/api/app/productos",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"codCiudad": cityId}));
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
          context, MaterialPageRoute(builder: (context) => HomeShop()));

      shopCylinderBlocInstance.changeProductSelect(null);
    } catch (e) {
      print(e);
      showToast("Ocurrio un error al crear su orden: ${e.toString()}",
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
    final List<City> cities = [];

    if (getCities.isNotEmpty) {
      final List<dynamic> cityList = json.decode(getCities);

      for (dynamic city in cityList) {
        cities.add(City(codCiudad: city['codCiudad'], nombre: city['nombre']));
      }
    }
    return cities;
  }

  saveCityId(String cityId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cityId', cityId);
  }

  Future<String> getCityId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getCityId = prefs.getString("cityId");
    return getCityId;
  }

  saveCityName(String cityName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cityName', cityName);
  }

  Future<String> getCityName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getCityName = prefs.getString("cityName");
    return getCityName;
  }
}
