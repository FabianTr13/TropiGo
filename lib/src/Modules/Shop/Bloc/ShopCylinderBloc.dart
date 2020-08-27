import 'dart:async';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/Validators.dart/ShopValidator.dart';
import 'package:rxdart/rxdart.dart';

class ShopCylinderBloc with ShopValidator {
  final _addressController = BehaviorSubject<String>();
  final _countController = BehaviorSubject<int>.seeded(1);
  final _productsController = BehaviorSubject<List<Product>>();
  final _productSelectController = BehaviorSubject<Product>();

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

  Function(String) get changeAddress => _addressController.sink.add;
  Function(int) get changeCount => _countController.sink.add;
  Function(List<Product>) get changeProduct => _productsController.sink.add;
  Function(Product) get changeProductSelect =>
      _productSelectController.sink.add;

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

  Future<List<Product>> getProductsSelect() async {
    return _productsController.value.map((Product item) {
      if (item.isSelect) {
        return item;
      }
    }).toList();
  }

  Future<String> getAddress() async {
    return _addressController.value;
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
  }
}

final shopCylinderBlocInstance = ShopCylinderBloc();
