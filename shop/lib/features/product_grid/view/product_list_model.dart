import 'package:flutter/material.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

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

    final newData = await productApi.getProductList(categoryId, _offset.toString());

    if (newData != null && newData.isNotEmpty) {
      _products.addAll(newData);
      _offset += 10;
    } else {
      _hasMoreData = false;
    }

    _loading = false;
    notifyListeners();
  }
}
