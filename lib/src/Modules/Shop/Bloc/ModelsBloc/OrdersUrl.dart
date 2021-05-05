import 'package:TropiGo/src/Modules/Auth/Models/UserProfile.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

const _baseOrder = 'https://tropigohn.com/api/public/api/ordenes/';

class OrdersUrl {
  String getOrder() => '${_baseOrder}nuevaOrden?codTienda=34&estacion=tropigo';

  String getOrderDetails({
    @required Product product,
    @required String codOrder,
  }) =>
      '${_baseOrder}agregaDetalleOrden?codOrden=$codOrder&codProducto=${product.codProducto}&cantidad=${product.cantidad}';

  Future<String> getEndOrder({@required String codOrder}) async {
    UserProfile user = await AuthService().getCurrentUser();
    String address = shopCylinderBlocInstance.getAddress();
    return '${_baseOrder}finalizaOrden?telefono=${user.phoneNumber}&nombre=${user.name}&rtn=00000000000&codColonia=1&codRepartidor=1&codOrden=$codOrder&direccion=$address&formaPago=ef&cantidadRecibidaEfectivo=0';
  }

  Map<String, dynamic> orderToFirebase({String codOrder}) => {
        "details": shopCylinderBlocInstance.getProductsSelectJson(),
        "driver": "",
        "numOrden": codOrder,
        "totals": shopCylinderBlocInstance.getTotals()
      };

  Map<String, dynamic> orderLocToFirebase() {
    LocationData location = shopCylinderBlocInstance.getLocation();
    return {
      "g": "",
      "l": [location.latitude.toString(), location.longitude.toString()]
    };
  }
}
