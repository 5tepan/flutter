import 'package:flutter/material.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

class ProductCardModel extends ChangeNotifier {
  Product? _product;
  bool _isLoading = false;
  String _error = '';

  Product? get product => _product;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadProductDetails(ProductApi productApi, int productId) async {
    try {
      _isLoading = true;
      _product = await productApi.getProductDetails(productId.toString());
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
