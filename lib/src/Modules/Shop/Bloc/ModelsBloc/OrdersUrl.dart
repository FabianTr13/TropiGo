import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:location/location.dart';

const _baseOrder = 'https://tropigohn.com/api/public/api/app/';

class OrdersUrl {
  String getOrder() => '${_baseOrder}nuevaOrden';

  String getOrderDetails() => '${_baseOrder}agregaDetalleOrden';

  String getEndOrder() => '${_baseOrder}finalizarOrden';

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
