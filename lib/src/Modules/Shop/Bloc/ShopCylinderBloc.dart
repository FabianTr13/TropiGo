import 'dart:async';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/Validators.dart/ShopValidator.dart';
import 'package:rxdart/rxdart.dart';

class ShopCylinderBloc with ShopValidator {
  final _addressController = BehaviorSubject<String>();
  final _countController = BehaviorSubject<String>();
  final _productsController = BehaviorSubject<List<Product>>();
  final _productSelectController = BehaviorSubject<Product>();

  Stream<String> get address => _addressController.stream.transform(validaName);
  Stream<String> get count => _countController.stream.transform(validaCount);
  Stream<List<Product>> get products =>
      _productsController.stream.transform(validaProduct);
  Stream<Product> get productSelect =>
      _productSelectController.stream.transform(validaProductSelect);

  Stream<bool> get submitValidShop =>
      Rx.combineLatest2(productSelect, count, (e, p) => true);

  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changeCount => _countController.sink.add;
  Function(List<Product>) get changeProduct => _productsController.sink.add;
  Function(Product) get changeProductSelect =>
      _productSelectController.sink.add;

  selectProduct(Product product) {
    List<Product> productsList = _productsController.value.map((Product item) {
      if (item.id == product.id) {
        item.isSelect = item.isSelect == null ? true : !item.isSelect;
        changeProductSelect(item);
      }
      return item;
    }).toList();

    changeProduct(productsList);
  }

  sumMinus(String type) {
    int newValue = 1;
    if (_countController.value != null) {
      if (type == "SUM") {
        newValue = int.parse(_countController.value) + 1;
      } else {
        newValue = int.parse(_countController.value) - 1;
        newValue = newValue < 1 ? 1 : newValue;
      }
    }
    changeCount(newValue.toString());
  }

  dispose() {
    _addressController.close();
    _countController.close();
    _productsController.close();
    _productSelectController.close();
  }
}

final shopCylinderBlocInstance = ShopCylinderBloc();
