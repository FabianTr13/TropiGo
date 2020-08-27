import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Models/OrdersUrl.dart';
import 'package:TropiGo/src/Modules/Auth/Models/UserProfile.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopService {
  Future<List<Product>> getProducts() async {
    // http.Response response = await http
    //     .get("http://apitropigas.hol.es/apiKio/public/api/productos/34");

    // var data = json.decode(response.body);
    var data = [
      {
        "codProducto": "43",
        "exento": 1,
        "nombreProducto": "Gas 10LB",
        "impuesto": 0,
        "precio": "107.07",
        "manejaInventario": "0",
        "precioDigitadoManual": "0",
        "cantidad": "0"
      },
      {
        "codProducto": "44",
        "exento": 1,
        "nombreProducto": "Gas 20LB",
        "impuesto": 0,
        "precio": "214.59",
        "manejaInventario": "0",
        "precioDigitadoManual": "0",
        "cantidad": "0"
      },
      {
        "codProducto": "31",
        "exento": 1,
        "nombreProducto": "Gas 25LB",
        "impuesto": 0,
        "precio": "215.46",
        "manejaInventario": "0",
        "precioDigitadoManual": "0",
        "cantidad": "0"
      },
      {
        "codProducto": "39",
        "exento": 1,
        "nombreProducto": "Gas 60LB",
        "impuesto": 0,
        "precio": "635.29",
        "manejaInventario": "0",
        "precioDigitadoManual": "0",
        "cantidad": "0"
      },
      {
        "codProducto": "40",
        "exento": 1,
        "nombreProducto": "Gas 100LB",
        "impuesto": 0,
        "precio": "1170.61",
        "manejaInventario": "0",
        "precioDigitadoManual": "0",
        "cantidad": "0"
      }
    ];

    List<Product> products =
        data.map<Product>((item) => new Product(item)).toList();
    shopCylinderBlocInstance.changeProduct(products);
    return products;
  }

  createOrder() async {
    String uriOrder = OrdersUrl().getOrder();
    http.Response responseOrder = await http.post(uriOrder);
    var data = json.decode(responseOrder.body);
    var codOrder = data['codOrder'];

    //insert del detalle
    List<Product> products = await shopCylinderBlocInstance.getProductsSelect();

    products.forEach((Product item) async {
      String uriDetail =
          OrdersUrl().getOrderDetails(product: item, codOrder: codOrder);

      http.Response response = await http.post(uriDetail);

      var detailResult = json.decode(response.body);
    });

    //insert del finalizar orden

    String uriEnd = await OrdersUrl().getEndOrder(codOrder: codOrder);
    http.Response response = await http.post(uriEnd);
    var endResult = json.decode(response.body);
  }
}
