import 'package:flutter/material.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

// TODO: Сделать базовый класс для моделей
// https://dart.dev/language/generics
class ProductListModel extends ChangeNotifier {
  final List<Product> _products = [];
  bool _loading = false;
  int _offset = 0;
  bool _hasMoreData = true;

  List<Product> get products => _products;
  bool get loading => _loading;
  bool get hasMoreData => _hasMoreData;

  Future<void> loadProducts(ProductApi productApi, String categoryId) async {
    if (_loading || !_hasMoreData) {
      return;
    }

    _loading = true;
    // TODO: notifyListeners

    final newData =
        await productApi.getProductList(categoryId, _offset.toString());

    if (newData.isNotEmpty) {
      _products.addAll(newData);
      // TODO: прибавлять кол-во элементов которое пришло с сервера
      _offset += 10;
    } else {
      _hasMoreData = false;
    }

    _loading = false;
    notifyListeners();
  }
}
