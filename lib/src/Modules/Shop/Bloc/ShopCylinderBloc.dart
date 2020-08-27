import 'dart:async';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/Validators.dart/ShopValidator.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class ShopCylinderBloc with ShopValidator {
  final _addressController = BehaviorSubject<String>();
  final _countController = BehaviorSubject<int>.seeded(1);
  final _productsController = BehaviorSubject<List<Product>>();
  final _productSelectController = BehaviorSubject<Product>();
  final _positionController = BehaviorSubject<LocationData>();

  Stream<String> get address => _addressController.stream.transform(validaName);
  Stream<int> get count => _countController.stream.transform(validaCounter);
  Stream<List<Product>> get products =>
      _productsController.stream.transform(validaProduct);
  Stream<Product> get productSelect =>
      _productSelectController.stream.transform(validaProductSelect);
  Stream<bool> get submitValidShop =>
      Rx.combineLatest2(productSelect, count, (e, p) => true);
  Stream<bool> get submitValidOrder =>
      Rx.combineLatest2(address, productSelect, (a, e) => true);
  Stream<LocationData> get location =>
      _positionController.stream.transform(validaLocation);

  Function(String) get changeAddress => _addressController.sink.add;
  Function(int) get changeCount => _countController.sink.add;
  Function(List<Product>) get changeProduct => _productsController.sink.add;
  Function(Product) get changeProductSelect =>
      _productSelectController.sink.add;
  Function(LocationData) get changePosition => _positionController.sink.add;

  selectProduct(Product product) {
    List<Product> productsList = _productsController.value.map((Product item) {
      if (item.codProducto == product.codProducto) {
        item.isSelect = !item.isSelect;

        item.cantidad = item.isSelect ? _countController.value : 0;
        item.total = item.cantidad * item.precio;
        changeCount(1);
        changeProductSelect(item);
      }
      return item;
    }).toList();

    changeProduct(productsList);
  }

  List<Product> getProductsSelect() {
    return _productsController.value
        .where((Product item) => item.isSelect != null && item.isSelect)
        .toList();
  }

  List<Map<String, dynamic>> getProductsSelectJson() {
    return getProductsSelect().map((Product item) => item.toJson()).toList();
  }

  Map<String, dynamic> getTotals() {
    double total = 0;
    _productsController.value.forEach((Product element) {
      if (element.isSelect) {
        total = total + element.total;
      }
    });

    return {
      "impuesto": 0,
      "total": total,
    };
  }

  String getAddress() {
    return _addressController.value;
  }

  LocationData getLocation() {
    return _positionController.value;
  }

  sumMinus(String type) {
    int newValue = 1;
    if (type == "SUM") {
      newValue = _countController.value + 1;
    } else {
      newValue = _countController.value - 1;
      newValue = newValue < 1 ? 1 : newValue;
    }
    changeCount(newValue);
  }

  dispose() {
    _addressController.close();
    _countController.close();
    _productsController.close();
    _productSelectController.close();
    _positionController.close();
  }
}

final shopCylinderBlocInstance = ShopCylinderBloc();
