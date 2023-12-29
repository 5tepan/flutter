import 'package:flutter/material.dart';
import 'package:shop/repositories/shop_app/api/category_api.dart';
import 'package:shop/repositories/shop_app/models/category.dart';

class CategoryListModel extends ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String _error = '';

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadCategories(CategoryApi categoryApi) async {
    try {
      _isLoading = true;
      _categories = await categoryApi.getCategoryList();
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
